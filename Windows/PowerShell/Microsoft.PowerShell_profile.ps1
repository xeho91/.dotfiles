# =========================================================================== #
# Setting default environment variables
# =========================================================================== #
$EnvironmentVariableDOTFILES = @{
	Path = "Env:DOTFILES"
	Value = (Join-Path -Path "$HOME" -ChildPath ".dotfiles")
}
Set-Item @EnvironmentVariableDOTFILES

# =========================================================================== #
# Starship - cross-shell prompt
# -----------------------------
# https://starship.rs/
# =========================================================================== #

# Set environment variable for importing configuration file
$EnvironmentVariableSTARSHIP_CONFIG = @{
	Path = "Env:STARSHIP_CONFIG"
	Value = (Join-Path -Path "$Env:DOTFILES" -ChildPath "Prompts/.starship.toml")
}
Set-Item @EnvironmentVariableSTARSHIP_CONFIG

# Initiate Starship prompt in PowerShell
Invoke-Expression (&starship init powershell)
