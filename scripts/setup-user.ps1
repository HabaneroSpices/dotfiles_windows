Push-Location $ENV:DOTFILES_DIR
.\scripts\lib\lib_shell.ps1

log("debug", "OS is $ENV:OS")
Pop-Location


