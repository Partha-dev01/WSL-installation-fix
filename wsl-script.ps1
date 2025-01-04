# download WSL according to windows version
$arch = if ([Environment]::Is64BitOperatingSystem) { "x64" } else { "x86" }
Invoke-WebRequest -Uri "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_$arch.msi" -OutFile "$env:TEMP\wsl_update_$arch.msi"
Start-Process msiexec.exe -Wait -ArgumentList "/I $env:TEMP\wsl_update_$arch.msi /quiet"

# enable needed windows features
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# repair windows store
Get-AppXPackage *WindowsStore* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}

# wsl install
winget install --id=9P9TQF7MRM4R -e  # WSL Store ID

# final cleanup
Remove-Item "$env:TEMP\wsl_update_$arch.msi" -ErrorAction SilentlyContinue
