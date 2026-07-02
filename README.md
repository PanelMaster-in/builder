# Local Host Manager: PHP Runtime Distribution Infrastructure

This repository hosts the build pipeline, recipes, and automation workflows for compiling, packaging, and distributing PHP runtimes and dynamic extensions for **Local Host Manager** (a cross-platform desktop developer environment manager).

## Supported Matrix

| Operating System | Architectures | PHP Versions | Status |
|---|---|---|---|
| **macOS** | x64, ARM64 | 7.4, 8.0, 8.1, 8.2, 8.3, 8.4, 8.5 | Active |
| **Windows** | x64, ARM64 | 7.4, 8.0, 8.1, 8.2, 8.3, 8.4, 8.5 | Active |
| **Linux** | x64, ARM64 | 7.4, 8.0, 8.1, 8.2, 8.3, 8.4, 8.5 | Active |

## Dynamic Extension Support

Rather than compiling extensions statically into the core binary, this pipeline builds them as individual dynamic link modules (`.so`, `.dylib`, `.dll`). The desktop app downloads and installs only the extensions requested by the user, managing the PHP configuration (`php.ini`) accordingly.

---

## PHP Releases & Downloads

Below is the list of compiled PHP runtimes and dynamic extensions hosted directly as GitHub Release assets.

<!-- START_RELEASES_TABLE -->
### PHP 8.5.8

#### Base Runtimes

| OS | Architecture | File Format | Download Link |
| :--- | :--- | :--- | :--- |
| **macOS** | `x64` | `.tar.gz` | *Not built yet* |
| **macOS** | `arm64` | `.tar.gz` | [Download php-8.5.8-macos-arm64.tar.gz](https://github.com/PanelMaster-in/builder/releases/download/v8.5.8/php-8.5.8-macos-arm64.tar.gz) |
| **Linux** | `x64` | `.tar.gz` | [Download php-8.5.8-linux-x64.tar.gz](https://github.com/PanelMaster-in/builder/releases/download/v8.5.8/php-8.5.8-linux-x64.tar.gz) |
| **Linux** | `arm64` | `.tar.gz` | *Not built yet* |
| **Windows** | `x64` | `.zip` | *Not built yet* |
| **Windows** | `arm64` | `.zip` | *Not built yet* |

#### Dynamic Extensions (PECL / Shared)

| Extension | macOS x64 | macOS ARM64 | Linux x64 | Linux ARM64 | Windows x64 | Windows ARM64 |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **bcmath** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.5.8/ext-8.5.8-bcmath-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.5.8/ext-8.5.8-bcmath-linux-x64.tar.gz) | - | - | - |
| **curl** | - | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.5.8/ext-8.5.8-curl-linux-x64.tar.gz) | - | - | - |
| **dom** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.5.8/ext-8.5.8-dom-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.5.8/ext-8.5.8-dom-linux-x64.tar.gz) | - | - | - |
| **imagick** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.5.8/ext-8.5.8-imagick-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.5.8/ext-8.5.8-imagick-linux-x64.tar.gz) | - | - | - |
| **intl** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.5.8/ext-8.5.8-intl-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.5.8/ext-8.5.8-intl-linux-x64.tar.gz) | - | - | - |
| **mbstring** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.5.8/ext-8.5.8-mbstring-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.5.8/ext-8.5.8-mbstring-linux-x64.tar.gz) | - | - | - |
| **mongodb** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.5.8/ext-8.5.8-mongodb-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.5.8/ext-8.5.8-mongodb-linux-x64.tar.gz) | - | - | - |
| **mysqli** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.5.8/ext-8.5.8-mysqli-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.5.8/ext-8.5.8-mysqli-linux-x64.tar.gz) | - | - | - |
| **openssl** | - | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.5.8/ext-8.5.8-openssl-linux-x64.tar.gz) | - | - | - |
| **pdo_mysql** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.5.8/ext-8.5.8-pdo_mysql-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.5.8/ext-8.5.8-pdo_mysql-linux-x64.tar.gz) | - | - | - |
| **pdo_pgsql** | - | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.5.8/ext-8.5.8-pdo_pgsql-linux-x64.tar.gz) | - | - | - |
| **pdo_sqlite** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.5.8/ext-8.5.8-pdo_sqlite-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.5.8/ext-8.5.8-pdo_sqlite-linux-x64.tar.gz) | - | - | - |
| **redis** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.5.8/ext-8.5.8-redis-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.5.8/ext-8.5.8-redis-linux-x64.tar.gz) | - | - | - |
| **simplexml** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.5.8/ext-8.5.8-simplexml-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.5.8/ext-8.5.8-simplexml-linux-x64.tar.gz) | - | - | - |
| **soap** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.5.8/ext-8.5.8-soap-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.5.8/ext-8.5.8-soap-linux-x64.tar.gz) | - | - | - |
| **sockets** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.5.8/ext-8.5.8-sockets-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.5.8/ext-8.5.8-sockets-linux-x64.tar.gz) | - | - | - |
| **sqlite3** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.5.8/ext-8.5.8-sqlite3-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.5.8/ext-8.5.8-sqlite3-linux-x64.tar.gz) | - | - | - |
| **xdebug** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.5.8/ext-8.5.8-xdebug-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.5.8/ext-8.5.8-xdebug-linux-x64.tar.gz) | - | - | - |
| **xml** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.5.8/ext-8.5.8-xml-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.5.8/ext-8.5.8-xml-linux-x64.tar.gz) | - | - | - |
| **xmlreader** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.5.8/ext-8.5.8-xmlreader-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.5.8/ext-8.5.8-xmlreader-linux-x64.tar.gz) | - | - | - |
| **xmlwriter** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.5.8/ext-8.5.8-xmlwriter-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.5.8/ext-8.5.8-xmlwriter-linux-x64.tar.gz) | - | - | - |

