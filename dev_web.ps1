# Description: Boxstarter Script
# Author: Microsoft
# Common dev settings for web dev

Disable-UAC

#--- Windows Features ---
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions -EnableShowFullPathInTitleBar

#--- File Explorer Settings ---
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneExpandToCurrentFolder -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneShowAllFolders -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name MMTaskbarMode -Value 2

#--- Tools ---
choco install -y vscode
RefreshEnv

code --install-extension msjsdiag.debugger-for-chrome
code --install-extension msjsdiag.debugger-for-edge

choco install -y git -params '"/GitAndUnixToolsOnPath /WindowsTerminal"'
choco install -y 7zip.install

#--- Windows Subsystems/Features ---
choco install -y Microsoft-Hyper-V-All -source windowsFeatures
choco install Microsoft-Windows-Subsystem-Linux -source windowsfeatures

#--- Ubuntu ---
Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1604 -OutFile ~/Ubuntu.appx -UseBasicParsing
Add-AppxPackage -Path ~/Ubuntu.appx

<#
#--- SLES ---
# Install SLES Store app
Invoke-WebRequest -Uri https://aka.ms/wsl-sles-12 -OutFile ~/SLES.appx -UseBasicParsing
Add-AppxPackage -Path ~/SLES.appx
# Launch SLES
sles-12.exe

# --- openSUSE ---
Invoke-WebRequest -Uri https://aka.ms/wsl-opensuse-42 -OutFile ~/openSUSE.appx -UseBasicParsing
Add-AppxPackage -Path ~/openSUSE.appx
# Launch openSUSE
opensuse-42.exe
#>

#--- Browsers ---
choco install -y googlechrome
choco install -y firefox

#--- Microsoft WebDriver ---
choco install -y microsoftwebdriver

#--- Fonts ---
choco install -y inconsolata
# choco install -y ubuntu.font

#--- Tools ---
choco install -y sysinternals
choco install -y docker-for-windows
choco install -y python

choco install -y visualstudio2017enterprise
choco install -y resharper
choco install -y intellijidea-ultimate
choco install -y cmder
choco install -y notepadplusplus
choco install -y poshgit
choco install -y nuget.commandline
choco install -y cake.portable
choco install -y slack
choco install -y awscli
choco install -y gitversion.portable
choco install -y vmwarevsphereclient
choco install -y terraform
choco install -y sbt
choco install -y packer
choco install -y nodejs
choco install -y kubernetes-helm
choco install -y kubernetes-cli
choco install -y jq
choco install -y jdk8
choco install -y hugo
choco install -y gradle
choco install -y cloudberryexplorer.amazons3
choco install -y sql-server-management-studio
choco install -y foxitreader
choco install -y listary
choco install -y vlc


choco install -y IIS-WebServerRole -source WindowsFeatures


$TaskBarPinnedItems = @(
  "${env:programfiles(x86)}/Google/Chrome/Application/chrome.exe",
  "${env:programfiles(x86)}/vim/vim74/gvim.exe",
  "${env:windir}\system32\WindowsPowerShell\v1.0\PowerShell_ISE.exe",
  "${env:programfiles}\VideoLAN\VLC\vlc.exe",
  "${env:localappdata}\slack\slack.exe"
)

Write-BoxstarterMessage "Setting pinned items to taskbar"
$TaskBarPinnedItems | ForEach-Object { Install-ChocolateyPinnedTaskBarItem $_ }

Write-BoxstarterMessage "Trusting Powershell repositories"

Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

# NuGet is a prerequisite for Install-Module
Write-BoxstarterMessage "Installing OneGet package providers"
Install-PackageProvider -Name NuGet

$PSModulesToInstall = @(
    "Carbon",
    "PSReadline",
    "Posh-SSH",
    "Pester"
)
Write-BoxstarterMessage "Installing Powershell modules"
$PSModulesToInstall | ForEach-Object { Install-PSModule $_ }
# Download powershell help files (like man pages) for local consumption
Write-BoxstarterMessage "Updating Powershell help"
Update-Help


Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
