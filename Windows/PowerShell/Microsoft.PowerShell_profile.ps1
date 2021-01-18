# =========================================================================== #
# Setting default environment variables
# =========================================================================== #

# Path to dotfiles
$EnvironmentVariableDOTFILES = @{
	Path  = "Env:DOTFILES"
	Value = (Join-Path -Path "$Env:USERPROFILE" -ChildPath ".dotfiles")
}
Set-Item @EnvironmentVariableDOTFILES

# Path to PowerShell configuration directory
$EnvironmentVariablePOWERSHELL_CONFIG_DIR = @{
	Path  = "Env:POWERSHELL_CONFIG_DIR"
	Value = "$Env:DOTFILES\Windows\PowerShell"
}
Set-Item @EnvironmentVariablePOWERSHELL_CONFIG_DIR

# Path to Windows Terminal settings file
$EnvironmentVariableWT_SETTINGS_PATH = @{
	Path  = "Env:WT_SETTINGS_PATH"
	Value = "$Env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json"
}
Set-Item @EnvironmentVariableWT_SETTINGS_PATH

# =========================================================================== #
# Starship - cross-shell prompt
# -----------------------------
# https://starship.rs/
# =========================================================================== #

# Set the environment variable for Starship configuration file
$EnvironmentVariableSTARSHIP_CONFIG = @{
	Path  = "Env:STARSHIP_CONFIG"
	Value = "$Env:DOTFILES\Prompts\.starship.toml"
}
Set-Item @EnvironmentVariableSTARSHIP_CONFIG

# Initiate Starship prompt in PowerShell
Invoke-Expression (&starship init powershell)

# =========================================================================== #
# Load custom defined functions (commands)
# =========================================================================== #
Import-Module "$Env:POWERSHELL_CONFIG_DIR\Custom.Cmdlets.psm1"
