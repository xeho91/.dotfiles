# =========================================================================== #
# Define path to user's "dotfiles"
# =========================================================================== #
export DOTFILES="$HOME/.dotfiles"

# =========================================================================== #
# Set the default location for Zsh files
# =========================================================================== #
export ZDOTDIR="$DOTFILES/Shells/Zsh"

# =========================================================================== #
# Provide environment variables if currently used device is...
# =========================================================================== #

# `WSL` - Windows Subsystem for Linux
if [[ -v WSL_DISTRO_NAME ]]; then
	export IS_WSL=true
else
	export IS_WSL=false
fi

# Raspberry Pi
if [[ $(cat /proc/cpuinfo | grep Model) =~ "Raspberry Pi" ]]; then
	export IS_RASPBERRYPI=true
else
	export IS_RASPBERRYPI=false
fi

# MacOS
if [[ "$OSTYPE" =~ ^"darwin" ]]; then
	export IS_MACOS=true
else
	export IS_MACOS=false
fi

# Android
if [[ "$OSTYPE" =~ ^"android" ]]; then
	export IS_ANDROID=true
else
	export IS_ANDROID=false
fi

# =========================================================================== #
# XDG base directory
# ------------------
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
# =========================================================================== #
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

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
export PAGER="less"
#
# Set passing default options when running `less` command
export LESS='--raw-control-chars --status-column --tab=4 --window=5 --chop-long-lines'
#
# Allow `less` to preview compressed files
if (( $+commands[lesspipe.sh] )); then
	export LESSOPEN="|lesspipe.sh %s"
fi

# =========================================================================== #
# Defaulting the location to config files for both editors - (Neo)Vim
# -------------------------------------------------------------------
# https://vi.stackexchange.com/questions/11879/how-can-put-vimrc-and-viminfo-into-vim-director
# =========================================================================== #
# export VIMRC="$DOTFILES/Editors/Neovim/init.vim"
# export VIMINIT="source $VIMRC"

# =========================================================================== #
# Terminals
# =========================================================================== #

# WezTerm
if (( $+commands[wezterm] )); then
	export WEZTERM_CONFIG_FILE="$DOTFILES/Terminals/wezterm.lua"
fi

# =========================================================================== #
# Other
# =========================================================================== #
export USER_MODE="developer"
export USE_PROMPT="starship"

export GH_BINPATH="$HOME/.local/bin"

# https://sw.kovidgoyal.net/kitty/conf/#kitty-conf
export KITTY_CONFIG_DIRECTORY="$DOTFILES/terminals/kitty"

# https://pnpm.io/installation
export PNPM_HOME="$XDG_DATA_HOME/pnpm"
export PATH="$PNPM_HOME:$PATH"

# Custom
export USE_PROMPT="starship"
export USER_MODE="developer"

. "$HOME/.cargo/env"

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true
