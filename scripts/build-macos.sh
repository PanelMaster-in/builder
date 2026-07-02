#!/bin/bash
set -e

VERSION=$1
if [ -z "$VERSION" ]; then
  echo "Usage: $0 <php-version>"
  exit 1
fi

MINOR=$(echo "$VERSION" | cut -d. -f1-2)

ARCH=$(uname -m)
if [ "$ARCH" = "x86_64" ]; then
  PLATFORM_ARCH="x64"
else
  PLATFORM_ARCH="arm64"
fi

echo "==> Building PHP $VERSION (branch $MINOR) for macOS-$PLATFORM_ARCH"

SRC_DIR="/tmp/php-src"
DIST_DIR="/tmp/php-dist"
OUTPUT_DIR="$(pwd)/output"
EXT_STAGE_DIR="/tmp/ext-stage"

rm -rf "$SRC_DIR" "$DIST_DIR" "$EXT_STAGE_DIR"
mkdir -p "$SRC_DIR" "$DIST_DIR" "$EXT_STAGE_DIR" "$OUTPUT_DIR"

# ── Resolve Homebrew prefix (differs on Intel vs Apple Silicon) ───────────────
BREW_PREFIX="$(brew --prefix)"
CPU_CORES="$(sysctl -n hw.ncpu)"

# Ensure Homebrew bison is on PATH (macOS ships ancient bison 2.3)
export PATH="$BREW_PREFIX/opt/bison/bin:$PATH"
export PKG_CONFIG_PATH="$BREW_PREFIX/opt/openssl@3/lib/pkgconfig:$BREW_PREFIX/opt/curl/lib/pkgconfig:$BREW_PREFIX/opt/libzip/lib/pkgconfig:$BREW_PREFIX/opt/icu4c/lib/pkgconfig:$BREW_PREFIX/opt/oniguruma/lib/pkgconfig:$BREW_PREFIX/opt/libiconv/lib/pkgconfig:$PKG_CONFIG_PATH"
export CXXFLAGS="-std=c++17"

# libiconv path — Homebrew's libiconv is keg-only, not symlinked to /usr/local
ICONV_PREFIX="$BREW_PREFIX/opt/libiconv"

# ── Download source ────────────────────────────────────────────────────────────
echo "==> Downloading PHP $VERSION source..."
curl -fsSL "https://www.php.net/distributions/php-${VERSION}.tar.gz" -o /tmp/php.tar.gz
tar -xf /tmp/php.tar.gz -C "$SRC_DIR" --strip-components=1
rm /tmp/php.tar.gz

# Apply OpenSSL 3 compatibility patch for PHP 7.4 / 8.0 on macOS
if [[ "$MINOR" == "7.4" || "$MINOR" == "8.0" ]]; then
  echo "==> Applying OpenSSL 3 compatibility patch..."
  perl -pi -e 's/RSA_SSLV23_PADDING/RSA_PKCS1_PADDING/g' "$SRC_DIR/ext/openssl/openssl.c" || true
fi

cd "$SRC_DIR"
./buildconf --force 2>/dev/null

# ── Configure ─────────────────────────────────────────────────────────────────
echo "==> Configuring PHP $VERSION..."

if [[ "$MINOR" == "7.4" ]]; then
  ZIP_FLAG="--enable-zip"
  LIBXML_FLAG="--with-libxml"
else
  ZIP_FLAG="--with-zip=$BREW_PREFIX/opt/libzip"
  LIBXML_FLAG=""
fi

./configure \
  --prefix="$DIST_DIR" \
  --enable-cli \
  --enable-fpm \
  --enable-opcache=shared \
  --enable-mbstring=shared \
  --enable-bcmath=shared \
  --enable-intl=shared \
  $ZIP_FLAG \
  --enable-sockets=shared \
  --enable-soap=shared \
  --enable-xml=shared \
  --enable-simplexml=shared \
  --enable-xmlreader=shared \
  --enable-xmlwriter=shared \
  --enable-dom=shared \
  --with-openssl="$BREW_PREFIX/opt/openssl@3" \
  --with-curl="$BREW_PREFIX/opt/curl" \
  --with-iconv="$ICONV_PREFIX" \
  --with-zlib \
  --with-mysqli=shared \
  --with-pdo-mysql=shared \
  --with-sqlite3=shared \
  --with-pdo-sqlite=shared \
  $LIBXML_FLAG

echo "==> Compiling PHP Core (this takes a while)..."
make -j$CPU_CORES
make install

