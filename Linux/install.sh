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
	["bash"]="Shells/Bash/.bash_profile"
	["zsh"]="Shells/Zsh/.zshenv"
	["editorconfig"]="Editors/.editorconfig"
	["neovim"]="Editors/Neovim/init.lua"
)

declare package_manager
# List supported distributions with their package managers to use
declare -A package_managers=(
	["Arch Linux"]="pacman"
	["Manjaro Linux"]="pacman"
	["Debian"]="apt"
	["Ubuntu"]="apt"
)

required_packages=("git" "which" "gcc" "cmake")

declare user_mode
user_mode_options=("developer" "administrator")

# declare new_hostname
# declare old_username
# declare new_username

declare default_shell
shell_options=("zsh" "bash" "ksh")

declare default_editor
editor_options=("neovim" "vim")

# List of environment variables to be determined
declare -A environment_variables=()

# =========================================================================== #
# Helpers
# =========================================================================== #

# Get the basename of dotfiles directory
function get_dotfiles_baseName() {
	local dotfiles_dir_name

	dotfiles_dirName="$(
		command basename "$dotfiles_remote_repository" \
			| command grep --only-matching --perl-regexp '.*(?=\.git)'
	)"

	environment_variables["DOTFILES"]="$HOME/$dotfiles_dirName"
}
get_dotfiles_baseName

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
# Formatting the output (with `tput`)
# --------------------------------------------------------------------------- #
# Available effect options:
# * fg {color}   - set foreground color
# * bg {color}   - set background color
# * (/)underline - (un)set underline
# * (/)bold      - (un)set underline
# * reset        - clear formatting
function format() {
	# Verify if any format option was given
	if [ -n "$1" ]; then
		local effect=$1
	else
		printf "Formatting effect not specified!"
		exit 1
	fi

	# Determine format based on the option
	if [[ $effect == reset ]]; then
		command tput sgr0
	elif [[ $effect == "underline" ]]; then
		command tput smul
	elif [[ $effect == "/underline" ]]; then
		command tput rmul
	elif [[ $effect == "bold" ]]; then
		command tput smso
	elif [[ $effect == "/bold" ]]; then
		command tput rmso
	elif [[ $effect == "bg" || $effect == "fg" ]]; then
		#  Check if color was given as second argument
		if [ -n "$2" ]; then
			# Verify if color name exists
			if [[ -v colors[$2] ]]; then
				local color=${colors[$2]}
			else
				printf "Specifed color is not recognized!"
				exit 1
			fi
		else
			printf "No color name was given as argument!"
			exit 1
		fi

		# Return desired formatting
		if [[ $effect == bg ]]; then
			command tput setab "$color"
		elif [[ $effect == fg ]]; then
			command tput setaf "$color"
		fi
	else
		printf "Unknown format option was given!"
		exit 1
	fi
}

# --------------------------------------------------------------------------- #
#  Override the command `print`
#  with a function to print a specified type of output
# --------------------------------------------------------------------------- #
function print() {
	# Check if any type was passed as argument
	if [ -n "$1" ]; then
		# Verify if the given type exists
		if [[ -v prefixes[$1] ]]; then
			local type=$1
		else
			printf "Specified output type is not recognized!"
			exit 1
		fi
	else
		printf "No type was passed as a argument!"
	fi

	# Check if a message was passed as argument
	if [ -z "$2" ]; then
		printf "No message was passed as a argument!"
		exit 1
	fi

	local arguments=("$@")

	# Loop from the second argument
	local -a messages=()
	for ((index = 1; index < "$#"; index++)); do
		messages+=("${arguments[$index]}")
	done

	# Return formatted output and fold it by spaces if is too long
	fold --spaces --width 100 <<< "$(
		printf "$(format bg "${formats[$type]}")%s:$(format reset)" \
			"${prefixes[$type]}"
		printf "$(format fg "${formats[$type]}") %s$(format reset)" \
			"${messages[@]}"
	)"
}