***

### PHP 8.4.23

#### Base Runtimes

| OS | Architecture | File Format | Download Link |
| :--- | :--- | :--- | :--- |
| **macOS** | `x64` | `.tar.gz` | *Not built yet* |
| **macOS** | `arm64` | `.tar.gz` | [Download php-8.4.23-macos-arm64.tar.gz](https://github.com/PanelMaster-in/builder/releases/download/v8.4.23/php-8.4.23-macos-arm64.tar.gz) |
| **Linux** | `x64` | `.tar.gz` | [Download php-8.4.23-linux-x64.tar.gz](https://github.com/PanelMaster-in/builder/releases/download/v8.4.23/php-8.4.23-linux-x64.tar.gz) |
| **Linux** | `arm64` | `.tar.gz` | *Not built yet* |
| **Windows** | `x64` | `.zip` | *Not built yet* |
| **Windows** | `arm64` | `.zip` | *Not built yet* |

#### Dynamic Extensions (PECL / Shared)

| Extension | macOS x64 | macOS ARM64 | Linux x64 | Linux ARM64 | Windows x64 | Windows ARM64 |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **bcmath** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.4.23/ext-8.4.23-bcmath-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.4.23/ext-8.4.23-bcmath-linux-x64.tar.gz) | - | - | - |
| **curl** | - | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.4.23/ext-8.4.23-curl-linux-x64.tar.gz) | - | - | - |
| **dom** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.4.23/ext-8.4.23-dom-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.4.23/ext-8.4.23-dom-linux-x64.tar.gz) | - | - | - |
| **imagick** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.4.23/ext-8.4.23-imagick-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.4.23/ext-8.4.23-imagick-linux-x64.tar.gz) | - | - | - |
| **intl** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.4.23/ext-8.4.23-intl-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.4.23/ext-8.4.23-intl-linux-x64.tar.gz) | - | - | - |
| **mbstring** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.4.23/ext-8.4.23-mbstring-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.4.23/ext-8.4.23-mbstring-linux-x64.tar.gz) | - | - | - |
| **mongodb** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.4.23/ext-8.4.23-mongodb-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.4.23/ext-8.4.23-mongodb-linux-x64.tar.gz) | - | - | - |
| **mysqli** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.4.23/ext-8.4.23-mysqli-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.4.23/ext-8.4.23-mysqli-linux-x64.tar.gz) | - | - | - |
| **opcache** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.4.23/ext-8.4.23-opcache-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.4.23/ext-8.4.23-opcache-linux-x64.tar.gz) | - | - | - |
| **openssl** | - | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.4.23/ext-8.4.23-openssl-linux-x64.tar.gz) | - | - | - |
| **pdo_mysql** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.4.23/ext-8.4.23-pdo_mysql-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.4.23/ext-8.4.23-pdo_mysql-linux-x64.tar.gz) | - | - | - |
| **pdo_pgsql** | - | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.4.23/ext-8.4.23-pdo_pgsql-linux-x64.tar.gz) | - | - | - |
| **pdo_sqlite** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.4.23/ext-8.4.23-pdo_sqlite-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.4.23/ext-8.4.23-pdo_sqlite-linux-x64.tar.gz) | - | - | - |
| **redis** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.4.23/ext-8.4.23-redis-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.4.23/ext-8.4.23-redis-linux-x64.tar.gz) | - | - | - |
| **simplexml** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.4.23/ext-8.4.23-simplexml-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.4.23/ext-8.4.23-simplexml-linux-x64.tar.gz) | - | - | - |
| **soap** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.4.23/ext-8.4.23-soap-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.4.23/ext-8.4.23-soap-linux-x64.tar.gz) | - | - | - |
| **sockets** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.4.23/ext-8.4.23-sockets-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.4.23/ext-8.4.23-sockets-linux-x64.tar.gz) | - | - | - |
| **sqlite3** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.4.23/ext-8.4.23-sqlite3-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.4.23/ext-8.4.23-sqlite3-linux-x64.tar.gz) | - | - | - |
| **xdebug** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.4.23/ext-8.4.23-xdebug-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.4.23/ext-8.4.23-xdebug-linux-x64.tar.gz) | - | - | - |
| **xml** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.4.23/ext-8.4.23-xml-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.4.23/ext-8.4.23-xml-linux-x64.tar.gz) | - | - | - |
| **xmlreader** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.4.23/ext-8.4.23-xmlreader-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.4.23/ext-8.4.23-xmlreader-linux-x64.tar.gz) | - | - | - |
| **xmlwriter** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.4.23/ext-8.4.23-xmlwriter-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.4.23/ext-8.4.23-xmlwriter-linux-x64.tar.gz) | - | - | - |

