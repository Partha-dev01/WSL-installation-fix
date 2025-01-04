# WSL Installation Script

A PowerShell script to automate the installation of Windows Subsystem for Linux (WSL).

## Description

This script automates the complete installation process of WSL by:
- Downloading and installing the WSL update package
- Enabling required Windows features
- Repairing the Windows Store (if needed)
- Installing WSL from the Microsoft Store

## Prerequisites

- Windows 10 version 2004 and higher (Build 19041 and higher) or Windows 11
- PowerShell with administrator privileges
- Active internet connection
- Windows Store access

## Usage

1. Right-click on PowerShell and select "Run as Administrator"
2. Navigate to the script's directory
3. To Run the script:

```ps1
.\wsl-script.ps1
```