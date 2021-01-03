#!/usr/bin/env bash

# Options explanation:
# * `-e` - exit immediately if a command exits with a non-zero status
# * `-u` - treat unset variables as an error when substituting
set -eu

# =========================================================================== #
# Variables for installation configuration
# =========================================================================== #

# URL to the remote repository to the dotfiles
dotfiles_remote_repository="https://github.com/xeho91/.dotfiles.git"

# List of configuration files for programs to be used/installed
declare -A config_files=(
	[git]="Git/.gitconfig"
	[bash]="Linux/Bash/.bash_profile"
	[zsh]="Linux/Zsh/.zshenv"
)

# =========================================================================== #
# Helpers
# =========================================================================== #

# Get the basename of dotfiles directory
dotfiles_dir_name="$( \
	command basename "$dotfiles_remote_repository" \
	| grep --only-matching --perl-regexp '.*(?=\.git)' \
)"

# Associative array with colors for `tput` program
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

# Associative array with output color formats for specified types
declare -A formats=(
	[error]=red
	[warning]=yellow
	[success]=green
	[info]=blue
	[note]=magenta
	[question]=cyan
)

# Associative array with output prefixes for specified types
declare -A prefixes=(
	[error]="ERROR"
	[warning]="WARNING"
	[success]="SUCCESS"
	[info]="INFO"
	[note]="NOTE"
	[question]="QUESTION"
)

# --------------------------------------------------------------------------- #
#                                         Formatting the output (with `tput`)
# --------------------------------------------------------------------------- #
# Available effect options:
# * fg {color} - set foreground color
# * bg {color} - set background color
# * u          - set underline
# * reset      - clear formatting
function format {
	# Verify if any format option was given
	if [ -n "$1" ]; then
		local effect=$1
	else
		printf "Formatting effect not specified!"
	fi

	# Determine format based on the option
	if [[ $effect == reset ]]; then
		command tput sgr0
	elif [[ $effect == "u" ]]; then
		command tput smul
	elif [[ $effect == "bg" || $effect == "fg" ]]; then
		#  Check if color was given as second argument
		if [ -n "$2" ]; then
			# Verify if color name exists
			if [[ -v colors[$2] ]]; then
				local color=${colors[$2]}
			else
				printf "Specifed color is not recognized!"
			fi
		else
			printf "No color name was given as argument!"
		fi

		# Return desired formatting
		if [[ $effect == bg ]]; then
			command tput setab "$color"
		elif [[ $effect == fg ]]; then
			command tput setaf "$color"
		fi
	else
		printf "Unknown format option was given!"
	fi
}

# --------------------------------------------------------------------------- #
#                                                Override the command `print`
#                         with a function to print a specified type of output
# --------------------------------------------------------------------------- #
function print {
	# Check if any type was passed as argument
	if [ -n "$1" ]; then
		# Verify if the given type exists
		if [[ -v prefixes[$1] ]]; then
			local type=$1
		# The name of installation part then?
		elif [[ $1 == "part" ]]; then
			local part_name=$2
			printf -- "------ [ %s ] ------\n" "$part_name"
			return 0
		else
			printf "Specified output type is not recognized!"
			return 1
		fi
	else
		printf "No type was passed as a argument!"
	fi

	# Check if a message was passed as argument
	if [ -n "$2" ]; then
		local message=$2
	else
		printf "No message was given as a argument!"
	fi

	# Return formatted output and fold it by spaces if is too long
	printf "$(format bg "${formats[$type]}")${prefixes[$type]}:$(format reset) $(format fg "${formats[$type]}")%s$(format reset)\n" \
		"$message" | fold --spaces
}

# --------------------------------------------------------------------------- #
#                                                        Confirm the decision
# --------------------------------------------------------------------------- #
function confirm {
	printf "%s[Y]yes / [N]no%s\n" "$(format fg cyan)" "$(format reset)"
	read -r -p "User's decision: " decision

	if [[ $decision == [Yy]* ]]; then
		return 0
	else
		return 1
	fi
}

