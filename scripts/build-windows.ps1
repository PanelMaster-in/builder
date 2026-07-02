param(
    [string]$Version
)

Invoke-WebRequest `
    -Uri "https://www.php.net/distributions/php-$Version.tar.gz" `
    -OutFile php.tar.gz

tar -xf php.tar.gz

cd "php-$Version"

buildconf

configure `
    --enable-cli `
    --enable-opcache `
    --enable-mbstring

nmake

mkdir ..\..\output -Force

Compress-Archive `
    -Path * `
    -DestinationPath `
    "..\..\output\php-$Version-windows-x64.zip"