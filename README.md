


# 🐧 WSL Automated Installation Script 

A robust PowerShell script that automates the Windows Subsystem for Linux (WSL) installation process with comprehensive error handling and system compatibility checks.

## 🚀 Quick Start

1. **Download the Script**

    ```powershell
    git clone https://github.com/Partha-dev01/WSL-installation-fix
    ```

> [!Note]
> Do not run random scripts off the Internet, check what this script does before running it on your machine. 

2. **Run the Installation**

    ```powershell
    # Navigate to that directory and run powershell as administrator. 
    cd wsl-install-script
    .\wsl-script.ps1
    ```


## 🎯 Features

- ✨ Automated WSL installation and configuration
- 🧹 Complete system cleanup of existing WSL installations
- 🛡️ Comprehensive error handling and recovery
- 🔄 Windows Store automatic repair
- 🔍 System compatibility verification

## 📝 Script Processes 

The script performs the following operations:

1. **Pre-Installation Checks**
    - System compatibility verification
    - Administrator privileges validation
    - Internet connectivity check
2. **System Cleanup**
    - Removes existing WSL installations
    - Cleans up related system folders
    - Terminates WSL processes
3. **Core Installation**
    - Downloads and installs WSL update package
    - Enables required Windows features
    - Configures system components
4. **Post-Installation**
    - Windows Store repair
    - WSL core installation
    - System restart prompt

## ⚠️ Important Notes
> [!Note]
> **This Script is not responsible for any broken windows installation be careful before running this. You are responsible for your own machine and data**

- Backup your data before running the script
- System restart is required after installation
- WSL 2 requires virtualization support in BIOS/UEFI
- Installation time varies based on system performance


## 🔧 Troubleshooting

### Official Resources to Troubleshoot WSL

- [Official WSL Documentation](https://docs.microsoft.com/windows/wsl/)
- [WSL Installation Guide](https://docs.microsoft.com/windows/wsl/install)
- [WSL Troubleshooting](https://docs.microsoft.com/windows/wsl/troubleshooting)

 
### Common WSL Installation and Update Issues


| Issue | Solution | Reference |
| --- | --- | --- |
| Access Denied | Run PowerShell as Administrator | [2] |
| Virtualization Not Supported | Enable Virtualization in BIOS/UEFI, and ensure Virtual Machine Platform (VMP) is enabled | [1][2] |
| Download Fails | Check internet connection, try manual installation | [1][4] |
| Store Error | Run Windows Store troubleshooter | [3] |
| WSL Not Found | Verify Windows version compatibility (Windows 10 version 2004 or higher) | [1][4] |
| Kernel Update Missing | Install Linux kernel update MSI package | [4] |
| WSL 2 Update Failure | Run `wsl.exe --update` in an elevated terminal, or manually install the latest version | [2][4] |
| Registry Permission Issues | Ensure proper registry permissions, may require manual adjustment |  |
| Error 0x1bc | Check system locale and language settings, ensure they are set to English | [2] |
| Error 1603 | Ensure latest Windows updates are installed, and try manual installation of WSL | [3] |

### References:

1. WSL Installation Guide:
   https://learn.microsoft.com/en-us/windows/wsl/install

2. Troubleshooting WSL:
   https://learn.microsoft.com/en-gb/windows/wsl/troubleshooting

3. WSL Frequently Asked Questions:
   https://learn.microsoft.com/en-gb/windows/wsl/faq

4. WSL Kernel Update:
   https://aka.ms/wsl2kernel

5. WSL Documentation on GitHub:
   https://github.com/microsoft/WSL

6. WSL Issue Tracker:
   https://github.com/microsoft/WSL/issues

7. Manual Installation Steps for Older Versions:
   https://learn.microsoft.com/en-us/windows/wsl/install-manual

8. WSL Community Forum:
   https://forums.docker.com/c/wsl

9. WSL on Microsoft Learn:
   https://learn.microsoft.com/en-us/windows/wsl/about

10. WSL in the Microsoft Store:
    https://learn.microsoft.com/en-us/windows/wsl/store

11. https://support.overlaxed.com/knowledge-base/article/troubleshoot-common-wsl-installation-errors

12. https://forums.docker.com/t/updating-wsl-update-failed-wsl-exe-update-n-web-download-not-supported/138452

13. https://learn.microsoft.com/en-us/windows/wsl/troubleshooting

14. https://github.com/microsoft/WSL/issues/10527



## 💡 Contributing

> [!question] Need Testers
>  Need some additional testers to verify all WSL issues 
>  Any contribution, additional information or new links to this readme section is greatly appreciated.

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](README.md) file for details.

## 🤝 Support

For support, please:

- Open an [issue](https://github.com/Partha-dev01/WSL-installation-fix/issues)

---

_Last updated: [26-01-2025]_

