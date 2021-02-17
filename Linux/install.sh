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

# List of configuration files for programs to be used/installedl
declare -A config_files=(
	["git"]="Git/.gitconfig"
	["bash"]="Linux/Bash/.bash_profile"
	["zsh"]="Linux/Zsh/.zshenv"
)

# List supported distributions with their package managers to use
declare -A package_managers=(
	["Arch Linux"]="pacman"
	["Debian"]="apt"
	["Ubuntu"]="apt"
)

required_programs=( "git" "which" )

declare new_hostname
declare old_username
declare new_username

# shellcheck disable=SC2034
shell_options=( "zsh" "bash" )

# shellcheck disable=SC2034
editor_options=( "nvim" "vim" )

# shellcheck disable=SC2034
mode_options=( "developer" "administrator" )

# List of environment variables to be edited
# and their values to be determined
declare -A environment_variables=()
# 	["DOTFILES"]="\$HOME/$dotfiles_dir_name"
# 	["EDITOR"]="$default_editor"
# 	["USER_MODE"]="$user_mode"
# 	["BUILD_FROM_SOURCE"]="$build_from_source"
# )

# =========================================================================== #
# Helpers
# =========================================================================== #

# Get the basename of dotfiles directory
function get_dotfiles_basename {
	local dotfiles_dir_name

	dotfiles_dir_name="$( \
		command basename "$dotfiles_remote_repository" \
		| command grep --only-matching --perl-regexp '.*(?=\.git)' \
	)"

	environment_variables["DOTFILES"]="$HOME/$dotfiles_dir_name"
}
get_dotfiles_basename

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
	[error]="   ERROR"
	[warning]=" WARNING"
	[success]=" SUCCESS"
	[info]="    INFO"
	[note]="    NOTE"
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
		else
			printf "Specified output type is not recognized!"
			return 1
		fi
	else
		printf "No type was passed as a argument!"
	fi

	# Check if a message was passed as argument
	if [ -z "$2" ]; then
		printf "No message was given as a argument!"
	fi

	local -a messages=()
	local arguments=( "$@" )

	# Loop from the second argument
	for (( index=1; index < "$#"; index++ )); do
		messages+=( "${arguments[$index]}" )
	done

	# Return formatted output and fold it by spaces if is too long
	fold --spaces --width 100 <<< "$( \
		format bg "${formats[$type]}"; \
		printf "%s:" "${prefixes[$type]}"; \
		format reset; \
		format fg "${formats[$type]}"; \
		printf " %s" "${messages[@]}"; \
		format reset; \
	)"
}

# --------------------------------------------------------------------------- #
#                                                        Confirm the decision
# --------------------------------------------------------------------------- #
function confirm {
	local valid_output="false"
	local attempt=1
	local max_tries=5

	while [[ "$valid_output" == "false" ]]; do
		format fg cyan
		printf "%s\n" "(Y)yes / (N)no"
		format reset
		read -r -p "User's decision: " decision

		case "$decision" in
			[yY][eE][sS]|[yY])
				valid_output="true"
				return 0
				;;

			[nN][oO]|[nN])
				valid_output="true"
				return 1
				;;

			*)
				limit_attempts
				;;
		esac
	done
}

# --------------------------------------------------------------------------- #
#                            Pick an option from the provided list of options
# --------------------------------------------------------------------------- #
function pick_option () {
	local result_variable_name=$1
	local -n options=$2
	local user_pick=0

	function print_available_options {
		format fg cyan
		printf -- "---\n%s\n" \
			"Available options: (pick the number from the list below)"
		for index in "${!options[@]}"; do
			printf "(%d) %s\n" "$((index + 1))" "${options[$index]}"
		done
		format reset
	}

	function is_option_available {
		# Check if user's pick is > 0
		# and less or equal to the length of options array
		if [[ $user_pick -gt 0 && $user_pick -le "${#options[@]}" ]]; then
			return 0
		else
			return 1
		fi
	}

	local max_tries=5
	local attempt=1

	while ! is_option_available; do
		print_available_options
		read -r -p "$result_variable_name: " user_pick

		if is_option_available; then
			# list starts from 0,
		    # so the number of user pick has to be deducted by 1
			export "$result_variable_name"="${options[$((user_pick - 1))]}"
		else
			limit_attempts
		fi
	done
}

