#!/usr/bin/env bash

# Options explanation:
# `-e` - Exit immediately if a command exits with a non-zero status.
# `-u` - Treat unset variables as an error when substituting.
set -eu

# =========================================================================== #
# Settings to configure
# =========================================================================== #
dotfiles_remote_repository="https://github.com/xeho91/.dotfiles.git"
declare -A config_files=(
	[Git]="Git/.gitconfig"
	[Bash]="Linux/Bash/.bash_profile"
	[Zsh]="Linux/Zsh/.zhsenv"
)

# =========================================================================== #
# Helpers
# =========================================================================== #

# Get the baseame of dotfiles directory
dotfiles_dir_name="$( \
	command basename "$dotfiles_remote_repository" \
	| grep --only-matching --perl-regexp '.*(?=\.git)' \
)"

# Format the output
# * fg {color} - set foreground color
# * bg {color} - set background color
# * u          - set underline
# * reset      - clear formatting
function format {
	if [ -n "$1" ]; then
		local action=$1
	else
		echo "Formatting action not specified!"
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

# Install the desired program(s)
function install_program {
	local program=$1

	read -p "User's decision: " user_wants_to_install_program

	# ... install missing programs
	if [[ $user_wants_to_install_program == [Yy]* ]]; then
		print info "Installing \`$program\` with \`$package_manager\`..."

		if [[ $package_manager == "apt" ]]; then
			command sudo apt install "$program"
		elif [[ $package_manager == "pacman" ]]; then
			command sudo pacman -S "$program"
		fi

		print success "Installed \`$program\` with \`$package_manager\`."
	else
		print error "The installation can't be continued without this program!"
		exit 1
	fi
}

# Create symbolic link to a specific configuration file from the dotfiles
function create_symlink {
	local config_file_path=${config_files[$1]}
	# shellcheck disable=SC2155
	local file_name=$(command basename "$config_file_path")

	if [ -e "$file_name" ]; then
		print error "The Git's configuration \"$file_name\" already exists in your home directory!"
		print note "To avoid problems, please backup your existing configurations and run this installation file again."
		exit 1
	else
		print info "Creating a symbolic link for \"$file_name\" from dotfiles in your home directory..."

		command ln --symbolic "$HOME/$dotfiles_dir_name/$config_file_path" "$HOME/$file_name"
		print success "Created a symbolic link for \"$file_name\" configuration from the dotfiles."
	fi
}

# =========================================================================== #
# Get the name of currently used Linux's distribution
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
print note "This installation will use \`$package_manager\` package manager."

# =========================================================================== #
# Move to the user's home directory (`$HOME`)
# =========================================================================== #

if [[ $PWD == "$HOME" ]]; then
	print info "You are already in \$HOME=\"$PWD\" directory."
else
	cd "$HOME"
	print info "Changing current working directory to \$HOME=\"$PWD\"."
fi

# =========================================================================== #
# Check if required programs exists, and if not, install the missing ones
# =========================================================================== #

required_programs=(git which)

# Determine a list of missing programs
missing_programs=""
for program in ${required_programs[*]}; do
	if ! [ -x "$(command -v "$program")" ]; then
		if [ -z "$missing_programs" ]; then
			missing_programs+="${program}"
		else
			missing_programs+=" ${program}"
		fi
	fi
done

# Check if there are missing programs...
if [ -n "$missing_programs" ]; then
	print warning "The following programs required for this installation are missing: \"$missing_programs\"."

	print question "Do you want to install them with \`$package_manager\` package manager? (Yes/No)"
	install_program "$missing_programs"
fi

# =========================================================================== #
# Clone dotfiles from the remote repository
# =========================================================================== #

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

create_symlink "Git"

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
	install_program "$default_shell"
else
	print info "Shell \"$default_shell\" program already exists in this system."
fi

# Set the default shell to be run on start
if [[ $(basename "$SHELL") == "$default_shell" ]]; then
	print info "You already are using \"$default_shell\" as your default shell."
else
	print note "The installation is going to set this program path \"$(which $default_shell)\" as your default shell."

	command chsh -s "$(which $default_shell)"

	print success "Set \"$default_shell\" as your default shell."
fi

print info "Printing shell's version information..."
command $default_shell --version

# =========================================================================== #
# Create symbolic link to the default shell's file with environment variables
# =========================================================================== #

create_symlink "${default_shell^}"

