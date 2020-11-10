# =========================================================================== #
# Locale settings variables
# -------------------------
# https://help.ubuntu.com/community/EnvironmentVariables#Locale_setting_variables
# =========================================================================== #
export LANG="en_US.UTF-8"
export LANGUAGE="en_US:en"

# =========================================================================== #
# Preferred application variables
# -------------------------------
# https://help.ubuntu.com/community/EnvironmentVariables#Preferred_application_variables
# =========================================================================== #

# EDITOR
# ------
if builtin command -v nvim > /dev/null 2>&1; then
	export EDITOR=nvim
else
	export EDITOR=vim
fi

# PAGER
# ------
export PAGER=less
#
# Set passing default options when running `less` command
export LESS='--raw-control-chars --status-column --tab=4 --window=5 --chop-long-lines'
#
# Allow `less` to preview compressed files
if builtin command -v lesspipe.sh > /dev/null 2>&1; then
	export LESSOPEN="|lesspipe.sh %s"
fi

# =========================================================================== #
# Define path to user's "dotfiles"
# =========================================================================== #
export DOTFILES=$HOME/.dotfiles

# =========================================================================== #
# Set the default location for Zsh files
# =========================================================================== #
export ZDOTDIR=$DOTFILES/Linux/Zsh

