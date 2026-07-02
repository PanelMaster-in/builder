#!/bin/bash
set -e

VERSION=$1
if [ -z "$VERSION" ]; then
  echo "Usage: $0 <php-version>"
  exit 1
fi

# Parse minor version for compat decisions (e.g. "8.4" from "8.4.23")
MINOR=$(echo "$VERSION" | cut -d. -f1-2)

ARCH=$(uname -m)
if [ "$ARCH" = "x86_64" ]; then
  PLATFORM_ARCH="x64"
else
  PLATFORM_ARCH="arm64"
fi

echo "==> Building PHP $VERSION (branch $MINOR) for Linux-$PLATFORM_ARCH"

SRC_DIR="/tmp/php-src"
DIST_DIR="/tmp/php-dist"
OUTPUT_DIR="$(pwd)/output"
EXT_STAGE_DIR="/tmp/ext-stage"

rm -rf "$SRC_DIR" "$DIST_DIR" "$EXT_STAGE_DIR"
mkdir -p "$SRC_DIR" "$DIST_DIR" "$EXT_STAGE_DIR" "$OUTPUT_DIR"

# ── Download source ────────────────────────────────────────────────────────────
echo "==> Downloading PHP $VERSION source..."
curl -fsSL "https://www.php.net/distributions/php-${VERSION}.tar.gz" -o /tmp/php.tar.gz
tar -xf /tmp/php.tar.gz -C "$SRC_DIR" --strip-components=1
rm /tmp/php.tar.gz

# ── Apply OpenSSL 3 compatibility patch for PHP 7.4 / 8.0 ────────────────────
# Ubuntu 24.04 ships OpenSSL 3.x which removed RSA_SSLV23_PADDING.
# PHP 7.4 and 8.0 reference this removed constant in ext/openssl/openssl.c.
if [[ "$MINOR" == "7.4" || "$MINOR" == "8.0" ]]; then
  echo "==> Applying OpenSSL 3 compatibility patch for PHP $MINOR..."
  perl -pi -e 's/RSA_SSLV23_PADDING/RSA_PKCS1_PADDING/g' "$SRC_DIR/ext/openssl/openssl.c" || true
fi

# Force C++17 compatibility in ext/intl/config.m4
echo "==> Forcing C++17 compatibility in config.m4..."
perl -pi -e 's/-std=c\+\+11/-std=c++17/g' "$SRC_DIR/ext/intl/config.m4" || true
perl -pi -e 's/-std=gnu\+\+11/-std=gnu++17/g' "$SRC_DIR/ext/intl/config.m4" || true

cd "$SRC_DIR"
./buildconf --force 2>/dev/null

# ── Configure ─────────────────────────────────────────────────────────────────
echo "==> Configuring PHP $VERSION..."

# --enable-zip flag was renamed to --with-zip in PHP 8.x
# --with-libxml is implicit in PHP 8.x, explicit in 7.4
if [[ "$MINOR" == "7.4" ]]; then
  ZIP_FLAG="--enable-zip"
  LIBXML_FLAG="--with-libxml"
else
  ZIP_FLAG="--with-zip"
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
  --with-openssl=shared \
  --with-curl=shared \
  --with-zlib \
  --with-mysqli=shared \
  --with-pdo-mysql=shared \
  --with-pdo-pgsql=shared \
  --with-sqlite3=shared \
  --with-pdo-sqlite=shared \
  $LIBXML_FLAG

# Force C++17 in Makefile
echo "==> Forcing C++17 in Makefile..."
perl -pi -e 's/-std=c\+\+11/-std=c++17/g' Makefile || true
perl -pi -e 's/-std=gnu\+\+11/-std=gnu++17/g' Makefile || true

echo "==> Compiling PHP Core (this takes a while)..."
make -j$(nproc)
make install

# ── Helper: pick the right PECL version for the current PHP branch ────────────
pecl_version_for() {
  local pkg="$1"
  case "$pkg" in
    redis)
      # redis 6.3.0 supports PHP 8.5
      # redis 6.2.0 supports PHP 8.4
      # redis 6.0.2 supports PHP 7.4–8.3
      case "$MINOR" in
        8.5) echo "6.3.0" ;;
        8.4) echo "6.2.0" ;;
        *)   echo "6.0.2" ;;
      esac
      ;;
    xdebug)
      # xdebug 3.5.x supports PHP 8.4+
      # xdebug 3.4.x supports PHP 8.0–8.3
      # xdebug 3.1.x is the last version supporting PHP 7.4
      case "$MINOR" in
        8.5|8.4) echo "3.5.3" ;;
        7.4)     echo "3.1.6" ;;
        *)       echo "3.4.4" ;;
      esac
      ;;
    mongodb)
      # mongodb 2.x requires PHP 8.1+
      # mongodb 1.x supports PHP 7.4–8.0
      case "$MINOR" in
        7.4|8.0) echo "1.20.1" ;;
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
    echo "    [SKIP] ${ext_name} ${ext_version} not downloadable from PECL"
    return 0
  fi

  tar -xf /tmp/pecl.tgz -C "$ext_dir" --strip-components=1
  rm /tmp/pecl.tgz

  cd "$ext_dir"
  "$DIST_DIR/bin/phpize" --clean >/dev/null 2>&1 || true
  "$DIST_DIR/bin/phpize"
  ./configure --with-php-config="$DIST_DIR/bin/php-config" $config_opts

  if ! make -j$(nproc); then
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
compile_pecl_extension "imagick" || true  # requires ImageMagick dev libs on runner

# ── Move built shared core extensions to staging ──────────────────────────────
PHP_EXT_DIR="$("$DIST_DIR/bin/php-config" --extension-dir)"
echo "==> Staging shared core extensions from $PHP_EXT_DIR..."

core_exts=(
  opcache mbstring bcmath intl zip sockets soap
  xml simplexml xmlreader xmlwriter dom
  openssl curl mysqli pdo_mysql pdo_pgsql sqlite3 pdo_sqlite
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
  tar -czf "$OUTPUT_DIR/ext-${VERSION}-${ext}-linux-${PLATFORM_ARCH}.tar.gz" \
    -C "$EXT_STAGE_DIR/$ext" .
  echo "    -> ext-${VERSION}-${ext}-linux-${PLATFORM_ARCH}.tar.gz"
done

# ── Package PHP Core ──────────────────────────────────────────────────────────
echo "==> Packaging PHP Core..."
tar -czf "$OUTPUT_DIR/php-${VERSION}-linux-${PLATFORM_ARCH}.tar.gz" \
  -C "$DIST_DIR" .
echo "    -> php-${VERSION}-linux-${PLATFORM_ARCH}.tar.gz"

echo "==> Done. Output files:"
ls -lh "$OUTPUT_DIR/"