# --------------------------------------------------------------------------- #
#                                                        Confirm the decision
# --------------------------------------------------------------------------- #
function confirm() {
	local valid_output=false
	local attempt=1
	local max_tries=5

	while [[ $valid_output == false ]]; do
		format fg cyan
		printf -- "---\n$(format underline)%s$(format /underline)\n" \
			"Possible decisions:"
		printf "%s\n" \
			"$(format bold)(Y)$(format /bold)yes / $(format bold)(N)$(format /bold)no"
		format reset
		read -r -p "Decision: " decision

		case "$decision" in
			[yY][eE][sS] | [yY])
				valid_output="true"
				return 0
				;;

			[nN][oO] | [nN])
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
function pick_option() {
	local options=("$@")


	function print_options() {
		format fg cyan
		printf -- "---\n%s\n" \
			"$(format underline)Available options$(format /underline): (pick the number from the list below)"
		for index in "${!options[@]}"; do
			printf "$(format bold)(%d)$(format /bold) %s\n" \
				"$((index + 1))" \
				"${options[$index]}"
		done
		format reset
	}

	local user_pick=0
	function is_available() {
		# Check if user's pick is > 0
		# and less or equal to the length of options array
		if [[ $user_pick -gt 0 && $user_pick -le ${#options[@]} ]]; then
			return 0
		else
			return 1
		fi
	}

	local max_tries=5
	local attempt=1
	while ! is_available; do
		print_options
		read -r -p "Option: " user_pick

		if is_available; then
			# list starts from 0,
			# so the number of user pick has to be deducted by 1
			option_pick="${options[$user_pick - 1]}"
		else
			limit_attempts
		fi
	done
}

# --------------------------------------------------------------------------- #
# Limit attempts for the user input to prevent endlessness
# --------------------------------------------------------------------------- #
function limit_attempts() {
	attempt=$((attempt + 1))

	if [ "$attempt" -le "$max_tries" ]; then
		print error "Invalid input!"
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
function is_installed() {
	local package_name=$1

	if [ -x "$(command -v "$package_name")" ]; then
		return 0
	else
		return 1
	fi
}

# --------------------------------------------------------------------------- #
#                                                      Install the program(s)
# --------------------------------------------------------------------------- #
function install_package() {
	local package_name=$1

	if is_installed "$package_name"; then
		print note "The package" \
			"$(format bold)$package_name$(format /bold)" \
			"is already installed."
		return 0
	fi

	print question "Do you want to install package" \
		"$(format bold)$package_name$(format /bold)?"

	if confirm; then
		print info "Using \`$package_manager\` to install" \
			"$(format bold)$package_name$(format /bold)..."

		local install_command
		# Debian & Ubuntu
		if [[ $package_manager == "apt" ]]; then
			install_command="install"
		# Arch Linux
		elif [[ $package_manager == "pacman" ]]; then
			install_command="--sync"
		fi

		if command sudo "$package_manager" "$install_command" "$package_name"; then
			print note "Installed" \
				"$(format bold)$package_name$(format /bold) with a success."
			return 0
		else
			print error "Something went wrong with installation!"
			terminate
		fi
	else
		print note "Skipped installing this package."
		return 1
	fi
}

# --------------------------------------------------------------------------- #
# Check if given path or directory name exists
# --------------------------------------------------------------------------- #
function directory_exists() {
	local dir_path=$1

	if [ -d "$dir_path" ]; then
		return 0
	else
		return 1
	fi
}

# --------------------------------------------------------------------------- #
# Check if given path or file name exists
# --------------------------------------------------------------------------- #
function file_exists() {
	local file_path=$1

	if [ -e "$file_path" ]; then
		return 0
	else
		return 1
	fi
}

# --------------------------------------------------------------------------- #
# Check if given symbolic link file to specific configuration file exists
# --------------------------------------------------------------------------- #
function symlink_exists() {
	local symlink_path=$1

	if [ -L "$symlink_path" ]; then
		return 0
	else
		return 1
	fi
}

# --------------------------------------------------------------------------- #
#     Create symbolic link to a specific configuration file from the dotfiles
# --------------------------------------------------------------------------- #
function create_symlink() {
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
# Print the short output of the program version
# --------------------------------------------------------------------------- #
function print_version() {
	local program=$1

	local version_info
	version_info=$(command "$program" --version | head --lines 1)

	print info "Printing version information..."
	print note "$version_info"
}

# --------------------------------------------------------------------------- #
# Wrappers for printing the readable output
# for a specified part of the installation
# --------------------------------------------------------------------------- #
function start_part() {
	local title=$1

	printf -- "\n--------- [ %s ] \n" "$(format underline)$title$(format reset)"

	if [ -n "${2-}" ]; then
		local info_message=$2

		print info "$info_message..."
	fi
}

function end_part() {
	if [ -n "${1-}" ]; then
		local success_message=$1

		print success "$success_message"
	else
		print success "Done."
	fi

	printf -- "---------\n"
	return 0
}

function terminate() {
	printf "\n%s\n\n" "$(format fg red)Installation terminated.$(format reset)"
	exit 1
}

# =========================================================================== #
# Main features
# =========================================================================== #

# --------------------------------------------------------------------------- #
# Get the name of currently used Linux's distribution
# and check if it's supported
# --------------------------------------------------------------------------- #
function check_distribution() {
	start_part "Linux distribution" \
		"Determining if the current Linux distribution is supported"

	function get_name() {
		command cat /etc/*-release \
			| command grep --only-matching --perl-regexp '(?<=^NAME=\").*(?=\")'
	}

	distribution_name=$(get_name)
	print note "You are on" \
		"$(format bold)$distribution_name$(format /bold) distribution."

	function is_supported() {
		for supported_distribution in "${!package_managers[@]}"; do
			if [[ $distribution_name =~ $supported_distribution ]]; then
				package_manager=${package_managers[$distribution_name]}

				return 0
			fi
		done

		# Fail if not found
		return 1
	}

	if is_supported; then
		print note "This installation will use the" \
			"$(format bold)$package_manager$(format /bold) package manager."
		end_part "This distribution is supported."
	else
		print error "Sorry, this distribution is not supported!"
		terminate
	fi
}

# --------------------------------------------------------------------------- #
# Check if required programs exists,
# and if not, install the missing ones
# --------------------------------------------------------------------------- #
function check_required_packages() {
	start_part "Required packages" \
		"Checking if the required packages are installed"

	# Determine a list of missing packages
	local missing_packages=()
	for package_name in ${required_packages[*]}; do
		if ! is_installed "$package_name"; then
			missing_packages+=("$package_name")
		else
			print note "The package $(format bold)$package_name$(format /bold) is already installed."
		fi
	done

	if ! [ ${#missing_packages[*]} -eq 0 ]; then
		print warning "These following missing programs are required for this installation to continue:"
		format fg yellow
		printf -- "- $(format bold)%s$(format /bold)\n" "${missing_packages[@]}"
		format reset
	fi

	for package_name in "${missing_packages[@]}"; do
		install_package "$package_name"

		if ! is_installed "$package_name"; then
			print error "This installation can't be continued without the required programs!"
			terminate
		fi
	done

	end_part "The required programs are installed."
}

# --------------------------------------------------------------------------- #
#                               switch to the user's home directory (`$HOME`)
# --------------------------------------------------------------------------- #
function goto_home_directory() {
	start_part "Current working directory" \
		"checking current working directory"

	if [[ $PWD == "$HOME" ]]; then
		print note "you are already in \$HOME=\"$PWD\" directory."
	else
		command cd "$HOME"
		print note "changed working directory to \$HOME=\"$HOME\"."
	fi

	end_part "checking completed."
}

# --------------------------------------------------------------------------- #
#                                                         Change the hostname
# --------------------------------------------------------------------------- #
function change_hostname {
	start_part \
		"Device hostname" \
		"Changing the device's hostname"

	print question "Do you want to set this device's \"\$HOSTNAME\"?"

	if confirm; then
		print question "What is going to be a new name of this device?"
		read -r -p "Hostname: " new_hostname

		command sudo hostnamectl set-hostname "$new_hostname"

		print note "Changed device's \$HOSTNAME from \"$HOSTNAME\" to \"$new_hostname\"."
		print note "The change will take an effect after restarting the device."

		end_part "Device's \$HOSTNAME configured."
	else
		print warning "Skipped configuring device's \$HOSTNAME."
		printf -- "---------\n"
	fi
}

# --------------------------------------------------------------------------- #
#                                                            Add the new user
# --------------------------------------------------------------------------- #
function add_new_user {
	start_part \
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

		print note "Changed directory to: /home/$new_username."

		end_part "Finished adding new user."
	else
		print note "Skipped adding new user."
		printf -- "---------\n"
	fi
}

# --------------------------------------------------------------------------- #
#                                                     Delete the default user
# --------------------------------------------------------------------------- #
function delete_default_user {
	start_part \
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

		end_part "Finished removing the default user."
	else
		print note "Skipped removing the default user."
		printf -- "---------\n"
	fi
}

# --------------------------------------------------------------------------- #
#                                                        Disable root account
# --------------------------------------------------------------------------- #
function disable_root_account {
	start_part \
		"Disable root" \
		"Attempting to disable root account"

	print question "Do you want to disable the root account?"

	if confirm; then
		command sudo -s passwd --lock "root"

		print note 'Disabled the root account, from now no one can login as "root".'

		end_part "Finished disabling root account."
	else
		print warning 'The "root" account is still enabled, this could be a potential security risk!'
		printf -- "---------\n"
	fi
}

# --------------------------------------------------------------------------- #
#                          Checking if dotfiles and other configuration files
#                                            already exists in home directory
# --------------------------------------------------------------------------- #
function check_for_existing_files() {
	start_part "Existing files" \
		"Checking for existing dotfiles or configuration files in home directory"

	local existing_config_files=()

	for config_file_path in "${config_files[@]}"; do
		local file_name
		file_name=$(command basename "$config_file_path")

		if file_exists "$file_name"; then
			existing_config_files+=("$file_name")
		fi
	done

	local dotfiles_path="${environment_variables[DOTFILES]}"

	if directory_exists "$dotfiles_path" || ((${#existing_config_files[@]})); then
		if directory_exists "$dotfiles_path"; then
			print error "The dotfiles directory \"$dotfiles_dir_name\" exists in home directory!"
		fi

		if ((${#existing_config_files[@]})); then
			print error "These following configuration files exists in home directory!"
			format fg red
			printf -- "- \"%s\"\n" "${existing_config_files[@]}"
			format reset
		fi

		format fg red
		fold --spaces --width 80 <<< "$(
			printf "\n%s\n" \
				"To avoid problems, please backup your existing dotfiles and configurations, then run this installation file again."
		)"
		format reset

		terminate
	else
		end_part "There are no existing dotfiles or configuration files."
	fi
}

# --------------------------------------------------------------------------- #
#                                   Clone dotfiles from the remote repository
# --------------------------------------------------------------------------- #
function clone_dotfiles {
	start_part \
		"Cloning dotfiles" \
		"Using git to clone the dotfiles from the remote repository"

	print note "The dotfiles remote repository URL is: $dotfiles_remote_repository"

	command git clone $dotfiles_remote_repository

	local dotfiles_dir_name="${environment_variables[DOTFILES]}"

	if ! directory_exists "$dotfiles_dir_name"; then
		print error "Something went wrong with cloning the dotfiles!"
		terminate
	else
		end_part "Successfully cloned the dotfiles from the remote repository."
	fi
}

# --------------------------------------------------------------------------- #
#                             Create a symbolic link to the Git configuration
# --------------------------------------------------------------------------- #
function link_git_configuration {
	start_part \
		"Git's configuration file"

	create_symlink "git"

	end_part "Git's configuration file is ready."
}

# --------------------------------------------------------------------------- #
#                                      Configure the default shell to be used
# --------------------------------------------------------------------------- #
function set_default_shell() {
	start_part "Default shell" \
		"Configuring the default shell"

	print question "Which shell do you want to use as the default one?"
	pick_option "${shell_options[@]}"
	default_shell=$option_pick

	environment_variables["SHELL"]="$default_shell"

	function get_current_default_shell() {
		command basename "$(
			command awk \
				--field-separator : \
				-v user="$USER" '$1 == user {print $NF}' \
				/etc/passwd
		)"
	}

	print info "Checking if this $(format bold)$default_shell$(format /bold) is installed..."

	local skipped_installation=false
	if ! is_installed "$default_shell"; then
		print warning "This shell is not installed."

		if ! install_package "$default_shell"; then
			skipped_installation=true
		fi
	else
		print success "This shell is already installed."
		print_version "$default_shell"
	fi

	function configure_default_shell() {
		if [ "$(get_current_default_shell)" != "$default_shell" ]; then
			local shell_executable_filePath
			shell_executable_filePath=$(command which "$default_shell")

			print note "This shell executable file path will be set as your default shell: $shell_executable_filePath"

			command sudo usermod --shell "$shell_executable_filePath" "$USER"
		else
			print note "This shell is already set as the default one."
		fi
	}

	if [ "$skipped_installation" == true ]; then
		print warning "You refused to install this shell!"
		format fg yellow
		printf -- "---\n"
		printf "%s\n" \
			"This is not mandatory for this installation." \
			"You can install it later by yourself," \
			"however the installation will not configure" \
			"the picked shell to be set as default one."
		format reset
		printf -- "---------\n"
	else
		print info "Configuring this shell to be the default one..."
		configure_default_shell

		end_part "Finished default shell configuration."
	fi
}

# --------------------------------------------------------------------------- #
#              Create symbolic link to the default shell's configuration file
# --------------------------------------------------------------------------- #
function link_default_shell_configuration {
	start_part \
		"Shell's configuration file"

	create_symlink "${environment_variables[SHELL]}"

	end_part "Default shell's configuration file is ready."
}

# --------------------------------------------------------------------------- #
#                                     Determine the default editor to install
# --------------------------------------------------------------------------- #
function set_default_editor {
	start_part "Default editor" \
		"Configure the default editor"

	print question "Which $(format bold)editor$(format /bold)" \
		"do you want to set as the default one?"
	pick_option "${editor_options[@]}"

	environment_variables["EDITOR"]="$default_editor"

	local skipped_installation=false

	print info "Checking if \"$default_editor\" is installed..."

	if ! is_installed "$default_editor"; then
		print warning "This default editor \"$default_editor\" is not installed!"
		if ! install_package "$default_editor"; then
			skipped_installation=true
		fi
	else
		print note "This default program is already installed."
		print_version "$default_editor"
	fi

	if [[ $skipped_installation == true ]]; then
		print warning "You refused to install this default shell!"
		format fg yellow
		printf -- "---\n"
		printf "%s\n" \
			"This is not mandatory for this installation." \
			"You can install it later by yourself."
		format reset
		printf -- "---------\n"
	else
		end_part "Finished configuring the default text editor."
	fi
}

# --------------------------------------------------------------------------- #
#                                     Determine the user mode for this system
# --------------------------------------------------------------------------- #
function set_user_mode() {
	start_part "User mode" \
		"Determining the user mode for this device's system"

	print question "Which $(format bold)user mode$(format /bold)" \
		"do you want to set?"
	pick_option "${user_mode_options[@]}"
	user_mode=$option_pick

	environment_variables["USER_MODE"]="$user_mode"

	end_part "User mode set to $(format bold)$user_mode$(format /bold)."
}

# --------------------------------------------------------------------------- #
#                    Determine if the user want to build program from sources
# --------------------------------------------------------------------------- #
function determine_if_build_from_source {
	start_part \
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

	end_part "Decision about building programs from their source is done."
}

# --------------------------------------------------------------------------- #
#                             Configure default shell's environment variables
# --------------------------------------------------------------------------- #
function configure_environment_variables {
	start_part \
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

	end_part "Finished setting up environment variables."
}

# =========================================================================== #
# Main runtime
# =========================================================================== #
function main() {
	printf "%s\n" "$(format fg blue)Starting the installation...$(format reset)"

	check_distribution
	check_required_packages
	goto_home_directory
	set_user_mode
	set_default_shell
	set_default_editor
	# change_hostname
	# add_new_user
	# delete_default_user
	# disable_root_account
	# check_for_existing_files
	# clone_dotfiles
	# link_git_configuration
	# link_default_shell_configuration
	# determine_if_build_from_source
	# configure_environment_variables

	# Finish the installation by starting the set default shell if user wants to
	printf "\n%s\n" "$(format fg green)Installation finished!$(format reset)"
	# print question "Do you want to start the default shell now?"
	# if confirm; then
	# 	print info "Executing default shell and loading its configuration..."
	# 	exec "$default_shell"
	# else
	# 	exit 0
	# fi
}

main
