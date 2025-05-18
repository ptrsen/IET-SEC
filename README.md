# IET-SEC
Labs

## Prerequisites
- **Windows 10 (or later)** or **Windows 11**
- **PowerShell**
- **Winget CLI** installed (pre-installed on most modern Windows systems)

To verify if `winget` is available, run the following command in PowerShell:

```powershell
winget --version
```


## Install git 
1. To install git, open PowerShell as Administrator and run

```powershell
winget install --id Git.Git -e --source winget
```

2. Once the installation completes, verify that git is installed by running

```powershell
git --version
```

## Install Oracle VirtualBox 
1. To install VirtualBox, open PowerShell as Administrator and run

```powershell
winget install --id Oracle.VirtualBox -e
```
2. Once the installation is complete, verify that VirtualBox is installed via the GUI (Start Menu > Oracle VirtualBox)
3. Visit the official VirtualBox downloads page ( https://www.virtualbox.org/wiki/Downloads ), and under the "VirtualBox Extension Pack" section, click the link to download the extension pack
4. To install the VirtualBox Extension Pack, double-click the downloaded '.vbox-extpack file'. ( The VirtualBox GUI will open and prompt you to install it)





Clone repository

```powershell
git clone [repository_url]
```
