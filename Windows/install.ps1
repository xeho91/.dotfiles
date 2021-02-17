$ErrorActionPreference = "Stop"

$ProgramsToInstall = @(
	# Chocolatey
	"chocolateygui",
	"choco-cleaner",
	# Tools
	"7zip",
	"bleachbit",
	# Developer tools
	"gsudo",
	[PSCustomObject]@{
		name    = "microsoft-windows-terminal"
		options = "--pre"
	},
	[PSCustomObject]@{
		name    = "git"
		options = "--params '/NoAutoCrlf /WindowsTerminal /NoShellIntegration'"
	},
	"gh",
	"gpg4win",
	"make",
	# Programming languages environments
	"powershell-core",
	"pyenv-win",
	"nvm.portable",
	# Productivity tools
	"powertoys",
	"bitwarden",
	"bitwarden-cli",
	"authy-desktop",
	"auto-dark-mode",
	"nextcloud-client",
	"joplin",
	# Security
	"protonvpn",
	# Communicators
	"signal",
	# Browsers
	"Firefox",
	"microsoft-edge-insider-dev"
)
$DotfilesRepositoryURL = "https://github.com/xeho91/.dotfiles.git"

# ============================================================================ #
# Helpers
# ============================================================================ #

$StartingLocation = (Get-Location).Path
$DotfilesDirName = [System.IO.Path]::GetFileNameWithoutExtension("$DotfilesRepositoryURL")

# Wrapper for logging the colored output messages based on type
function Log {
	param(
		[String]$logType,
		[String]$message
	)

	$colors = @(
		[PSCustomObject]@{
			name  = "info"
			color = "DarkBlue"
		}
		[PSCustomObject]@{
			name  = "error"
			color = "DarkRed"
		}
		[PSCustomObject]@{
			name  = "warning"
			color = "DarkYellow"
		}
		[PSCustomObject]@{
			name  = "success"
			color = "DarkGreen"
		}
		[PSCustomObject]@{
			name  = "note"
			color = "DarkMagenta"
		}
	)
	$logTypeColor = ($colors | Where-Object { $_.name -eq $logType }).color

	Write-Host "$($logType.ToUpper()):" -BackgroundColor $logTypeColor -ForegroundColor White -NoNewline
	Write-Host " $message" -ForegroundColor $logTypeColor
}

# ============================================================================ #
# Features
# ============================================================================ #

function Install-Chocolatey {
	Log info "Verifying if the Chocolatey command (``choco``) exists..."

	# Install if `choco` is NOT installed
	if (-Not (Get-Command "choco" -errorAction SilentlyContinue)) {
		Log warning "Command ``choco`` doesn't exist."

		$ChocolateyInstallURL = "https://chocolatey.org/install.ps1"

		Set-ExecutionPolicy Bypass -Scope Process -Force
		[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
		Invoke-Expression ((New-Object System.Net.WebClient).DownloadString($ChocolateyInstallURL))

		# Verify that there was no problem with the installation
		if (Get-Command "choco" -errorAction SilentlyContinue) {
			Log success "Command ``choco`` successfully installed."
		} else {
			Log error "Something went wrong with the installation of Chocolatey (``choco``)."
			Exit 1
		}
	} else {
		Log note  "Command exists, continuing the installation."
	}
}

function Install-Programs {
	Log info "Using Chocolatey (``choco``) to install programs..."

	foreach ($program in $ProgramsToInstall) {
		$itemType = $program.getType().Name

		if ($itemType -eq "String") {
			Invoke-Expression ("choco install $program --yes")
		} elseif ($itemType -eq "PSCustomObject") {
			Write-Host "$($program.name) $($program.options)"
			Invoke-Expression ("choco install $($program.name) --yes $($program.options)")
		}
	}

	Log note "Finished installing programs."
}

function Receive-Dotfiles {
	Log info "Verifying if command ``git`` exists..."

	if (Get-Command "git" -errorAction SilentlyContinue) {
		Log note "Program ``git`` exists."

		Log info "Cloning dotfiles from the '$DotfilesRepositoryURL' repository..."
		Invoke-Expression("git clone $DotfilesRepositoryURL")
	} else {
		Log error "Program Git (``git``) doesn't exist and is required to complete this installation."
		Exit 1
	}
}

function New-Symlink {
	param(
		$fileName,
		$locationInDotfiles
	)
	$options = @{
		ItemType = "SymbolicLink"
		Target   = "$Env:USERPROFILE\$DotfilesDirName\$locationInDotfiles"
		Path     = "$Env:USERPROFILE\$fileName"
	}
	New-Item @options
}

function Set-Links {
	Log info "Creating symbolic links to configurations from the dotfiles..."
	New-Symlink ".gitconfig" "Git/.gitconfig"
	New-Symlink ".editorconfig" "Editors/.editorconfig"
	Log success "Successfully created symlinks."
}

function Set-SourcingToPowershellProfile {
	$profilePath = "$Env:USERPROFILE\$DotfilesDirName\Shells\PowerShell\Microsoft.PowerShell_profile.ps1"

	(-Join (
		"`$PROFILE = $profilePath`n",
		'. $PROFILE'
	))| Out-File -FilePath "$PROFILE"
}
Set-SourcingToPowershellProfile

# ============================================================================ #
# Main runtime
# ============================================================================ #
function Main {
	# Check if current working directory is User's home and change if not
	if (-Not ($StartingLocation -eq $Env:USERPROFILE)) {
		Log info "Changing location to '$Env:USERPROFILE'..."
		Set-Location $Env:USERPROFILE
		Log success "Successfully changed to user's home directory."
	}
	Log note "You are in User's home directory."

	Install-Chocolatey
	Install-Programs
	Receive-Dotfiles
	Set-Links
	Set-SourcingToPowershellProfile

	# Return to previous working location
	if (-Not ($StartingLocation -eq $Env:USERPROFILE)) {
		Log info "Returning to previous location '$StartingLocation..."
		Set-Location $StartingLocation
		Log note "Changed to previous (starting) location."
	}
}

Log info "Starting the installation..."
Main
Log success "Installation finished."