***

### PHP 8.3.32

#### Base Runtimes

| OS | Architecture | File Format | Download Link |
| :--- | :--- | :--- | :--- |
| **macOS** | `x64` | `.tar.gz` | *Not built yet* |
| **macOS** | `arm64` | `.tar.gz` | [Download php-8.3.32-macos-arm64.tar.gz](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/php-8.3.32-macos-arm64.tar.gz) |
| **Linux** | `x64` | `.tar.gz` | [Download php-8.3.32-linux-x64.tar.gz](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/php-8.3.32-linux-x64.tar.gz) |
| **Linux** | `arm64` | `.tar.gz` | [Download php-8.3.32-linux-arm64.tar.gz](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/php-8.3.32-linux-arm64.tar.gz) |
| **Windows** | `x64` | `.zip` | *Not built yet* |
| **Windows** | `arm64` | `.zip` | *Not built yet* |

#### Dynamic Extensions (PECL / Shared)

| Extension | macOS x64 | macOS ARM64 | Linux x64 | Linux ARM64 | Windows x64 | Windows ARM64 |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **bcmath** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-bcmath-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-bcmath-linux-x64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-bcmath-linux-arm64.tar.gz) | - | - |
| **curl** | - | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-curl-linux-x64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-curl-linux-arm64.tar.gz) | - | - |
| **dom** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-dom-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-dom-linux-x64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-dom-linux-arm64.tar.gz) | - | - |
| **grpc** | - | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-grpc-linux-x64.tar.gz) | - | - | - |
| **imagick** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-imagick-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-imagick-linux-x64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-imagick-linux-arm64.tar.gz) | - | - |
| **intl** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-intl-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-intl-linux-x64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-intl-linux-arm64.tar.gz) | - | - |
| **mbstring** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-mbstring-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-mbstring-linux-x64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-mbstring-linux-arm64.tar.gz) | - | - |
| **mongodb** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-mongodb-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-mongodb-linux-x64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-mongodb-linux-arm64.tar.gz) | - | - |
| **mysqli** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-mysqli-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-mysqli-linux-x64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-mysqli-linux-arm64.tar.gz) | - | - |
| **opcache** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-opcache-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-opcache-linux-x64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-opcache-linux-arm64.tar.gz) | - | - |
| **openssl** | - | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-openssl-linux-x64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-openssl-linux-arm64.tar.gz) | - | - |
| **pdo_mysql** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-pdo_mysql-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-pdo_mysql-linux-x64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-pdo_mysql-linux-arm64.tar.gz) | - | - |
| **pdo_pgsql** | - | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-pdo_pgsql-linux-x64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-pdo_pgsql-linux-arm64.tar.gz) | - | - |
| **pdo_sqlite** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-pdo_sqlite-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-pdo_sqlite-linux-x64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-pdo_sqlite-linux-arm64.tar.gz) | - | - |
| **redis** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-redis-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-redis-linux-x64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-redis-linux-arm64.tar.gz) | - | - |
| **simplexml** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-simplexml-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-simplexml-linux-x64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-simplexml-linux-arm64.tar.gz) | - | - |
| **soap** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-soap-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-soap-linux-x64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-soap-linux-arm64.tar.gz) | - | - |
| **sockets** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-sockets-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-sockets-linux-x64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-sockets-linux-arm64.tar.gz) | - | - |
| **sqlite3** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-sqlite3-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-sqlite3-linux-x64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-sqlite3-linux-arm64.tar.gz) | - | - |
| **xdebug** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-xdebug-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-xdebug-linux-x64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-xdebug-linux-arm64.tar.gz) | - | - |
| **xml** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-xml-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-xml-linux-x64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-xml-linux-arm64.tar.gz) | - | - |
| **xmlreader** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-xmlreader-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-xmlreader-linux-x64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-xmlreader-linux-arm64.tar.gz) | - | - |
| **xmlwriter** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-xmlwriter-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-xmlwriter-linux-x64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.3.32/ext-8.3.32-xmlwriter-linux-arm64.tar.gz) | - | - |