# --------------------------------------------------------------------------- #
#                            Pick an option from the provided list of options
# --------------------------------------------------------------------------- #
function pick_option () {
	local -n options=$1
	local result_variable_name=$2
	local max_tries=5
	local attempt=1
	local user_pick=0

	# Print available options...
	printf "%sAvailable options (pick one from the list below)\n" "$(format fg cyan)"
	for index in "${!options[@]}"; do
		printf "(%d) ${options[$index]}\n" "$((index + 1))"
	done
	printf "%s" "$(format reset)"

	# Get the option pick from the user and verify it with limited attempts
	while ! [[ $user_pick -gt 0 && $user_pick -le "${#options[@]}" ]]; do
		read -r -p "Pick option: " user_pick

		# Check if user's pick is > 0
		# and less or equal to the length of options array
		if [[ $user_pick -gt 0 && $user_pick -le "${#options[@]}" ]]; then
			export "$result_variable_name"="${options[$((user_pick - 1))]}"
		else
			# Terminate the installation if too many failed attempts
			if [ "$attempt" -le "$max_tries" ]; then
				print error "Eh? This is pointless. Bye."
				exit 1
			else
				attempt=$((attempt + 1))
				print error "This option is not available! Lets try again (Attempt $((attempt + 1)) of $max_tries)"
			fi
		fi
	done
}

# --------------------------------------------------------------------------- #
#                                              Install the desired program(s)
# --------------------------------------------------------------------------- #
function install_program {
	local program=$1

	# Confirm if the user wants to install
	print question "Do you want to install \"$program\" with \`$package_manager\` package manager?"
	if confirm; then
		print info "Installing \"$program\" with \`$package_manager\`..."

		if [[ $package_manager == "apt" ]]; then
			command sudo apt install "$program"
		elif [[ $package_manager == "pacman" ]]; then
			command sudo pacman -S "$program"
		fi

		print success "Installed \"$program\" with \`$package_manager\`."
	else
		print error "The installation can't be continued without these program(s)!"
		exit 1
	fi
}

# --------------------------------------------------------------------------- #
#                              Install a specific program if it doesn't exist
# --------------------------------------------------------------------------- #
function install_program_if_doesnt_exist {
	local program=$1

	# Verify if the program doesn't exist in the system
	if ! [ -x "$(command -v "$program")" ]; then
		print warning "The program \`$program\` is not installed in this system."

		# Rename the programs, because their names is not be same
		# as the command in the package manager's mirror(s)
		if [ "$program" == "nvim" ]; then
			program="neovim"
		fi

		# Install programs
		print question "Do you want to install \"$program\" with \`$package_manager\` package manager? (Yes/No)"
		install_program "$program"
	else
		print note "The program \`$program\` already exists in this system."
	fi
}

# --------------------------------------------------------------------------- #
#     Create symbolic link to a specific configuration file from the dotfiles
# --------------------------------------------------------------------------- #
function create_symlink {
	local config_file_path=${config_files[$1]}
	# shellcheck disable=SC2155
	local file_name=$(command basename "$config_file_path")

	# Check if the file already exists
	if [ -e "$file_name" ]; then
		print error "The Git's configuration \"$file_name\" already exists in your home directory!"
		printf "%sTo avoid problems, please backup your existing configurations and run this installation file again.%s\n" \
			"$(format fg red)" "$(format reset)" | fold --spaces
		exit 1
	else
		print info "Creating a symbolic link for \"$file_name\" from the dotfiles in your home directory..."

		command ln --symbolic "$HOME/$dotfiles_dir_name/$config_file_path" "$HOME/$file_name"
		print success "Created a symbolic link for \"$file_name\" file."
	fi
}

# --------------------------------------------------------------------------- #
#                               Print the short output of the program version
# --------------------------------------------------------------------------- #
function print_version {
	local program=$1

	print note "\`$program\` version: $($program --version | head --lines 1)"
}

