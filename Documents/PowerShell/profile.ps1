# $powershellProfilePath = (split-Path (Split-Path $PROFILE -parent) -parent) + "\PowerShell"
## ENVIRONMENT VARIABLES
# Add custom dirs to PATH
$env:Path += ";C:\Users\madsc\.bin\"

# Chezemoi
$env:EDITOR = 'nvim'
$env:SHELL = 'pwsh'
$env:CD = 'pwsh'

# ALIASES
#
set-alias c clear
set-alias vim nvim
set-alias vscode code
set-alias l dir
set-alias Ex explorer
set-alias cz chezmoi

# FUNCTIONS
#
function update
{
  iex "& { $(irm https://aka.ms/install-powershell.ps1) } -UseMSI"
}
function touch
{
  if ((Test-Path -Path ($args[0])) -eq $false)
  {
    Set-Content -Path ($args[0]) -Value ($null)
  }
}
function Verify-Elevated
{
  # Get the ID and security principal of the current user account
  $myIdentity=[System.Security.Principal.WindowsIdentity]::GetCurrent()
  $myPrincipal=new-object System.Security.Principal.WindowsPrincipal($myIdentity)
  # Check to see if we are currently running "as Administrator"
  return $myPrincipal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
}
# Reload the Shell
function Reload-Powershell
{
  $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
  $newProcess.Arguments = "-nologo";
  [System.Diagnostics.Process]::Start($newProcess);
  exit
}
# Reload the $env object from the registry
function Refresh-Environment
{
  $locations = 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment',
  'HKCU:\Environment'

  $locations | ForEach-Object {
    $k = Get-Item $_
    $k.GetValueNames() | ForEach-Object {
      $name  = $_
      $value = $k.GetValue($_)
      Set-Item -Path Env:\$name -Value $value
    }
  }

  $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}
