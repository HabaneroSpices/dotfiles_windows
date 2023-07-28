if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator'))
{
  if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000)
  {
    $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
    Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
    Exit
  }
}

PING.EXE 1.1.1.1

### Package Providers
Write-Host "Installing Package Providers..." -ForegroundColor "Yellow"
Get-PackageProvider NuGet -Force | Out-Null

### Install PowerShell Modules
Write-Host "Installing PowerShell Modules..." -ForegroundColor "Yellow"
Install-Module Posh-Git -Scope CurrentUser -Force
Install-Module PSWindowsUpdate -Scope CurrentUser -Force

# system and cli
Write-Host "Installing Git"
winget install Git.Git                                   --silent --accept-package-agreements --override "/VerySilent /NoRestart /o:PathOption=CmdTools /Components=""icons,assoc,assoc_sh,gitlfs"""
Write-Host "Installing NodeJS"
winget install OpenJS.NodeJS                             --silent --accept-package-agreements
Write-Host "Installing Python3"
winget install Python.Python.3                           --silent --accept-package-agreements

# browsers
Write-Host "Installing Firefox"
winget install Mozilla.Firefox                           --silent --accept-package-agreements

# dev tools and frameworks
Write-Host "Installing PowershellCore"
winget install Microsoft.PowerShell                      --silent --accept-package-agreements
Write-Host "Installing Neovim"
winget install Neovim.Neovim                             --silent --accept-package-agreements

# Refresh environment
Refresh-Environment

### Node Packages
Write-Host "Installing Node Packages..." -ForegroundColor "Yellow"
if (which npm)
{
  npm update npm
}