***

### PHP 8.2.29

#### Base Runtimes

| OS | Architecture | File Format | Download Link |
| :--- | :--- | :--- | :--- |
| **macOS** | `x64` | `.tar.gz` | *Not built yet* |
| **macOS** | `arm64` | `.tar.gz` | [Download php-8.2.29-macos-arm64.tar.gz](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/php-8.2.29-macos-arm64.tar.gz) |
| **Linux** | `x64` | `.tar.gz` | [Download php-8.2.29-linux-x64.tar.gz](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/php-8.2.29-linux-x64.tar.gz) |
| **Linux** | `arm64` | `.tar.gz` | *Not built yet* |
| **Windows** | `x64` | `.zip` | *Not built yet* |
| **Windows** | `arm64` | `.zip` | *Not built yet* |

#### Dynamic Extensions (PECL / Shared)

| Extension | macOS x64 | macOS ARM64 | Linux x64 | Linux ARM64 | Windows x64 | Windows ARM64 |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **bcmath** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/ext-8.2.29-bcmath-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/ext-8.2.29-bcmath-linux-x64.tar.gz) | - | - | - |
| **curl** | - | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/ext-8.2.29-curl-linux-x64.tar.gz) | - | - | - |
| **dom** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/ext-8.2.29-dom-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/ext-8.2.29-dom-linux-x64.tar.gz) | - | - | - |
| **grpc** | - | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/ext-8.2.29-grpc-linux-x64.tar.gz) | - | - | - |
| **imagick** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/ext-8.2.29-imagick-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/ext-8.2.29-imagick-linux-x64.tar.gz) | - | - | - |
| **intl** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/ext-8.2.29-intl-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/ext-8.2.29-intl-linux-x64.tar.gz) | - | - | - |
| **mbstring** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/ext-8.2.29-mbstring-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/ext-8.2.29-mbstring-linux-x64.tar.gz) | - | - | - |
| **mongodb** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/ext-8.2.29-mongodb-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/ext-8.2.29-mongodb-linux-x64.tar.gz) | - | - | - |
| **mysqli** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/ext-8.2.29-mysqli-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/ext-8.2.29-mysqli-linux-x64.tar.gz) | - | - | - |
| **opcache** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/ext-8.2.29-opcache-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/ext-8.2.29-opcache-linux-x64.tar.gz) | - | - | - |
| **openssl** | - | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/ext-8.2.29-openssl-linux-x64.tar.gz) | - | - | - |
| **pdo_mysql** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/ext-8.2.29-pdo_mysql-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/ext-8.2.29-pdo_mysql-linux-x64.tar.gz) | - | - | - |
| **pdo_pgsql** | - | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/ext-8.2.29-pdo_pgsql-linux-x64.tar.gz) | - | - | - |
| **pdo_sqlite** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/ext-8.2.29-pdo_sqlite-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/ext-8.2.29-pdo_sqlite-linux-x64.tar.gz) | - | - | - |
| **redis** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/ext-8.2.29-redis-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/ext-8.2.29-redis-linux-x64.tar.gz) | - | - | - |
| **simplexml** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/ext-8.2.29-simplexml-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/ext-8.2.29-simplexml-linux-x64.tar.gz) | - | - | - |
| **soap** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/ext-8.2.29-soap-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/ext-8.2.29-soap-linux-x64.tar.gz) | - | - | - |
| **sockets** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/ext-8.2.29-sockets-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/ext-8.2.29-sockets-linux-x64.tar.gz) | - | - | - |
| **sqlite3** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/ext-8.2.29-sqlite3-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/ext-8.2.29-sqlite3-linux-x64.tar.gz) | - | - | - |
| **xdebug** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/ext-8.2.29-xdebug-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/ext-8.2.29-xdebug-linux-x64.tar.gz) | - | - | - |
| **xml** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/ext-8.2.29-xml-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/ext-8.2.29-xml-linux-x64.tar.gz) | - | - | - |
| **xmlreader** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/ext-8.2.29-xmlreader-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/ext-8.2.29-xmlreader-linux-x64.tar.gz) | - | - | - |
| **xmlwriter** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/ext-8.2.29-xmlwriter-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.2.29/ext-8.2.29-xmlwriter-linux-x64.tar.gz) | - | - | - |

