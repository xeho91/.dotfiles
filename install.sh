#!/usr/bin/env bash

# Options explanation:
# `-e` - Exit immediately if a command exits with a non-zero status.
# `-u` - Treat unset variables as an error when substituting.
set -eu

# =========================================================================== #
# Helpers
# =========================================================================== #

# Format the output
# * fg {color} - set foreground color
# * bg {color} - set background color
# * u          - set underline
# * reset      - clear formatting
function format {
	if [ -n "$1" ]; then
		local action=$1
	else
		echo "Formatting action not specified! It can be 'bg', 'fg' or 'reset'."
		exit 1
	fi

	if [[ $action == reset ]]; then
		command tput sgr0
	elif [[ $action == "underline" || $action == "u" ]]; then
		command tput smul
	elif [ -n "$2" ]; then
		declare -A colors=(
			[black]=0
			[red]=1
			[green]=2
			[yellow]=3
			[blue]=4
			[magenta]=5
			[cyan]=6
			[white]=7
		)

		local color=${colors[$2]}

		if [[ $action == bg ]]; then
			command tput setab "$color"
		elif [[ $action == fg ]]; then
			command tput setaf "$color"
		fi
	fi
}

# Override the command `print`
# with a function to print a specified type of output
function print {
	local type=$1
	local message=$2

	declare -A formats=(
		[error]=red
		[warning]=yellow
		[success]=green
		[info]=blue
		[note]=magenta
		[question]=cyan
	)

	declare -A types=(
		[error]="ERROR"
		[warning]="WARNING"
		[success]="SUCCESS"
		[info]="INFO"
		[note]="NOTE"
		[question]="QUESTION"
	)

	printf "$(format bg "${formats[$type]}")${types[$type]}:$(format reset) $(format fg "${formats[$type]}")%s$(format reset)\n" \
		"$message"
}

# =========================================================================== #
# Define currently used Linux's distribution
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
	print error "Sorry, the currently used distribution \"$distro_name\" is not recognized!"
	exit 1
fi

print info "You are on \"$distro_name\" Linux's distribution."
print note "This installator will use \`$package_manager\` as package manager."

# =========================================================================== #
# Determine if Git program is installed
# =========================================================================== #

if [ -x "$(command -v git)" ]; then
	print info "Command \`git\` exists."
else
	print warning "Command \`git\` doesn't exits."

	print question "Do you want to install Git? (Yes/No)"
	read -p "User's decision: " user_wants_to_install_git

	if [[ $user_wants_to_install_git == [Yy]* ]]; then
		print info "Installing \`git\` with \`$package_manager\`..."

		if [[ $package_manager == "apt" ]]; then
			command sudo apt install git
		elif [[ $package_manager == "pacman" ]]; then
			command sudo pacman -S git
		fi
	else
		print error "Installation can't be continued without a Git program."
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
	print error "The directory \"$dotfiles_dir_name\" already exists in the current working directory!"
	exit 1
else
	print note "The dotfiles remote repository URL is: $dotfiles_remote_repository"
	command git clone $dotfiles_remote_repository
	print success "Successfully cloned the dotfiles from the remote repository!"
fi