# ── Helper: pick the right PECL version ───────────────────────────────────────
pecl_version_for() {
  local pkg="$1"
  case "$pkg" in
    redis)
      case "$MINOR" in
        8.5) echo "6.3.0" ;;
        8.4) echo "6.2.0" ;;
        *)   echo "6.0.2" ;;
      esac
      ;;
    xdebug)
      case "$MINOR" in
        8.5|8.4) echo "3.5.3" ;;
        7.4)     echo "3.1.6" ;;
        *)       echo "3.4.4" ;;
      esac
      ;;
    mongodb)
      case "$MINOR" in
        7.4|8.0) echo "1.21.0" ;;
        *)       echo "2.3.3" ;;
      esac
      ;;
    imagick) echo "3.8.1" ;;
  esac
}

# ── Compile a PECL extension ──────────────────────────────────────────────────
compile_pecl_extension() {
  local ext_name="$1"
  local ext_version
  ext_version=$(pecl_version_for "$ext_name")
  local config_opts="${2:-}"

  echo "==> Building PECL/${ext_name} ${ext_version} for PHP ${VERSION}..."
  local ext_dir="/tmp/pecl-${ext_name}"
  rm -rf "$ext_dir"
  mkdir -p "$ext_dir"

  local tgz_url="https://pecl.php.net/get/${ext_name}-${ext_version}.tgz"
  if ! curl -fsSL "$tgz_url" -o /tmp/pecl.tgz 2>/dev/null; then
    echo "    [SKIP] ${ext_name} ${ext_version} not downloadable"
    return 0
  fi

  tar -xf /tmp/pecl.tgz -C "$ext_dir" --strip-components=1
  rm /tmp/pecl.tgz

  cd "$ext_dir"
  "$DIST_DIR/bin/phpize" --clean >/dev/null 2>&1 || true
  "$DIST_DIR/bin/phpize"
  ./configure --with-php-config="$DIST_DIR/bin/php-config" $config_opts

  if ! make -j$CPU_CORES; then
    echo "    [WARN] ${ext_name} failed to compile — skipping"
    cd "$SRC_DIR"
    return 0
  fi

  mkdir -p "$EXT_STAGE_DIR/$ext_name"
  cp "modules/${ext_name}.so" "$EXT_STAGE_DIR/$ext_name/"
  echo "extension=${ext_name}.so" > "$EXT_STAGE_DIR/$ext_name/${ext_name}.ini"
  echo "    [OK] ${ext_name}.so"

  cd "$SRC_DIR"
}

# ── Build PECL extensions ─────────────────────────────────────────────────────
compile_pecl_extension "redis"
compile_pecl_extension "xdebug"
compile_pecl_extension "mongodb"
compile_pecl_extension "imagick" || true

# ── Move built shared core extensions to staging ──────────────────────────────
PHP_EXT_DIR="$("$DIST_DIR/bin/php-config" --extension-dir)"
echo "==> Staging shared core extensions from $PHP_EXT_DIR..."

core_exts=(
  opcache mbstring bcmath intl zip sockets soap
  xml simplexml xmlreader xmlwriter dom
  openssl curl mysqli pdo_mysql sqlite3 pdo_sqlite
)

for ext in "${core_exts[@]}"; do
  ext_so="$PHP_EXT_DIR/${ext}.so"
  if [ -f "$ext_so" ]; then
    mkdir -p "$EXT_STAGE_DIR/$ext"
    mv "$ext_so" "$EXT_STAGE_DIR/$ext/"
    if [ "$ext" = "opcache" ]; then
      echo "zend_extension=opcache.so" > "$EXT_STAGE_DIR/$ext/${ext}.ini"
    else
      echo "extension=${ext}.so" > "$EXT_STAGE_DIR/$ext/${ext}.ini"
    fi
    echo "    [OK] $ext"
  fi
done

# ── Package each extension independently ─────────────────────────────────────
echo "==> Packaging extensions..."
for ext_dir in "$EXT_STAGE_DIR"/*/; do
  ext="${ext_dir%/}"
  ext="${ext##*/}"
  tar -czf "$OUTPUT_DIR/ext-${VERSION}-${ext}-macos-${PLATFORM_ARCH}.tar.gz" \
    -C "$EXT_STAGE_DIR/$ext" .
  echo "    -> ext-${VERSION}-${ext}-macos-${PLATFORM_ARCH}.tar.gz"
done

# ── Package PHP Core ──────────────────────────────────────────────────────────
echo "==> Packaging PHP Core..."
tar -czf "$OUTPUT_DIR/php-${VERSION}-macos-${PLATFORM_ARCH}.tar.gz" \
  -C "$DIST_DIR" .
echo "    -> php-${VERSION}-macos-${PLATFORM_ARCH}.tar.gz"

echo "==> Done. Output files:"
ls -lh "$OUTPUT_DIR/"