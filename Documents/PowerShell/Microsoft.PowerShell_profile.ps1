## This is the Profile for the current-user on the current-host. This file is NOT managed by chezmoi!
# Oh My Posh
oh-my-posh init pwsh --config 'C:\Users\madsc\AppData\Local\Programs\oh-my-posh\themes\craver.omp.json' | Invoke-Expression

# MODULES
#
Import-Module Terminal-Icons
Import-Module PSFzf
Import-Module PSReadLine
Enable-PowerType

# SHELL
#
Set-PSReadLineOption -PredictionSource HistoryAndPlugin -PredictionViewStyle ListView
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
# Override PSReadLine's history search
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' `
  -PSReadlineChordReverseHistory 'Ctrl+r'

# Override default tab completion
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }
Set-PSReadlineKeyHandler -Chord Ctrl+a -Function BeginningOfLine
Set-PSReadlineKeyHandler -Chord Ctrl+e -Function EndOfLine
if ($host.Name -eq 'ConsoleHost')
{
  # Binding for moving through history by prefix
  Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
  Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
}

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
set-alias gw .\gradlew
set-alias l dir
set-alias Ex explorer
set-alias cz chezmoi

# FUNCTIONS
#
function update
{
  iex "& { $(irm https://aka.ms/install-powershell.ps1) } -UseMSI"
}
function installModule([String] $module)
{
  If (-not(Get-InstalledModule $module -ErrorAction silentlycontinue))
  {
    Write-Host "Module ${module} does not exist. Installing!"
    Install-Module $module -AllowPrerelease -Force
  }
  Import-Module $module
}
function installAllModules()
{
  Get-Install-Module Terminal-Icons
  Get-Install-Module PSFzf
  Get-Install-Module PSReadLine
  Get-Install-Module PowerType
}
