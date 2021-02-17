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
	Value = "$Env:DOTFILES\Shells\PowerShell"
}
Set-Item @EnvironmentVariablePOWERSHELL_CONFIG_DIR

# Path to Windows Terminal settings file
$EnvironmentVariableWT_SETTINGS_PATH = @{
	Path  = "Env:WT_SETTINGS_PATH"
	Value = "$Env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json"
}
Set-Item @EnvironmentVariableWT_SETTINGS_PATH

# =========================================================================== #
# Other variables
# =========================================================================== #
#$EDITOR = "nvim --wait"

# =========================================================================== #
# Scoop & CLI tools
# =========================================================================== #

# Install scoop if it doesn't exist
if (-Not (Get-Command "scoop" -errorAction SilentlyContinue)) {
	$scoopDownloadURL = "https://get.scoop.sh"
	Invoke-Expression (New-Object System.Net.WebClient).DownloadString("$scoopDownloadURL")
	Invoke-Expression ("scoop bucket add versions")
	Invoke-Expression ("scoop bucket add extras")
}

# Neovim
if (-Not (Get-Command "nvim" -errorAction SilentlyContinue)) {
	Invoke-Expression ("scoop install neovim-nightly")
}

# Fzf
if (-Not (Get-Command "fzf" -errorAction SilentlyContinue)) {
	Invoke-Expression ("scoop install fzf")
}

# Delta
if (-Not (Get-Command "delta" -errorAction SilentlyContinue)) {
	Invoke-Expression ("scoop install delta")
}

# Lazygit
if (-Not (Get-Command "lazygit" -errorAction SilentlyContinue)) {
	Invoke-Expression ("scoop install lazygit")
}

# Starship
if (-Not (Get-Command "starship" -errorAction SilentlyContinue)) {
	Invoke-Expression ("scoop install starship")
}

# Bat
if (-Not (Get-Command "bat" -errorAction SilentlyContinue)) {
	Invoke-Expression ("scoop install bat")
}

# fd
if (-Not (Get-Command "fd" -errorAction SilentlyContinue)) {
	Invoke-Expression ("scoop install fd")
}

# tre
if (-Not (Get-Command "tre" -errorAction SilentlyContinue)) {
	Invoke-Expression ("scoop install tre-command")
}

# dotenv-linter
if (-Not (Get-Command "dotenv-linter" -errorAction SilentlyContinue)) {
	Invoke-Expression ("scoop bucket add dotenv-linter https://github.com/dotenv-linter/scoop.git")
	Invoke-Expression ("scoop install dotenv-linter/dotenv-linter")
}

# =========================================================================== #
# Aliases
# =========================================================================== #
if (Get-Command "code-insiders" -errorAction SilentlyContinue) {
	Set-Alias -Name "code" -Value "code-insiders"
}

if (Get-Command "lazygit" -errorAction SilentlyContinue) {
	Set-Alias -Name "lg" -Value "lazygit"
}

if (Get-Command "bat" -errorAction SilentlyContinue) {
	Set-Alias -Name "cat" -Value "bat"
}

# =========================================================================== #
# Completions
# =========================================================================== #

# Chocolatey
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
	Import-Module "$ChocolateyProfile"
}

# Scoop
Import-Module "$($(Get-Item $(Get-Command scoop).Path).Directory.Parent.FullName)\modules\scoop-completion"

# Git
if (-Not(Get-Command "Add-PoshGitToProfile" -errorAction SilentlyContinue)) {
	Invoke-Expression("scoop install posh-git")
	Add-PoshGitToProfile
}

# =========================================================================== #
# Load custom defined functions (commands)
# =========================================================================== #
Import-Module "$Env:POWERSHELL_CONFIG_DIR\Custom.Cmdlets.psm1"

# =========================================================================== #
# Starship - cross-shell prompt
# -----------------------------
# https://starship.rs/
# =========================================================================== #

# Set the environment variable for Starship configuration file
$EnvironmentVariableSTARSHIP_CONFIG = @{
	Path  = "Env:STARSHIP_CONFIG"
	Value = "$Env:DOTFILES\Shells\Prompts\.starship.toml"
}
Set-Item @EnvironmentVariableSTARSHIP_CONFIG

# Initiate Starship prompt in PowerShell
Invoke-Expression (&starship init powershell)