# --------------------------------------------------------------------------- #
#                      Change the environment variables for the default shell
# --------------------------------------------------------------------------- #
function change_env_variable {
	local variable_name=$1
	local variable_value=$2

	# Path to the default shell's configuration file
	local shell_config_file_path="$HOME/$dotfiles_dir_name/${config_files[$default_shell]}"

	printf -- "$(format u)-> \$%s\n$(format reset)" "$variable_name"

	# Check if specified environment variable was already defined (exported)
	if command grep --quiet "$variable_name" "$shell_config_file_path"; then
		# Replace the value

		print note "The environment variable \"$variable_name\" exists in: \"$shell_config_file_path\"."

		# Escape the `/` characters if they exists for the `sed` substituting
		local fixed_value=${variable_value//\//\\/}

		local pattern="$variable_name=.*"
		local substitution="$variable_name=\"$fixed_value\""

		print info "Replacing the value of environment variable \"$variable_name\" to \"$variable_value\"..."
		sed --in-place "s/${pattern}/${substitution}/" "$shell_config_file_path"
		print success "Replaced the value of this environment variable."
	else
		# Append to the configuration file

		print warning "The environment variable \"$variable_name\" doesn't exist in: \"$shell_config_file_path\"."

		print info "Adding the environment variable \"$variable_name\" to the file: \"$shell_config_file_path\"..."

		# Check if comment was added as argument
		if [ -n "$3" ]; then
			local comment=$3

			echo "# $comment" >> "$shell_config_file_path"
		fi
		echo "export $variable_name=\"$variable_value\"" >> "$shell_config_file_path"

		print success "Added the environment variable to shell's configuration file."
	fi
}

# =========================================================================== #
# Runtime
# =========================================================================== #

print info "Starting the installation..."

# --------------------------------------------------------------------------- #
#                         Get the name of currently used Linux's distribution
# --------------------------------------------------------------------------- #
print part "Linux's distribution name"

print info "Determining the name of currently used Linux's distribution..."

distro_name=$( \
	cat /etc/*-release \
	| grep --only-matching --perl-regexp '(?<=^NAME=\").*(?=\")' \
)

print note "You are on \"$distro_name\" Linux's distribution."

# --------------------------------------------------------------------------- #
#                                       Determine the package manager program
# --------------------------------------------------------------------------- #
print part "Package manager program"

print info "Determining the package manager program..."

if [[ $distro_name == "Arch Linux" ]]; then
	package_manager="pacman"
elif [[ $distro_name =~ "Debian" || $distro_name =~ "Ubuntu" ]]; then
	package_manager="apt"
else
	print error "Sorry, the currently used distribution \"$distro_name\" is not supported!"
	exit 1
fi

print note "This installation will use \`$package_manager\` package manager."

# --------------------------------------------------------------------------- #
#                                 Move to the user's home directory (`$HOME`)
# --------------------------------------------------------------------------- #
print part "Current working directory"

print info "Checking current working directory..."

if [[ $PWD == "$HOME" ]]; then
	print note "You are already in \$HOME=\"$PWD\" directory."
else
	cd "$HOME"
	print note "Changed working directory to \$HOME=\"$PWD\"."
fi

# --------------------------------------------------------------------------- #
#                                          Check if required programs exists,
#                                        and if not, install the missing ones
# --------------------------------------------------------------------------- #
print part "Required programs"

required_programs=(git which)

print info "Checking if required programs are installed..."

# Determine a list of missing programs
missing_programs=""
for program in ${required_programs[*]}; do
	if ! [ -x "$(command -v "$program")" ]; then
		if [ -z "$missing_programs" ]; then
			# First one without a space at the beginning
			missing_programs+="${program}"
		else
			# Any next one with a space at the beginning to separate them
			missing_programs+=" ${program}"
		fi
	fi
done

# Check if there are missing programs and install them
if [ -n "$missing_programs" ]; then
	print warning "The following programs required for this installation are missing: \"$missing_programs\"."
	install_program "$missing_programs"
else
	print note "Required programs are already installed."
fi

# --------------------------------------------------------------------------- #
#                                   Clone dotfiles from the remote repository
# --------------------------------------------------------------------------- #
print part "Cloning dotfiles"

# Check if dotfiles directory already exists...
if [ -d "$dotfiles_dir_name" ]; then
	print error "The directory \"$dotfiles_dir_name\" already exists in your \$HOME directory!\n"
	printf "%sTo avoid problems, please backup your existing dotfiles and configurations, then run this installation file again.%s" \
		"$(format fg red)" "$(format reset)" | fold --spaces
	exit 1
else
	print note "The dotfiles remote repository URL is: \"$dotfiles_remote_repository\"."

	command git clone $dotfiles_remote_repository
	print success "Successfully cloned the dotfiles from the remote repository."
fi

# --------------------------------------------------------------------------- #
#                             Create a symbolic link to the Git configuration
# --------------------------------------------------------------------------- #
print part "Git's configuration file"

create_symlink "git"


# --------------------------------------------------------------------------- #
#                                  Determine which shell to be set as default
# --------------------------------------------------------------------------- #
print part "Default shell"

# shellcheck disable=SC2034
shell_options=("zsh" "bash")

print question "Which shell do you want to use as a default one?"
pick_option shell_options "default_shell"

# Install the shell if it doesn't exist in the system
install_program_if_doesnt_exist "${default_shell:?}"

# Set the default shell to be run on start
if [[ $(basename "$SHELL") == "$default_shell" ]]; then
	print note "\`$default_shell\` is already set as a default shell."
else
	print note "This program path \"$(which "$default_shell")\" will be set as your default shell."

	command sudo usermod --shell "$(which "$default_shell")" "$(whoami)"
	print success "Set \"$default_shell\" as your default shell."
fi

# Print the default shell's version
print_version "$default_shell"

# --------------------------------------------------------------------------- #
#              Create symbolic link to the default shell's configuration file
# --------------------------------------------------------------------------- #
print part "Shell's configuration file"

create_symlink "$default_shell"

# --------------------------------------------------------------------------- #
#                                     Determine the default editor to install
# --------------------------------------------------------------------------- #
print part "Default editor"

# shellcheck disable=SC2034
editor_options=("nvim" "vim")

print question "Which editor do you want to set as a default one?"
pick_option editor_options "default_editor"

# Install the default editor if it doesn't exist in the system
install_program_if_doesnt_exist "${default_editor:?}"

# Print the default editor's version
print_version "$default_editor"

# --------------------------------------------------------------------------- #
#                                   Determine the user's mode for this system
# --------------------------------------------------------------------------- #
print part "User mode"

# shellcheck disable=SC2034
mode_options=("developer" "administrator")

print question "Which user's mode do you want to set for this system?"
pick_option mode_options "user_mode"

# --------------------------------------------------------------------------- #
#                    Determine if the user want to build program from sources
# --------------------------------------------------------------------------- #
print part "Build from source"

print question "Do you want to build the tools programs from their source?"
print warning "They will take a while to build and the latest versions could be not stable!"
if confirm; then
	build_from_source=true
else
	build_from_source=false
fi

# --------------------------------------------------------------------------- #
#                             Configure default shell's environment variables
# --------------------------------------------------------------------------- #
print part "Environment variables"

print info "Setting up the environment variables for the default shell \`$default_shell\` configuration file..."

change_env_variable "DOTFILES" "\$HOME/$dotfiles_dir_name" "Path to user's \"dotfiles\" directory"
change_env_variable "MODE" "${user_mode:?}" "User's mode for this system"
change_env_variable "BUILD_FROM_SOURCE" "${build_from_source:?}" "Build tools/programs from their source"

print success "Finished setting up environment variables."

# --------------------------------------------------------------------------- #
#                   Finish the installation by starting the set default shell
# --------------------------------------------------------------------------- #
print part "Finish"

print info "Executing default shell and loading its configuration..."
exec "$default_shell"