***

### PHP 8.1.33

#### Base Runtimes

| OS | Architecture | File Format | Download Link |
| :--- | :--- | :--- | :--- |
| **macOS** | `x64` | `.tar.gz` | *Not built yet* |
| **macOS** | `arm64` | `.tar.gz` | [Download php-8.1.33-macos-arm64.tar.gz](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/php-8.1.33-macos-arm64.tar.gz) |
| **Linux** | `x64` | `.tar.gz` | [Download php-8.1.33-linux-x64.tar.gz](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/php-8.1.33-linux-x64.tar.gz) |
| **Linux** | `arm64` | `.tar.gz` | *Not built yet* |
| **Windows** | `x64` | `.zip` | *Not built yet* |
| **Windows** | `arm64` | `.zip` | *Not built yet* |

#### Dynamic Extensions (PECL / Shared)

| Extension | macOS x64 | macOS ARM64 | Linux x64 | Linux ARM64 | Windows x64 | Windows ARM64 |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **bcmath** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/ext-8.1.33-bcmath-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/ext-8.1.33-bcmath-linux-x64.tar.gz) | - | - | - |
| **curl** | - | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/ext-8.1.33-curl-linux-x64.tar.gz) | - | - | - |
| **dom** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/ext-8.1.33-dom-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/ext-8.1.33-dom-linux-x64.tar.gz) | - | - | - |
| **grpc** | - | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/ext-8.1.33-grpc-linux-x64.tar.gz) | - | - | - |
| **imagick** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/ext-8.1.33-imagick-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/ext-8.1.33-imagick-linux-x64.tar.gz) | - | - | - |
| **intl** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/ext-8.1.33-intl-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/ext-8.1.33-intl-linux-x64.tar.gz) | - | - | - |
| **mbstring** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/ext-8.1.33-mbstring-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/ext-8.1.33-mbstring-linux-x64.tar.gz) | - | - | - |
| **mongodb** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/ext-8.1.33-mongodb-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/ext-8.1.33-mongodb-linux-x64.tar.gz) | - | - | - |
| **mysqli** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/ext-8.1.33-mysqli-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/ext-8.1.33-mysqli-linux-x64.tar.gz) | - | - | - |
| **opcache** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/ext-8.1.33-opcache-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/ext-8.1.33-opcache-linux-x64.tar.gz) | - | - | - |
| **openssl** | - | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/ext-8.1.33-openssl-linux-x64.tar.gz) | - | - | - |
| **pdo_mysql** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/ext-8.1.33-pdo_mysql-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/ext-8.1.33-pdo_mysql-linux-x64.tar.gz) | - | - | - |
| **pdo_pgsql** | - | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/ext-8.1.33-pdo_pgsql-linux-x64.tar.gz) | - | - | - |
| **pdo_sqlite** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/ext-8.1.33-pdo_sqlite-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/ext-8.1.33-pdo_sqlite-linux-x64.tar.gz) | - | - | - |
| **redis** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/ext-8.1.33-redis-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/ext-8.1.33-redis-linux-x64.tar.gz) | - | - | - |
| **simplexml** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/ext-8.1.33-simplexml-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/ext-8.1.33-simplexml-linux-x64.tar.gz) | - | - | - |
| **soap** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/ext-8.1.33-soap-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/ext-8.1.33-soap-linux-x64.tar.gz) | - | - | - |
| **sockets** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/ext-8.1.33-sockets-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/ext-8.1.33-sockets-linux-x64.tar.gz) | - | - | - |
| **sqlite3** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/ext-8.1.33-sqlite3-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/ext-8.1.33-sqlite3-linux-x64.tar.gz) | - | - | - |
| **xdebug** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/ext-8.1.33-xdebug-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/ext-8.1.33-xdebug-linux-x64.tar.gz) | - | - | - |
| **xml** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/ext-8.1.33-xml-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/ext-8.1.33-xml-linux-x64.tar.gz) | - | - | - |
| **xmlreader** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/ext-8.1.33-xmlreader-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/ext-8.1.33-xmlreader-linux-x64.tar.gz) | - | - | - |
| **xmlwriter** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/ext-8.1.33-xmlwriter-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.1.33/ext-8.1.33-xmlwriter-linux-x64.tar.gz) | - | - | - |

