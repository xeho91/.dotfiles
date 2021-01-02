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
		print error "The installation can't be continued without these program(s)!"
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

# Install a specific program if it doesn't exist
function install_program_if_doesnt_exist {
	local program=$1

	if ! [ -x "$(command -v "$program")" ]; then
		print warning "The program \"$program\" is not installed in this system."

		print question "Do you want to install this program with \`$package_manager\` package manager? (Yes/No)"
		install_program "$program"
	else
		print info "The program \"$program\" already exists in this system."
	fi
}

# Pick an option from the provided list
function pick_option () {
	local -n options=$1
	local result_variable_name=$2
	local max_tries=5
	local attempts=0
	local user_pick=0

	printf "%sAvailable options (pick one from the list below)\n" "$(format fg cyan)"
	for index in "${!options[@]}"; do
		printf "(%d) ${options[$index]}\n" "$((index + 1))"
	done
	printf "%s" "$(format reset)"

	while ! [[ $user_pick -gt 0 && $user_pick -le "${#options[@]}" ]]; do
		read -p "Pick option: " user_pick

		if [[ $user_pick -gt 0 && $user_pick -le "${#options[@]}" ]]; then
			export "$result_variable_name"="${options[$((user_pick - 1))]}"
		else
			attempts=$((attempts + 1))

			if [ "$attempts" -eq "$max_tries" ]; then
				print error "Eh? This is pointless. Bye."
				exit 1
			else
				print error "This option is not available! Lets try again (Attempt $((attempts + 1)) of $max_tries)"
			fi
		fi
	done
}

# Print the short output of the program version
function print_version {
	local program=$1

	print info "Printing $program's version information..."
	command "$program" --version | head --lines -1
}

# =========================================================================== #
# Get the name of currently used Linux's distribution
# and determine its package manager
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

# Create a symbolic link to the Git's configuration
create_symlink "Git"

# =========================================================================== #
# Determine which shell to be set as default
# =========================================================================== #

# shellcheck disable=SC2034
shell_options=("zsh" "bash")
default_shell=""
print question "Which shell do you want to use as the default one?"
pick_option shell_options "default_shell"

# Install the shell if it doesn't exist in the system
install_program_if_doesnt_exist "$default_shell"

# Set the default shell to be run on start
if [[ $(basename "$SHELL") == "$default_shell" ]]; then
	print info "You already are using \"$default_shell\" as your default shell."
else
	print note "This program path \"$(which "$default_shell")\" will be set as your default shell."

	command sudo usermod --shell "$(which "$default_shell")" "$(whoami)"

	print success "Set \"$default_shell\" as your default shell."
fi

# Print version
print_version "$default_shell"

# Create symbolic link to the default shell's configuration file
create_symlink "${default_shell^}"

# =========================================================================== #
# Determine the default editor to install
# =========================================================================== #

# shellcheck disable=SC2034
editor_options=("nvim" "vim")
default_editor=""
print question "Which editor do you want to set as the default one?"
pick_option editor_options "default_editor"

# Install the default editor if it doesn't exist in the system
install_program_if_doesnt_exist "$default_editor"

# Print version
print_version "$default_editor"

# =========================================================================== #
# Finish the installation by starting the set default shell
# =========================================================================== #

exec "$default_shell"