# --------------------------------------------------------------------------- #
#                    Limit attempts for the user input to prevent endlessness
# --------------------------------------------------------------------------- #
function limit_attempts {
	attempt=$((attempt + 1))

	if [ "$attempt" -le "$max_tries" ]; then
		print error "Invalid output!"
		format fg red
		printf "%s (Attempt %d of %d)\n" \
			"Lets try again" \
			"$attempt" \
			"$max_tries"
		format reset
	else
		print error "Too many failed attempts!"
		terminate
	fi
}

# --------------------------------------------------------------------------- #
#                                        Check if the program(s) is installed
# --------------------------------------------------------------------------- #
function is_installed {
	local program_name=$1

	if [ -x "$(command -v "$program_name")" ]; then
		return 0
	else
		return 1
	fi
}

# --------------------------------------------------------------------------- #
#                                                      Install the program(s)
# --------------------------------------------------------------------------- #
function install_program {
	local program_name=$1

	if is_installed "$program_name"; then
		print note "The program \"$program_name\" is already installed."
		return 0
	fi

	print question "Do you want to install program \"$program_name\" with \`$package_manager\` package manager?"

	if confirm; then
		print info "Executing \`$package_manager\` command to install \"$program_name\"..."

		# Debian & Ubuntu
		if [[ $package_manager == "apt" ]]; then
			command sudo apt install "$program_name"
		# Arch Linux
		elif [[ $package_manager == "pacman" ]]; then
			command sudo pacman -S "$program_name"
		fi

		print note "Installed \"$program_name\" with \`$package_manager\`."
		return 0
	else
		print note "Skipped installing \"$program_name\"."
		return 1
	fi
}

# --------------------------------------------------------------------------- #
#                                Check if given path or directory name exists
# --------------------------------------------------------------------------- #
function directory_exists {
	local dir_path=$1

	if [ -d "$dir_path" ]; then
		return 0
	else
		return 1
	fi
}

# --------------------------------------------------------------------------- #
#                                     Check if given path or file name exists
# --------------------------------------------------------------------------- #
function file_exists {
	local file_path=$1

	if [ -e "$file_path" ]; then
		return 0
	else
		return 1
	fi
}

# --------------------------------------------------------------------------- #
#     Check if given symbolic link file to specific configuration file exists
# --------------------------------------------------------------------------- #
function link_exists {
	local link_path=$1

	if [ -L "$link_path" ]; then
		return 0
	else
		return 1
	fi
}

# --------------------------------------------------------------------------- #
#     Create symbolic link to a specific configuration file from the dotfiles
# --------------------------------------------------------------------------- #
function create_symlink {
	local program_name=$1
	local dotfiles_path="${environment_variables[DOTFILES]}"
	local config_file_path=${config_files["$program_name"]}
	local file_name
	file_name=$(command basename "$config_file_path")

	print info "Creating a symbolic link for \"$file_name\" from the dotfiles in your home directory..."
	command ln --symbolic "$dotfiles_path/$config_file_path" "$file_name"

	if ! link_exists "$file_name"; then
		print error "Something went wrong with creating a symbolic for the \"$program_name\" configuration file!"
		terminate
	else
		print note "Created a symbolic link for \"$file_name\" file."
	fi
}

# --------------------------------------------------------------------------- #
#                               Print the short output of the program version
# --------------------------------------------------------------------------- #
function print_version {
	local program=$1
	local program_version_info
	program_version_info=$(command "$program" --version | head --lines 1)

	print info "Printing \`$program\` version information..."
	print note "$program_version_info"
}

# --------------------------------------------------------------------------- #
#                                   Wrappers for printing the readable output
#                                    for a specified part of the installation
# --------------------------------------------------------------------------- #
function start_installation_part {
	local part_title=$1

	printf -- "\n--------- [ %s ] \n" "$part_title"

	if [ -n "${2-}" ]; then
		local info_message=$2

		print info "$info_message..."
	fi
}

