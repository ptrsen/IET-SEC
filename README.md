# IET-SEC
Labs

## Prerequisites
- **Windows 10 (or later)** or **Windows 11**
- **PowerShell**
- **Winget CLI** installed (pre-installed on most modern Windows systems, https://winstall.app/)

To verify if `winget` is available, run the following command in PowerShell:

```powershell
winget --version
```


## Install git 
1. To install git ( https://git-scm.com/downloads ), open PowerShell as Administrator and run

```powershell
winget install --id=Git.Git  -e
```

2. Once the installation completes, verify that git is installed by running

```powershell
git --version
```


## Install Oracle VirtualBox 
1. To install VirtualBox  ( https://www.virtualbox.org/wiki/Downloads ), open PowerShell as Administrator and run

```powershell
winget install --id=Oracle.VirtualBox  -e
```

2. Once the installation is complete, verify that VirtualBox is installed via the GUI (Start Menu > Oracle VirtualBox)
3. Visit the official VirtualBox downloads page ( https://www.virtualbox.org/wiki/Downloads ), and under the "VirtualBox Extension Pack" section, click the link to download the extension pack
4. To install the VirtualBox Extension Pack, double-click the downloaded '.vbox-extpack file'. The VirtualBox GUI will open and prompt you to install it


## Install Vagrant
1. To install Vagrant ( https://developer.hashicorp.com/vagrant/install ), open PowerShell as Administrator and run

```powershell
winget install --id=Hashicorp.Vagrant -e
```

2. Once the installation completes, verify that Vagrant is installed by running

```powershell
vagrant --version
```




Clone repository

```powershell
git clone [repository_url]
```


## Basic VM commands (Vagrant) 

Starts or resumes the VM
```powershell
vagrant up
```

Powers off the VM
```powershell
vagrant halt 
```

Saves VM state (like "sleep")
```powershell
vagrant suspend 
```

Completely deletes the VM and its data
```powershell
vagrant destroy -f
```


