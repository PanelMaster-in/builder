param(
    [string]$Version
)

$ErrorActionPreference = "Stop"

# Add PHP SDK tools to PATH so we can access phpsdk_deps, bison, flex, etc.
$env:PATH = "C:\php-sdk\bin;C:\php-sdk\msys2\usr\bin;" + $env:PATH

$Arch = "x64"
$Minor = $Version.Substring(0, $Version.LastIndexOf('.')) # e.g. "8.3"

Write-Host "==> Building PHP $Version (branch $Minor) for Windows $Arch..."

# Setup Directories
$SrcDir = "C:\php-sdk\src\php-$Version"
$DistDir = "C:\php-sdk\dist\php-$Version"
$OutputDir = "$(Get-Location)\output"
$ExtStageDir = "C:\php-sdk\ext-stage"

if (Test-Path $SrcDir) { Remove-Item $SrcDir -Recurse -Force }
if (Test-Path $DistDir) { Remove-Item $DistDir -Recurse -Force }
if (Test-Path $ExtStageDir) { Remove-Item $ExtStageDir -Recurse -Force }

New-Item -Path $SrcDir -ItemType Directory -Force | Out-Null
New-Item -Path $DistDir -ItemType Directory -Force | Out-Null
New-Item -Path $ExtStageDir -ItemType Directory -Force | Out-Null
New-Item -Path $OutputDir -ItemType Directory -Force | Out-Null

# Download and Extract PHP source
Write-Host "==> Downloading PHP source..."
$Url = "https://www.php.net/distributions/php-$Version.tar.gz"
$TarPath = "$env:TEMP\php-$Version.tar.gz"
Invoke-WebRequest -Uri $Url -OutFile $TarPath

# Extract using tar
tar -xf $TarPath -C $SrcDir --strip-components=1
Remove-Item $TarPath

# --- Helper: pick the right PECL version ---
function Get-Pecl-Version($pkg) {
    switch ($pkg) {
        "redis" {
            switch ($Minor) {
                "8.5" { return "6.3.0" }
                "8.4" { return "6.2.0" }
                default { return "6.0.2" }
            }
        }
        "xdebug" {
            switch ($Minor) {
                "8.5" { return "3.5.3" }
                "8.4" { return "3.5.3" }
                "7.4" { return "3.1.6" }
                default { return "3.4.4" }
            }
        }
        "mongodb" {
            switch ($Minor) {
                "7.4" { return "1.21.0" }
                "8.0" { return "1.21.0" }
                default { return "2.3.3" }
            }
        }
    }
}

# --- Download and extract PECL extension to the source tree ---
function Install-Pecl-Extension($extName) {
    $extVer = Get-Pecl-Version $extName
    Write-Host "==> Downloading PECL extension: $extName ($extVer)..."
    
    $peclUrl = "https://pecl.php.net/get/$extName-$extVer.tgz"
    $peclTarPath = "$env:TEMP\$extName-$extVer.tgz"
    
    try {
        Invoke-WebRequest -Uri $peclUrl -OutFile $peclTarPath -ErrorAction Stop
        
        $peclDir = "$SrcDir\pecl\$extName"
        New-Item -Path $peclDir -ItemType Directory -Force | Out-Null
        
        # Extract into pecl folder
        tar -xf $peclTarPath -C $peclDir --strip-components=1
        Remove-Item $peclTarPath
        Write-Host "    [OK] Downloaded and staged $extName"
    } catch {
        Write-Host "    [WARN] Failed to fetch PECL extension $extName - skipping"
    }
}

# Download extensions
Install-Pecl-Extension "redis"
Install-Pecl-Extension "xdebug"
Install-Pecl-Extension "mongodb"

cd $SrcDir

# Update Dependencies using phpsdk_deps
Write-Host "==> Updating PHP SDK dependencies..."
& phpsdk_deps --update --branch $Minor

# Buildconf and Configure (MSVC Stack)
Write-Host "==> Configuring PHP build..."
& .\buildconf.bat

# Configure with shared extensions and PECL extensions
& .\configure.bat `
    --prefix=$DistDir `
    --enable-cli `
    --enable-cgi `
    --enable-opcache=shared `
    --enable-mbstring=shared `
    --enable-bcmath=shared `
    --enable-intl=shared `
    --enable-zip=shared `
    --enable-sockets=shared `
    --enable-soap=shared `
    --with-openssl=shared `
    --with-curl=shared `
    --with-mysqli=shared `
    --with-pdo-mysql=shared `
    --with-pdo-pgsql=shared `
    --with-sqlite3=shared `
    --with-pdo-sqlite=shared `
    --enable-redis=shared `
    --enable-xdebug=shared `
    --enable-mongodb=shared

# Compile and install
Write-Host "==> Compiling..."
& nmake
& nmake install

# Locate dynamic extensions (.dll files) in the dist directory
$DistExtDir = Join-Path $DistDir "ext"
if (Test-Path $DistExtDir) {
    Write-Host "==> Packaging dynamic extensions..."
    $Dlls = Get-ChildItem -Path $DistExtDir -Filter "*.dll"
    
    foreach ($Dll in $Dlls) {
        $ExtName = $Dll.BaseName -replace '^php_', ''
        $StagePath = Join-Path $ExtStageDir $ExtName
        New-Item -Path $StagePath -ItemType Directory -Force | Out-Null
        
        # Copy the DLL to staging
        Move-Item -Path $Dll.FullName -Destination $StagePath
        
        # Generate the loading .ini configuration file
        $IniFile = Join-Path $StagePath "$ExtName.ini"
        if ($ExtName -eq "opcache") {
            "zend_extension=php_opcache.dll" | Out-File -FilePath $IniFile -Encoding utf8
        } else {
            "extension=php_$ExtName.dll" | Out-File -FilePath $IniFile -Encoding utf8
        }
        
        # Compress extension
        $ZipName = "ext-$Version-$ExtName-windows-$Arch.zip"
        $ZipPath = Join-Path $OutputDir $ZipName
        Compress-Archive -Path "$StagePath\*" -DestinationPath $ZipPath -Force
        Write-Host "    - packaged extension: $ZipName"
    }
    
    # Remove the empty ext folder from core package
    Remove-Item $DistExtDir -Recurse -Force
}

# Package the remaining core PHP runtime files
Write-Host "==> Packaging PHP Core..."
$CoreZipPath = Join-Path $OutputDir "php-$Version-windows-$Arch.zip"
Compress-Archive -Path "$DistDir\*" -DestinationPath $CoreZipPath -Force
Write-Host "    - packaged core: php-$Version-windows-$Arch.zip"

Write-Host "==> Windows build process completed."