***

### PHP 8.0.30

#### Base Runtimes

| OS | Architecture | File Format | Download Link |
| :--- | :--- | :--- | :--- |
| **macOS** | `x64` | `.tar.gz` | *Not built yet* |
| **macOS** | `arm64` | `.tar.gz` | [Download php-8.0.30-macos-arm64.tar.gz](https://github.com/PanelMaster-in/builder/releases/download/v8.0.30/php-8.0.30-macos-arm64.tar.gz) |
| **Linux** | `x64` | `.tar.gz` | [Download php-8.0.30-linux-x64.tar.gz](https://github.com/PanelMaster-in/builder/releases/download/v8.0.30/php-8.0.30-linux-x64.tar.gz) |
| **Linux** | `arm64` | `.tar.gz` | *Not built yet* |
| **Windows** | `x64` | `.zip` | *Not built yet* |
| **Windows** | `arm64` | `.zip` | *Not built yet* |

#### Dynamic Extensions (PECL / Shared)

| Extension | macOS x64 | macOS ARM64 | Linux x64 | Linux ARM64 | Windows x64 | Windows ARM64 |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **bcmath** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.0.30/ext-8.0.30-bcmath-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.0.30/ext-8.0.30-bcmath-linux-x64.tar.gz) | - | - | - |
| **curl** | - | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.0.30/ext-8.0.30-curl-linux-x64.tar.gz) | - | - | - |
| **dom** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.0.30/ext-8.0.30-dom-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.0.30/ext-8.0.30-dom-linux-x64.tar.gz) | - | - | - |
| **imagick** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.0.30/ext-8.0.30-imagick-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.0.30/ext-8.0.30-imagick-linux-x64.tar.gz) | - | - | - |
| **intl** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.0.30/ext-8.0.30-intl-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.0.30/ext-8.0.30-intl-linux-x64.tar.gz) | - | - | - |
| **mbstring** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.0.30/ext-8.0.30-mbstring-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.0.30/ext-8.0.30-mbstring-linux-x64.tar.gz) | - | - | - |
| **mongodb** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.0.30/ext-8.0.30-mongodb-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.0.30/ext-8.0.30-mongodb-linux-x64.tar.gz) | - | - | - |
| **mysqli** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.0.30/ext-8.0.30-mysqli-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.0.30/ext-8.0.30-mysqli-linux-x64.tar.gz) | - | - | - |
| **opcache** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.0.30/ext-8.0.30-opcache-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.0.30/ext-8.0.30-opcache-linux-x64.tar.gz) | - | - | - |
| **openssl** | - | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.0.30/ext-8.0.30-openssl-linux-x64.tar.gz) | - | - | - |
| **pdo_mysql** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.0.30/ext-8.0.30-pdo_mysql-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.0.30/ext-8.0.30-pdo_mysql-linux-x64.tar.gz) | - | - | - |
| **pdo_pgsql** | - | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.0.30/ext-8.0.30-pdo_pgsql-linux-x64.tar.gz) | - | - | - |
| **pdo_sqlite** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.0.30/ext-8.0.30-pdo_sqlite-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.0.30/ext-8.0.30-pdo_sqlite-linux-x64.tar.gz) | - | - | - |
| **redis** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.0.30/ext-8.0.30-redis-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.0.30/ext-8.0.30-redis-linux-x64.tar.gz) | - | - | - |
| **simplexml** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.0.30/ext-8.0.30-simplexml-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.0.30/ext-8.0.30-simplexml-linux-x64.tar.gz) | - | - | - |
| **soap** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.0.30/ext-8.0.30-soap-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.0.30/ext-8.0.30-soap-linux-x64.tar.gz) | - | - | - |
| **sockets** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.0.30/ext-8.0.30-sockets-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.0.30/ext-8.0.30-sockets-linux-x64.tar.gz) | - | - | - |
| **sqlite3** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.0.30/ext-8.0.30-sqlite3-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.0.30/ext-8.0.30-sqlite3-linux-x64.tar.gz) | - | - | - |
| **xdebug** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.0.30/ext-8.0.30-xdebug-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.0.30/ext-8.0.30-xdebug-linux-x64.tar.gz) | - | - | - |
| **xml** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.0.30/ext-8.0.30-xml-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.0.30/ext-8.0.30-xml-linux-x64.tar.gz) | - | - | - |
| **xmlreader** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.0.30/ext-8.0.30-xmlreader-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.0.30/ext-8.0.30-xmlreader-linux-x64.tar.gz) | - | - | - |
| **xmlwriter** | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.0.30/ext-8.0.30-xmlwriter-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v8.0.30/ext-8.0.30-xmlwriter-linux-x64.tar.gz) | - | - | - |