function end_installation_part {
	if [ -n "${1-}" ]; then
		local success_message=$1

		print success "$success_message"
	else
		print success "Done."
	fi

	printf -- "---------\n"
	return 0
}

# --------------------------------------------------------------------------- #
#                                    Wrapper for terminating the installation
# --------------------------------------------------------------------------- #
function terminate {
	printf -- "---------\n"
	format fg red
	printf "\n%s\n" "Installation terminated."
	format reset
	exit 1
}

# =========================================================================== #
# Function wrappers for the main features
# =========================================================================== #

# --------------------------------------------------------------------------- #
#                         Get the name of currently used Linux's distribution
#                                                 and check if it's supported
# --------------------------------------------------------------------------- #
function check_if_distribution_is_supported {
	start_installation_part \
		"Linux's distribution" \
		"Determining if the current Linux's distribution is supported"

	function get_distribution_name {
		command cat /etc/*-release \
		| command grep --only-matching --perl-regexp '(?<=^NAME=\").*(?=\")'
	}

	distribution_name=$(get_distribution_name)
	print note "You are on \"$distribution_name\" Linux's distribution."

	function is_distribution_supported {
		for supported_distribution in "${!package_managers[@]}"; do
			if [[ $distribution_name =~ $supported_distribution ]]; then
				distribution_name="$supported_distribution"
				return 0
			fi
		done

		return 1
	}

	if ! is_distribution_supported; then
		print error "Sorry, this distribution is not supported!"
		terminate
	else
		end_installation_part "This distribution is supported."
	fi
}

# --------------------------------------------------------------------------- #
#                                       Determine the package manager program
# --------------------------------------------------------------------------- #
function determine_package_manager {
	start_installation_part \
		"Package manager program" \
		"Determining the package manager program"

	for key in "${!package_managers[@]}"; do
		if [ "$distribution_name" == "$key" ]; then
			package_manager="${package_managers["$key"]}"
			break
		fi
	done

	if [ -z "$package_manager" ]; then
		print error "Something went wrong with determining the package manager!"
		terminate
	else
		print note "This installation will use the \`$package_manager\` package manager."
		end_installation_part "The package manager is determined."
	fi
}

# --------------------------------------------------------------------------- #
#                                          Check if required programs exists,
#                                        and if not, install the missing ones
# --------------------------------------------------------------------------- #
function check_required_programs {
	start_installation_part \
		"Required programs" \
		"Checking if the required programs are installed"

	# Determine a list of missing programs
	local missing_programs=()

	for program_name in ${required_programs[*]}; do
		if ! is_installed "$program_name"; then
			missing_programs+=( "$program_name" )
		else
			print note "The program \"$program_name\" is already installed."
		fi
	done

	if  ! [ ${#missing_programs[*]} -eq 0 ]; then
		print warning "These following missing programs are required for this installation to continue:"
		format fg yellow
		printf -- "- %s\n" "${missing_programs[@]}"
		format reset
	fi

	for program_name in "${missing_programs[@]}"; do
		install_program "$program_name"

		if ! is_installed "$program_name"; then
			print error "This installation can't be continued without the required programs!"
			terminate
		fi
	done

	end_installation_part "The required programs are installed."
}

# --------------------------------------------------------------------------- #
#                               switch to the user's home directory (`$HOME`)
# --------------------------------------------------------------------------- #
function go_to_home_directory {
	start_installation_part \
		"current working directory" \
		"checking current working directory"

	if [[ $PWD == "$HOME" ]]; then
		print note "you are already in \$home=\"$PWD\" directory."
	else
		cd "$HOME"
		print note "changed working directory to \$home=\"$HOME\"."
	fi

	end_installation_part "checking completed."
}

# --------------------------------------------------------------------------- #
#                                                         Change the hostname
# --------------------------------------------------------------------------- #
function change_hostname {
	start_installation_part \
		"Device hostname" \
		"Changing the device's hostname"

	print question "Do you want to set this device's \"\$HOSTNAME\"?"

	if confirm; then
		print question "What is going to be a new name of this device?"
		read -r -p "Hostname: " new_hostname

		command sudo hostnamectl set-hostname "$new_hostname"

		print note "Changed device's \$HOSTNAME from \"$HOSTNAME\" to \"$new_hostname\"."
		print note "The change will take an effect after restarting the device."

		end_installation_part "Device's \$HOSTNAME configured."
	else
		print warning "Skipped configuring device's \$HOSTNAME."
		printf -- "---------\n"
	fi
}

# --------------------------------------------------------------------------- #
#                                                            Add the new user
# --------------------------------------------------------------------------- #
function add_new_user {
	start_installation_part \
		"New user" \
		"Attempting to add the new user"

	print question "Do you want to add the new user to this device's system?"

	old_username="$(whoami)"

	if confirm; then
		print question "What is going to be a name of this new user?"
		read -r -p "User: " new_username

		command sudo adduser "$new_username"

		print note "Added the new user \"$new_username\"."

		print question "Do you want this user to be able to perform administrative tasks (add to sudo group)?"

		if confirm; then
			command sudo usermod --append --groups "sudo" "$new_username"
		else
			print warning "This new user is not going to be able to able to perform administrative tasks!"
			printf -- "---------\n"
		fi

		print info "Moving to the new user's home directory..."

		command cd "/home/$new_username"

		print note "Changed directory to \"/home/\$new_username\"."

		end_installation_part "Finished adding new user."
	else
		print note "Skipped adding new user."
		printf -- "---------\n"
	fi
}

# --------------------------------------------------------------------------- #
#                                                     Delete the default user
# --------------------------------------------------------------------------- #
function delete_default_user {
	start_installation_part \
		"Delete the default user" \
		"Attempting to remove the default user"

	print question "Do you want to remove the default user \"$old_username\"?"

	if confirm; then
		print question "Do you want to keep the files from old user in the directory: \"/home/$old_username\"?"

		if confirm; then
			command sudo deluser "$old_username"
			print warning "The default user's files still exists in: \"/home/$old_username\"."
		else
			command sudo deluser "$old_username" --remove-home
		fi

		print note "Deleted the default user \"$old_username\"."

		end_installation_part "Finished removing the default user."
	else
		print note "Skipped removing the default user."
		printf -- "---------\n"
	fi
}

# --------------------------------------------------------------------------- #
#                                                        Disable root account
# --------------------------------------------------------------------------- #
function disable_root_account {
	start_installation_part \
		"Disable root" \
		"Attempting to disable root account"

	print question "Do you want to disable the root account?"

	if confirm; then
		command sudo -s passwd --lock "root"

		print note "Disabled the root account, from now no one can login as \"root\"."

		end_installation_part "Finished disabling root account."
	else
		print warning "The \"root\" account is still enabled, this could be a potential security risk!"
		printf -- "---------\n"
	fi
}

# --------------------------------------------------------------------------- #
#                          Checking if dotfiles and other configuration files
#                                            already exists in home directory
# --------------------------------------------------------------------------- #
function check_for_existing_files {
	start_installation_part \
		"Checking dotfiles & configs" \
		"Checking for existing dotfiles or configuration files in home directory"

	local existing_config_files=()

	for config_file_path in "${config_files[@]}"; do
		local file_name
		file_name=$(command basename "$config_file_path")

		if file_exists "$file_name"; then
			existing_config_files+=( "$file_name" )
		fi
	done

	local dotfiles_path="${environment_variables[DOTFILES]}"

	if directory_exists "$dotfiles_path" || (( ${#existing_config_files[@]} )); then
		if directory_exists "$dotfiles_path"; then
			print error "The dotfiles directory \"$dotfiles_dir_name\" exists in home directory!"
		fi

		if (( ${#existing_config_files[@]} )); then
			print error "These following configuration files exists in home directory!"
			format fg red
			printf -- "- \"%s\"\n" "${existing_config_files[@]}"
			format reset
		fi

		format fg red
		fold --spaces --width 80 <<< "$(printf "\n%s\n" \
			"To avoid problems, please backup your existing dotfiles and configurations, then run this installation file again." \
		)"
		format reset

		terminate
	else
		end_installation_part "There are no existing dotfiles or configuration files."
	fi
}

# --------------------------------------------------------------------------- #
#                                   Clone dotfiles from the remote repository
# --------------------------------------------------------------------------- #
function clone_dotfiles {
	start_installation_part \
		"Cloning dotfiles" \
		"Using \`git\` to clone the dotfiles from the remote repository"

	print note "The dotfiles remote repository URL is: \"$dotfiles_remote_repository\"."

	command git clone $dotfiles_remote_repository

	local dotfiles_dir_name="${environment_variables[DOTFILES]}"

	if ! directory_exists "$dotfiles_dir_name"; then
		print error "Something went wrong with cloning the dotfiles!"
		terminate
	else
		end_installation_part "Successfully cloned the dotfiles from the remote repository."
	fi
}

# --------------------------------------------------------------------------- #
#                             Create a symbolic link to the Git configuration
# --------------------------------------------------------------------------- #
function link_git_configuration {
	start_installation_part \
		"Git's configuration file"

	create_symlink "git"

	end_installation_part "Git's configuration file is ready."
}

# --------------------------------------------------------------------------- #
#                                      Configure the default shell to be used
# --------------------------------------------------------------------------- #
function configure_default_shell {
	start_installation_part \
		"Default shell" \
		"Configuring the default shell"

	local default_shell
	print question "Which shell do you want to use as the default one?"
	pick_option "default_shell" "shell_options"

	environment_variables["SHELL"]="$default_shell"

	function get_current_default_shell {
		# shellcheck disable=SC2016
		command basename "$( \
			command awk \
				--field-separator : \
				-v user="$USER" '$1 == user {print $NF}' \
				/etc/passwd \
			)"
	}

	function set_default_shell {
		if [ "$(get_current_default_shell)" != "$default_shell" ]; then
			local shell_executable_file_path
			shell_executable_file_path=$(command which "$default_shell")

			print note "This program executable file path \"$shell_executable_file_path\" will be set as your default shell."

			command sudo usermod --shell \
				"$shell_executable_file_path" \
				"$USER"
		else
			print note "This shell is already set as the default one."
		fi
	}

	local skipped_installation="false"

	print info "Checking if this default shell is installed..."

	if ! is_installed "$default_shell"; then
		print warning "This default shell is not installed."
		if ! install_program "$default_shell"; then
			skipped_installation="true"
		fi
	else
		print note "The default shell is installed."
		print_version "$default_shell"

		print info "Configuring this default shell to be run at login..."
		set_default_shell
	fi

	if [ "$skipped_installation" == "true" ]; then
		print warning "You refused to install this default shell!"
		format fg yellow
		printf -- "---\n"
		printf "%s\n" \
			"This is not mandatory for this installation." \
			"You can install it later by yourself," \
			"but the installation will not configure" \
			"the default shell to be run at login."
		format reset
		printf -- "---------\n"
	else
		end_installation_part "Finished default shell configuration."
	fi
}

# --------------------------------------------------------------------------- #
#              Create symbolic link to the default shell's configuration file
# --------------------------------------------------------------------------- #
function link_default_shell_configuration {
	start_installation_part \
		"Shell's configuration file"

	create_symlink "${environment_variables[SHELL]}"

	end_installation_part "Default shell's configuration file is ready."
}

# --------------------------------------------------------------------------- #
#                                     Determine the default editor to install
# --------------------------------------------------------------------------- #
function configure_default_editor {
	start_installation_part \
		"Default editor" \
		"Configure the default editor"

	local default_editor
	print question "Which text editor do you want to set as the default one?"
	pick_option "default_editor" "editor_options"

	environment_variables["EDITOR"]="$default_editor"

	local skipped_installation="false"

	print info "Checking if \"$default_editor\" is installed..."

	if ! is_installed "$default_editor"; then
		print warning "This default editor \"$default_editor\" is not installed!"
		if ! install_program "$default_editor"; then
			skipped_installation="true"
		fi
	else
		print note "This default program is already installed."
		print_version "$default_editor"
	fi

	if [[ "$skipped_installation" == "true" ]]; then
		print warning "You refused to install this default shell!"
		format fg yellow
		printf -- "---\n"
		printf "%s\n" \
			"This is not mandatory for this installation." \
			"You can install it later by yourself."
		format reset
		printf -- "---------\n"
	else
		end_installation_part "Finished configuring the default text editor."
	fi
}

# --------------------------------------------------------------------------- #
#                                     Determine the user mode for this system
# --------------------------------------------------------------------------- #
function set_user_mode {
	start_installation_part \
		"User mode" \
		"Determining the user mode for this system"

	local user_mode
	print question "Which user mode do you want to set for this system?"
	pick_option "user_mode" "mode_options"

	environment_variables["USER_MODE"]="$user_mode"

	end_installation_part "User mode determined."
}

# --------------------------------------------------------------------------- #
#                    Determine if the user want to build program from sources
# --------------------------------------------------------------------------- #
function determine_if_build_from_source {
	start_installation_part \
		"Build from source" \
		"Determine if programs should be built from their source"

	local build_from_source
	print warning "They will take a while to build and the latest versions could be not stable!"
	print question "Do you want to build the tools programs from their source?"

	if confirm; then
		build_from_source=true
	else
		build_from_source=false
	fi

	environment_variables["BUILD_FROM_SOURCE"]="$build_from_source"

	end_installation_part "Decision about building programs from their source is done."
}

# --------------------------------------------------------------------------- #
#                             Configure default shell's environment variables
# --------------------------------------------------------------------------- #
function configure_environment_variables {
	start_installation_part \
		"Environment variables" \
		"Setting up the environment variables in the default shell \`$default_shell\` configuration file"

	local dotfiles_path="${environment_variables[DOTFILES]}"
	# Path to the default shell's configuration file
	local shell_config_file_path="$dotfiles_path/${config_files[$default_shell]}"
	print note "The path of \`$default_shell\` configuration file is: \"$shell_config_file_path\"."

	function replace_env_variable {
		local variable_name=$1
		local variable_value=$2

		print warning "This environment variable already existed in the file!"

		# Escape the `/` characters if they exists for the `sed` substituting
		local fixed_value=${variable_value//\//\\/}

		local pattern="$variable_name=.*"
		local substitution="$variable_name=\"$fixed_value\""

		print info "Replacing the value in the file..."
		command sed --in-place "s/${pattern}/${substitution}/" \
			"$shell_config_file_path"
		print note "Replaced the value to \"$variable_value\"."
	}

	function append_env_variable {
		local variable_name=$1
		local variable_value=$2

		print info "Adding the environment variable to the file..."

		echo "export $variable_name=\"$variable_value\"" >> "$shell_config_file_path"

		print note "Added the environment variable to shell's configuration file."
	}

	function change_env_variable {
		local variable_name=$1
		local variable_value=$2

		printf -- "--------> $(format u)\$%s$(format reset)\n" "$variable_name"

		# Check if specified environment variable was already defined (exported)
		if command grep --quiet "$variable_name" "$shell_config_file_path"; then
			replace_env_variable "$variable_name" "$variable_value"
		else
			append_env_variable "$variable_name" "$variable_value"
		fi
	}

	for key in "${!environment_variables[@]}"; do
		change_env_variable "$key" "${environment_variables[$key]}"
	done

	end_installation_part "Finished setting up environment variables."
}

# =========================================================================== #
# Main runtime
# =========================================================================== #
function main {
	print info "Starting the installation..."

	# Start the installation parts
	check_if_distribution_is_supported
	determine_package_manager
	check_required_programs
	go_to_home_directory
	change_hostname
	add_new_user
	# delete_default_user
	disable_root_account
	check_for_existing_files
	clone_dotfiles
	link_git_configuration
	configure_default_shell
	link_default_shell_configuration
	configure_default_editor
	set_user_mode
	determine_if_build_from_source
	configure_environment_variables

	# Finish the installation by starting the set default shell if user wants to
	print success "Installation finished!"
	print question "Do you want to start the default shell now?"
	if confirm; then
		print info "Executing default shell and loading its configuration..."
		exec "$default_shell"
	else
		exit 0
	fi
}

main
