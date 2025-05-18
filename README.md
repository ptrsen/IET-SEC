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
To install git, open PowerShell as Administrator and run

```powershell
winget install --id Git.Git -e --source winget
```

Once the installation completes, verify that git is installed by running

```powershell
git --version
```

## Install Oracle VirtualBox 
To install VirtualBox, open PowerShell as Administrator and run

```powershell
winget install --id Oracle.VirtualBox -e
```

Once the installation completes, verify that VirtualBox is installed from the GUI ( Start > Oracle VirtualBox)

download the latest Oracle VM VirtualBox Extension Pack 






Clone repository

```powershell
git clone [repository_url]
```
