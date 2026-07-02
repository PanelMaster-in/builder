param(
    [string]$Version
)

$ErrorActionPreference = "Stop"

$Arch = "x64" # Default to x64. If running in ARM64 environment, can be configured.
Write-Host "Building PHP $Version for Windows $Arch..."

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
Write-Host "Downloading PHP source..."
$Url = "https://www.php.net/distributions/php-$Version.tar.gz"
$TarPath = "$env:TEMP\php-$Version.tar.gz"
Invoke-WebRequest -Uri $Url -OutFile $TarPath

# Extract using tar
tar -xf $TarPath -C $SrcDir --strip-components=1
Remove-Item $TarPath

cd $SrcDir

# Buildconf and Configure (MSVC Stack)
Write-Host "Configuring PHP build..."
# Load phpsdk tooling in current session if exists
if (Test-Path "C:\php-sdk\bin\phpsdk_env.ps1") {
    . "C:\php-sdk\bin\phpsdk_env.ps1"
}

# Run buildconf.bat
& .\buildconf.bat

# Configure with shared extensions
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
    --with-sqlite3=shared `
    --with-pdo-sqlite=shared

# Compile using nmake
Write-Host "Compiling..."
& nmake
& nmake install

# Locate dynamic extensions (.dll files) in the dist directory
# By default nmake install places extension DLLs in $DistDir\ext
$DistExtDir = Join-Path $DistDir "ext"
if (Test-Path $DistExtDir) {
    Write-Host "Packaging dynamic extensions..."
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
        Write-Host "Packaged Windows extension: $ZipName"
    }
    
    # Remove the empty ext folder from core package
    Remove-Item $DistExtDir -Recurse -Force
}

# Package the remaining core PHP runtime files
Write-Host "Packaging PHP Core..."
$CoreZipPath = Join-Path $OutputDir "php-$Version-windows-$Arch.zip"
Compress-Archive -Path "$DistDir\*" -DestinationPath $CoreZipPath -Force
Write-Host "Packaged Windows PHP Core: php-$Version-windows-$Arch.zip"

Write-Host "Windows build process completed."