#!/bin/bash
set -e

VERSION=$1

curl -L \
 "https://www.php.net/distributions/php-${VERSION}.tar.gz" \
 -o php.tar.gz

tar -xf php.tar.gz

cd php-${VERSION}

./buildconf --force || true

./configure \
 --enable-cli \
 --enable-fpm \
 --enable-opcache \
 --enable-mbstring \
 --enable-bcmath \
 --enable-intl \
 --enable-zip \
 --with-openssl \
 --with-curl

make -j8

mkdir -p ../../output

tar -czf \
 ../../output/php-${VERSION}-macos.tar.gz \
 .