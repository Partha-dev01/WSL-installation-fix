# admin privilege check
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Please run this script as Administrator" -ForegroundColor Red
    Exit 1
}

#download WSL according to windows version
$arch = if ([Environment]::Is64BitOperatingSystem) { "x64" } else { "x86" }
Write-Host "Downloading WSL update package..." -ForegroundColor Yellow
Invoke-WebRequest -Uri "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_$arch.msi" -OutFile "$env:TEMP\wsl_update_$arch.msi"
Start-Process msiexec.exe -Wait -ArgumentList "/I $env:TEMP\wsl_update_$arch.msi /quiet"

#enable needed windows features
Write-Host "Enabling Windows features..." -ForegroundColor Yellow
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

#repair windows store
Write-Host "Repairing Windows Store..." -ForegroundColor Yellow
Get-AppXPackage *WindowsStore* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}

#wsl install
Write-Host "Installing WSL..." -ForegroundColor Yellow
winget install --id=9P9TQF7MRM4R -e  # WSL store ID

# final cleanup
Remove-Item "$env:TEMP\wsl_update_$arch.msi" -ErrorAction SilentlyContinue

Write-Host "`nInstallation completed successfully!" -ForegroundColor Green
Write-Host "Please restart your computer to complete the setup." -ForegroundColor Yellow
