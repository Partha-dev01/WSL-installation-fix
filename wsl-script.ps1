# admin privilege check
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "Please run this script as Administrator" -ForegroundColor Red
    Exit 1
}

# Error Handle
function Handle-Error {
    param($ErrorMessage)
    Write-Host "Error: $ErrorMessage" -ForegroundColor Red
    Write-Host "Press any key to continue..."
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
}

# Temp Directory
$tempDir = "$env:USERPROFILE\WSLSetup"
New-Item -ItemType Directory -Force -Path $tempDir | Out-Null

try {
    Write-Host "=== Starting WSL Cleanup ===" -ForegroundColor Cyan
    # stop WSL 
    Write-Host "Stopping WSL processes..." -ForegroundColor Yellow
    Get-Process | Where-Object { $_.Name -like "*wsl*" } | Stop-Process -Force -ErrorAction SilentlyContinue
    # remove WSL distros
    Write-Host "Removing existing WSL distributions..." -ForegroundColor Yellow
    $registryPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Lxss"
    if (Test-Path $registryPath) {
        Remove-Item -Path $registryPath -Recurse -Force
    }
    
    # clean up WSL folders
    $foldersToRemove = @(
        "$env:USERPROFILE\AppData\Local\Packages\*WSL*",
        "$env:USERPROFILE\AppData\Local\Microsoft\WindowsApps\Ubuntu*",
        "$env:LOCALAPPDATA\Packages\*Ubuntu*",
        "$env:LOCALAPPDATA\Packages\*WSL*"
    )
    
    foreach ($folder in $foldersToRemove) {
        Get-Item -Path $folder -ErrorAction SilentlyContinue | ForEach-Object {
            Write-Host "Removing $($_.FullName)..." -ForegroundColor Yellow
            Remove-Item -Path $_.FullName -Recurse -Force -ErrorAction SilentlyContinue
        }
    }
    Write-Host "Cleanup completed successfully!" -ForegroundColor Green
    
    # download and install WSL update
    Write-Host "`n=== Starting WSL Installation ===" -ForegroundColor Cyan
    
    $arch = if ([Environment]::Is64BitOperatingSystem) { "x64" } else { "x86" }
    $wslUpdateFile = "$tempDir\wsl_update_$arch.msi"
    
    Write-Host "Step 1: Downloading WSL Update Package..." -ForegroundColor Yellow
    Invoke-WebRequest -Uri "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_$arch.msi" -OutFile $wslUpdateFile
    
    Write-Host "Step 2: Installing WSL Update Package..." -ForegroundColor Yellow
    $installProcess = Start-Process msiexec.exe -ArgumentList "/I `"$wslUpdateFile`" /quiet" -Wait -PassThru
    if ($installProcess.ExitCode -ne 0) {
        throw "WSL Update Package installation failed"
    }
    # enable Windows features
    Write-Host "Step 3: Enabling WSL Features..." -ForegroundColor Yellow
    $features = @(
        "Microsoft-Windows-Subsystem-Linux",
        "VirtualMachinePlatform"
    )
    foreach ($feature in $features) {
        Write-Host "Enabling $feature..." -ForegroundColor Yellow
        $result = dism.exe /online /enable-feature /featurename:$feature /all /norestart
        if ($LASTEXITCODE -ne 0) {
            throw "Failed to enable $feature"
        }
    }
    
    #Repair Windows Store
    Write-Host "Step 4: Repairing Windows Store..." -ForegroundColor Yellow
    Get-AppXPackage *WindowsStore* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
    #install WSL
    Write-Host "Step 5: Installing WSL..." -ForegroundColor Yellow
    winget install --id=9P9TQF7MRM4R -e 
    #cleanup
    Remove-Item -Path $wslUpdateFile -Force -ErrorAction SilentlyContinue
    Remove-Item -Path $tempDir -Force -Recurse -ErrorAction SilentlyContinue
    Write-Host "`n=== Installation Completed Successfully! ===" -ForegroundColor Green
    Write-Host "A system restart is required to complete the installation." -ForegroundColor Yellow
    Write-Host "After restarting, open PowerShell as Administrator and run: wsl --install" -ForegroundColor Yellow
    # prompt restart
    $restart = Read-Host "Would you like to restart now? (y/n)"
    if ($restart -eq 'y') {
        Restart-Computer -Force
    }

} catch {
    Handle-Error $_.Exception.Message
    #error cleanup
    if (Test-Path $wslUpdateFile) {
        Remove-Item -Path $wslUpdateFile -Force
    }
    if (Test-Path $tempDir) {
        Remove-Item -Path $tempDir -Force -Recurse
    }
}
