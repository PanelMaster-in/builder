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
### PHP 8.4.10

#### Base Runtimes

| OS | Architecture | File Format | Download Link |
| :--- | :--- | :--- | :--- |
| **macOS** | `x64` | `.tar.gz` | [Download php-8.4.10-macos-x64.tar.gz](https://github.com/mock/releases/download/v8.4.10/php-8.4.10-macos-x64.tar.gz) |
| **macOS** | `arm64` | `.tar.gz` | [Download php-8.4.10-macos-arm64.tar.gz](https://github.com/mock/releases/download/v8.4.10/php-8.4.10-macos-arm64.tar.gz) |
| **Linux** | `x64` | `.tar.gz` | [Download php-8.4.10-linux-x64.tar.gz](https://github.com/mock/releases/download/v8.4.10/php-8.4.10-linux-x64.tar.gz) |
| **Linux** | `arm64` | `.tar.gz` | [Download php-8.4.10-linux-arm64.tar.gz](https://github.com/mock/releases/download/v8.4.10/php-8.4.10-linux-arm64.tar.gz) |
| **Windows** | `x64` | `.zip` | [Download php-8.4.10-windows-x64.zip](https://github.com/mock/releases/download/v8.4.10/php-8.4.10-windows-x64.zip) |
| **Windows** | `arm64` | `.zip` | *Not built yet* |

#### Dynamic Extensions (PECL / Shared)

| Extension | macOS x64 | macOS ARM64 | Linux x64 | Linux ARM64 | Windows x64 | Windows ARM64 |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **redis** | - | [⬇️ Link](https://github.com/mock/releases/download/v8.4.10/ext-8.4.10-redis-macos-arm64.tar.gz) | [⬇️ Link](https://github.com/mock/releases/download/v8.4.10/ext-8.4.10-redis-linux-x64.tar.gz) | - | - | - |
| **xdebug** | - | - | - | - | [⬇️ Link](https://github.com/mock/releases/download/v8.4.10/ext-8.4.10-xdebug-windows-x64.zip) | - |

***

### PHP 8.3.23

#### Base Runtimes

| OS | Architecture | File Format | Download Link |
| :--- | :--- | :--- | :--- |
| **macOS** | `x64` | `.tar.gz` | *Not built yet* |
| **macOS** | `arm64` | `.tar.gz` | [Download php-8.3.23-macos-arm64.tar.gz](https://github.com/mock/releases/download/v8.3.23/php-8.3.23-macos-arm64.tar.gz) |
| **Linux** | `x64` | `.tar.gz` | [Download php-8.3.23-linux-x64.tar.gz](https://github.com/mock/releases/download/v8.3.23/php-8.3.23-linux-x64.tar.gz) |
| **Linux** | `arm64` | `.tar.gz` | *Not built yet* |
| **Windows** | `x64` | `.zip` | [Download php-8.3.23-windows-x64.zip](https://github.com/mock/releases/download/v8.3.23/php-8.3.23-windows-x64.zip) |
| **Windows** | `arm64` | `.zip` | *Not built yet* |

#### Dynamic Extensions (PECL / Shared)

| Extension | macOS x64 | macOS ARM64 | Linux x64 | Linux ARM64 | Windows x64 | Windows ARM64 |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **redis** | - | [⬇️ Link](https://github.com/mock/releases/download/v8.3.23/ext-8.3.23-redis-macos-arm64.tar.gz) | - | - | - | - |
| **xdebug** | - | [⬇️ Link](https://github.com/mock/releases/download/v8.3.23/ext-8.3.23-xdebug-macos-arm64.tar.gz) | - | - | - | - |

***
<!-- END_RELEASES_TABLE -->

---

## Architecture & Build Procedures

For detailed architecture diagrams, compilation options, and security sign-off procedures, please refer to the design docs and scripts.
