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

Clone repository

```powershell
git clone [repository_url]
```
