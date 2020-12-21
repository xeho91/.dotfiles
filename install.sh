#!/usr/bin/env bash

# Options explanation:
# `-e` - Exit immediately if a command exits with a non-zero status.
# `-u` - Treat unset variables as an error when substituting.
set -eu

# =========================================================================== #
# Helpers
# =========================================================================== #

# --------------------------------------------------------------------------- #
#                                                                      Colors
# --------------------------------------------------------------------------- #
reset_format='\033[0m'
declare -A colors
colors[black]='\033[0;30m'
colors[red]='\033[0;31m'
colors[green]='\033[0;32m'
colors[yellow]='\033[0;33m'
colors[blue]='\033[0;34m'
colors[purple]='\033[0;35m'
colors[cyan]='\033[0;36m'
colors[white]='\033[0;37m'
declare -A bg_colors
bg_colors[black]='\033[0;40m'
bg_colors[red]='\033[0;41m'
bg_colors[green]='\033[0;42m'
bg_colors[yellow]='\033[0;43m'
bg_colors[blue]='\033[0;44m'
bg_colors[purple]='\033[0;45m'
bg_colors[cyan]='\033[0;46m'
bg_colors[white]='\033[0;47m'

# --------------------------------------------------------------------------- #
#                                                      Colored ouput wrappers
# --------------------------------------------------------------------------- #

# NOTE: option (flag) `-e` - enable interpretation of backslash escapes
function error {
	echo -e "${bg_colors[red]}ERROR:${reset_format} ${colors[red]}$1${reset_format}"
}

function warning {
	echo -e "${bg_colors[yellow]}WARNING:${reset_format} ${colors[yellow]}$1${reset_format}"
}

function success {
	echo -e "${bg_colors[green]}SUCCESS:${reset_format} ${colors[green]}$1${reset_format}"
}

function info {
	echo -e "${bg_colors[blue]}INFO:${reset_format} ${colors[blue]}$1${reset_format}"
}

function note {
	echo -e "${bg_colors[purple]}NOTE:${reset_format} ${colors[purple]}$1${reset_format}"
}

function question {
	echo -e "${bg_colors[cyan]}QUESTION:${reset_format} ${colors[cyan]}$1${reset_format}"
}

# =========================================================================== #
# Definining currently used Linux's distribution
# =========================================================================== #

distro_name=$( \
	cat /etc/*-release \
	| grep --only-matching --perl-regexp '(?<=^NAME=\").*(?=\")' \
)

if [[ $distro_name == "Arch Linux" ]]; then
	package_manager="pacman"
elif [[ $distro_name =~ "Debian" || $distro_name =~ "Ubuntu" ]]; then
	package_manager="apt"
else
	error "Sorry, the currently used distribution \"$distro_name\" is not recognized!"
	exit 1
fi

info "You are on \"$distro_name\" Linux's distribution."
note "The used package manager will be \`$package_manager\`."

# =========================================================================== #
# Determining if Git is installed
# =========================================================================== #

if [ -x "$(command -v git)" ]; then
	info "Command \`git\` exists."
else
	warning "Command \`git\` doesn't exits."

	question "Do you want to install Git? (Yes/No)"
	read -p "Decision: " user_wants_to_install_git < /dev/tty

	if [[ $user_wants_to_install_git == [Yy]* ]]; then
		info "Installing \`git\` with \`$package_manager\`..."

		if [[ $package_manager == "apt" ]]; then
			command sudo apt install git
		elif [[ $package_manager == "pacman" ]]; then
			command sudo pacman -S git
		fi
	else
		error "Installation can't be continued without a Git program."
		exit 1
	fi
fi

# =========================================================================== #
# Cloning dotfiles from the remote repository
# =========================================================================== #

dotfiles_remote_repository="https://github.com/xeho91/.dotfiles.git"
dotfiles_dir_name="$( \
	basename "$dotfiles_remote_repository" \
	| grep --only-matching --perl-regexp '.*(?=\.git)' \
)"

if [ -d "$dotfiles_dir_name" ]; then
	error "The directory \"$dotfiles_dir_name\" already exists in the current working directory!"
	exit 1
else
	note "The dotfiles remote repository URL is: $dotfiles_remote_repository"
	command git clone $dotfiles_remote_repository
	success "Successfully cloned the dotfiles from the remote repository!"
fi

