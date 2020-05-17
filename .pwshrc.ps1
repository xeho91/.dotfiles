# Set environment variable with path to WSL home directory
$ENV:WSL_HOME_PATH = "\\wsl$\Ubuntu\home\xeho91"

# =============================
# Starship - cross-shell prompt
# =============================
# https://starship.rs/
# https://github.com/starship/starship
#
# Import configuration file
$ENV:STARSHIP_CONFIG = "$HOME\.dotfiles\.starship.toml"
# Initiate Starship prompt in PowerShell
Invoke-Expression (&starship init powershell)
