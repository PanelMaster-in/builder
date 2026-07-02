#!/bin/bash
set -e

VERSION=$1
if [ -z "$VERSION" ]; then
  echo "Usage: $0 <php-version>"
  exit 1
fi

ARCH=$(uname -m)
if [ "$ARCH" = "x86_64" ]; then
  PLATFORM_ARCH="x64"
else
  PLATFORM_ARCH="arm64"
fi

echo "Building PHP $VERSION for Linux-$PLATFORM_ARCH..."

# Define Directories
SRC_DIR="/tmp/php-src"
DIST_DIR="/tmp/php-dist"
OUTPUT_DIR="$(pwd)/output"
EXT_STAGE_DIR="/tmp/ext-stage"

rm -rf "$SRC_DIR" "$DIST_DIR" "$EXT_STAGE_DIR"
mkdir -p "$SRC_DIR" "$DIST_DIR" "$EXT_STAGE_DIR" "$OUTPUT_DIR"

# Download and extract PHP source
echo "Downloading PHP source..."
curl -L "https://www.php.net/distributions/php-${VERSION}.tar.gz" -o php.tar.gz
tar -xf php.tar.gz -C "$SRC_DIR" --strip-components=1
rm php.tar.gz

cd "$SRC_DIR"

# Generate buildconf
./buildconf --force || true

# Configure PHP core build
# Compile major extensions as dynamic (shared) modules
echo "Configuring PHP..."
./configure \
  --prefix="$DIST_DIR" \
  --enable-cli \
  --enable-fpm \
  --enable-opcache=shared \
  --enable-mbstring=shared \
  --enable-bcmath=shared \
  --enable-intl=shared \
  --enable-zip=shared \
  --enable-sockets=shared \
  --enable-soap=shared \
  --enable-xml=shared \
  --enable-simplexml=shared \
  --enable-xmlreader=shared \
  --enable-xmlwriter=shared \
  --enable-dom=shared \
  --with-openssl=shared \
  --with-curl=shared \
  --with-zlib=shared \
  --with-mysqli=shared \
  --with-pdo-mysql=shared \
  --with-pdo-pgsql=shared \
  --with-sqlite3=shared \
  --with-pdo-sqlite=shared \
  --with-libxml

echo "Compiling PHP Core..."
make -j$(nproc)
make install

# Compile external PECL Extensions
compile_pecl_extension() {
  local ext_name=$1
  local ext_version=$2
  local config_opts=$3

  echo "Building PECL extension: ${ext_name} (${ext_version})..."
  local ext_dir="/tmp/pecl-${ext_name}"
  rm -rf "$ext_dir"
  mkdir -p "$ext_dir"

  # Download and extract PECL extension
  if curl -L -s -f "https://pecl.php.net/get/${ext_name}-${ext_version}.tgz" -o /tmp/pecl.tgz; then
    tar -xf /tmp/pecl.tgz -C "$ext_dir" --strip-components=1
    rm /tmp/pecl.tgz
  else
    echo "Warning: PECL extension ${ext_name} download failed. Skipping."
    return 1
  fi

  cd "$ext_dir"
  "$DIST_DIR/bin/phpize"
  ./configure --with-php-config="$DIST_DIR/bin/php-config" $config_opts
  make -j$(nproc)
  
  # Copy compiled module to staging directory
  mkdir -p "$EXT_STAGE_DIR/$ext_name"
  cp modules/${ext_name}.so "$EXT_STAGE_DIR/$ext_name/"
  echo "extension=${ext_name}.so" > "$EXT_STAGE_DIR/$ext_name/${ext_name}.ini"
}

# Compile standard external extensions
# Versions are pinned to stable releases compatible with PHP 7.4 - 8.4
compile_pecl_extension "redis" "6.0.2"
compile_pecl_extension "xdebug" "3.3.2"
compile_pecl_extension "mongodb" "1.19.4"
# Compile imagick, grpc (if dependency exists)
# In production workflow, dynamic libs like ImageMagick/grpc are preinstalled on build runner
compile_pecl_extension "imagick" "3.7.0" || true
compile_pecl_extension "grpc" "1.64.1" || true

# Extract Core Shared Extensions
# Find extension directory in PHP installation
PHP_EXT_DIR=$("$DIST_DIR/bin/php-config" --extension-dir)

echo "Extracting shared core extensions from $PHP_EXT_DIR..."
# Move all built core .so files to staging
core_exts=("opcache" "mbstring" "bcmath" "intl" "zip" "sockets" "soap" "xml" "simplexml" "xmlreader" "xmlwriter" "dom" "openssl" "curl" "mysqli" "pdo_mysql" "pdo_pgsql" "sqlite3" "pdo_sqlite")

for ext in "${core_exts[@]}"; do
  # Check if extension .so exists (some XML components might compile into single/different .so files depending on PHP version)
  # Look for either [ext].so or similar matching names
  local_so="$PHP_EXT_DIR/${ext}.so"
  if [ -f "$local_so" ]; then
    mkdir -p "$EXT_STAGE_DIR/$ext"
    mv "$local_so" "$EXT_STAGE_DIR/$ext/"
    
    # Generate loader ini file
    if [ "$ext" = "opcache" ]; then
      echo "zend_extension=opcache.so" > "$EXT_STAGE_DIR/$ext/${ext}.ini"
    else
      echo "extension=${ext}.so" > "$EXT_STAGE_DIR/$ext/${ext}.ini"
    fi
  fi
done

# Package Extensions separately
echo "Packaging Dynamic Extensions..."
cd "$EXT_STAGE_DIR"
for ext in *; do
  if [ -d "$ext" ]; then
    tar -czf "$OUTPUT_DIR/ext-${VERSION}-${ext}-linux-${PLATFORM_ARCH}.tar.gz" -C "$ext" .
    echo "Packaged extension: ext-${VERSION}-${ext}-linux-${PLATFORM_ARCH}.tar.gz"
  fi
done

# Package PHP Core (Base Runtime)
echo "Packaging PHP Core Runtime..."
cd "$DIST_DIR"
# The extension_dir inside the core package is now clean of built dynamic extensions
# Create a base archive
tar -czf "$OUTPUT_DIR/php-${VERSION}-linux-${PLATFORM_ARCH}.tar.gz" .
echo "Packaged PHP Core: php-${VERSION}-linux-${PLATFORM_ARCH}.tar.gz"

echo "Build complete."