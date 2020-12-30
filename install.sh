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
print note "This installation will use \`$package_manager\` as a package manager."

# =========================================================================== #
# Move to the user's home directory (`$HOME`)
# =========================================================================== #

if [[ $PWD == "$HOME" ]]; then
	print info "You are already in \$HOME=\"$PWD\" directory."
else
	cd "$HOME"
	print info "Changed directory to \$HOME=\"$PWD\"."
fi

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

		print success "Installed \`git\` with \`$package_manager\`."
	else
		print error "Installation can't be continued without a Git program!"
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
	print error "The directory \"$dotfiles_dir_name\" already exists in your \$HOME directory!"
	print note "To avoid problems, please backup your existing dotfiles and configurations, then run this installation file again."
	exit 1
else
	print note "The dotfiles remote repository URL is: \"$dotfiles_remote_repository\"."

	command git clone $dotfiles_remote_repository
	print success "Successfully cloned the dotfiles from the remote repository!"
fi

# =========================================================================== #
# Creating a symbolic link to the Git's configuration
# =========================================================================== #

if [ -e ".gitconfig" ]; then
	print error "The Git's configuration \".gitconfig\" already exists in your home directory!"
	print note "To avoid problems, please backup your existing configurations and run this installation file again."
	exit 1
else
	print info "Creating a symbolic link for \"./gitconfig\" from dotfiles in your home directory..."

	command ln --symbolic "./$dotfiles_dir_name/Git/.gitconfig" "./.gitconfig"
	print success "Successfully linked Git's configuration from the dotfiles."
fi

# =========================================================================== #
# Determine which shell to be set as default
# =========================================================================== #

default_shell=""
max_tries=5
attempts=0

print question "Which shell do you want to use as the default one? (Pick option)
          (1 - bash)
          (2 - zsh)"
while [ "$default_shell" != "bash" ] && [ "$default_shell" != "zsh" ]; do
	read -p "User's decision: " user_default_shell_pick

	if [[ $user_default_shell_pick == 1 || $user_default_shell_pick == bash ]]; then
		default_shell="bash"
	elif [[ $user_default_shell_pick == 2 || $user_default_shell_pick == zsh ]]; then
		default_shell="zsh"
	else
		attempts=$((attempts + 1))

		if [ "$attempts" -eq "$max_tries" ]; then
			print error "Eh? This is pointless. Bye."
			exit 1
		else
			print error "This option is not available!"
		fi
	fi
done

# Install the shell if it doesn't exist in the system
if ! [ -x "$(command -v $default_shell)" ]; then
	print warning "The shell \"$default_shell\" is not installed in this system."

	print question "Do you want to install this shell with \`$package_manager\` package manager? (Yes/No)"
	read -p "User's decision: " user_wants_to_install_shell

	if [[ $user_wants_to_install_shell == [Yy]* ]]; then
		print info "Installing \`$default_shell\` with \`$package_manager\`..."

		if [[ "$package_manager" == "apt" ]]; then
			command sudo apt install $default_shell
		elif [[ "$package_manager" == "pacman" ]]; then
			command sudo pacman -S $default_shell
		fi

		print success "Installed \`$default_shell\` with \`$package_manager\`."
	else
		print error "Cannot set \"$default_shell\" as your default shell, because it is not installed."
		exit 1
	fi
else
	print info "Shell \"$default_shell\" program exists in this system."
fi

# Set the default shell to be run on start
if [[ $(basename "$SHELL") == "$default_shell" ]]; then
	print info "You already are using \"$default_shell\" as your default shell."
else
	print note "The installation is going to set this program path \"$(which $default_shell)\" as your default shell."

	print warning "This is an admin operation and you will need to type your user password!"
	command chsh -s "$(which $default_shell)"

	print success "Successfully set \"$default_shell\" as your default shell."
fi

print info "Printing shell's version information..."
command $default_shell --version

# =========================================================================== #
# Create symbolic link to the default shell's file with environment variables
# =========================================================================== #

if [[ "$default_shell" == "bash" ]]; then
	default_shell_config_file=".bash_profile"
elif [[ "$default_shell" == "zsh" ]]; then
	default_shell_config_file=".zshenv"
else
	print error "Something went wrong with determining default shell configuration file."
	exit 1
fi

if [ -e "$default_shell_config_file" ]; then
	print error "The \"$default_shell\" configuration file \"$default_shell_config_file\" already exists in your home directory!"
	print note "To avoid problems, please backup your existing configurations and run this installation file again."
	exit 1
else
	print info "Creating a symbolic link for \"$default_shell_config_file\" from dotfiles in your home directory..."

	# NOTE: https://wiki.bash-hackers.org/syntax/pe?s[]=length#case_modification
	command ln --symbolic "./$dotfiles_dir_name/Linux/${default_shell^}/$default_shell_config_file" "./$default_shell_config_file"
	print success "Successfully linked \"$default_shell\" configuration from the dotfiles."
fi

