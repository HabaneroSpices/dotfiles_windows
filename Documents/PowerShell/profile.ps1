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