***

### PHP 7.4.33

#### Base Runtimes

| OS | Architecture | File Format | Download Link |
| :--- | :--- | :--- | :--- |
| **macOS** | `x64` | `.tar.gz` | *Not built yet* |
| **macOS** | `arm64` | `.tar.gz` | *Not built yet* |
| **Linux** | `x64` | `.tar.gz` | [Download php-7.4.33-linux-x64.tar.gz](https://github.com/PanelMaster-in/builder/releases/download/v7.4.33/php-7.4.33-linux-x64.tar.gz) |
| **Linux** | `arm64` | `.tar.gz` | *Not built yet* |
| **Windows** | `x64` | `.zip` | *Not built yet* |
| **Windows** | `arm64` | `.zip` | *Not built yet* |

#### Dynamic Extensions (PECL / Shared)

| Extension | macOS x64 | macOS ARM64 | Linux x64 | Linux ARM64 | Windows x64 | Windows ARM64 |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **bcmath** | - | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v7.4.33/ext-7.4.33-bcmath-linux-x64.tar.gz) | - | - | - |
| **curl** | - | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v7.4.33/ext-7.4.33-curl-linux-x64.tar.gz) | - | - | - |
| **dom** | - | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v7.4.33/ext-7.4.33-dom-linux-x64.tar.gz) | - | - | - |
| **imagick** | - | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v7.4.33/ext-7.4.33-imagick-linux-x64.tar.gz) | - | - | - |
| **intl** | - | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v7.4.33/ext-7.4.33-intl-linux-x64.tar.gz) | - | - | - |
| **mbstring** | - | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v7.4.33/ext-7.4.33-mbstring-linux-x64.tar.gz) | - | - | - |
| **mongodb** | - | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v7.4.33/ext-7.4.33-mongodb-linux-x64.tar.gz) | - | - | - |
| **mysqli** | - | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v7.4.33/ext-7.4.33-mysqli-linux-x64.tar.gz) | - | - | - |
| **opcache** | - | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v7.4.33/ext-7.4.33-opcache-linux-x64.tar.gz) | - | - | - |
| **openssl** | - | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v7.4.33/ext-7.4.33-openssl-linux-x64.tar.gz) | - | - | - |
| **pdo_mysql** | - | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v7.4.33/ext-7.4.33-pdo_mysql-linux-x64.tar.gz) | - | - | - |
| **pdo_pgsql** | - | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v7.4.33/ext-7.4.33-pdo_pgsql-linux-x64.tar.gz) | - | - | - |
| **pdo_sqlite** | - | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v7.4.33/ext-7.4.33-pdo_sqlite-linux-x64.tar.gz) | - | - | - |
| **redis** | - | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v7.4.33/ext-7.4.33-redis-linux-x64.tar.gz) | - | - | - |
| **simplexml** | - | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v7.4.33/ext-7.4.33-simplexml-linux-x64.tar.gz) | - | - | - |
| **soap** | - | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v7.4.33/ext-7.4.33-soap-linux-x64.tar.gz) | - | - | - |
| **sockets** | - | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v7.4.33/ext-7.4.33-sockets-linux-x64.tar.gz) | - | - | - |
| **sqlite3** | - | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v7.4.33/ext-7.4.33-sqlite3-linux-x64.tar.gz) | - | - | - |
| **xdebug** | - | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v7.4.33/ext-7.4.33-xdebug-linux-x64.tar.gz) | - | - | - |
| **xml** | - | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v7.4.33/ext-7.4.33-xml-linux-x64.tar.gz) | - | - | - |
| **xmlreader** | - | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v7.4.33/ext-7.4.33-xmlreader-linux-x64.tar.gz) | - | - | - |
| **xmlwriter** | - | - | [⬇️ Link](https://github.com/PanelMaster-in/builder/releases/download/v7.4.33/ext-7.4.33-xmlwriter-linux-x64.tar.gz) | - | - | - |

***
<!-- END_RELEASES_TABLE -->

---

## Architecture & Build Procedures

For detailed architecture diagrams, compilation options, and security sign-off procedures, please refer to the design docs and scripts.
