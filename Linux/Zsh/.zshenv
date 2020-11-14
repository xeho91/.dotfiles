# =========================================================================== #
# Define path to user's "dotfiles"
# =========================================================================== #
export DOTFILES=$HOME/.dotfiles

# =========================================================================== #
# Set the default location for Zsh files
# =========================================================================== #
export ZDOTDIR=$DOTFILES/Linux/Zsh

# =========================================================================== #
# XDG base directory
# ------------------
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
# -
# NOTE: I wanted to separate the files generated by using Zsh, hence why
#		they're in $ZDOTDDIR directory instead of $HOME
# =========================================================================== #
export XDG_CONFIG_HOME="$ZDOTDIR/.config"
export XDG_DATA_HOME="$ZDOTDIR/.local/share"
export XDG_CACHE_HOME="$ZDOTDIR/.cache"

# =========================================================================== #
# Make administrator commands/tools available in Zsh
# =========================================================================== #
export PATH="/usr/sbin:$PATH"

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
if (( $+commands[nvim] )); then
	export EDITOR="nvim"
else
	export EDITOR="vim"
fi

# PAGER
# ------
export PAGER=less
#
# Set passing default options when running `less` command
export LESS='--raw-control-chars --status-column --tab=4 --window=5 --chop-long-lines'
#
# Allow `less` to preview compressed files
if (( $+commands[lesspipe.sh] )); then
	export LESSOPEN="|lesspipe.sh %s"
fi

