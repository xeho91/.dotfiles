# =========================================================================== #
# Oh My Zsh
# =========================================================================== #
# Path to your oh-my-zsh installation.
export ZSH="$ZDOTDIR/ohmyzsh"
source $ZSH/oh-my-zsh.sh

# =========================================================================== #
# Load Zsh configurations
# -----------------------
# NOTE: Order matters.
# Don't make it dynamic with loop, because there's no prioritization.
# =========================================================================== #
ZSH_CONFIG_DIR="$ZDOTDIR/configs"

source "$ZSH_CONFIG_DIR/os.zsh"
source "$ZSH_CONFIG_DIR/terminals.zsh"
source "$ZSH_CONFIG_DIR/options.zsh"
source "$ZSH_CONFIG_DIR/keybindings.zsh"
source "$ZSH_CONFIG_DIR/manager.zsh"
# source "$ZSH_CONFIG_DIR/runtimes.zsh"
source "$ZSH_CONFIG_DIR/programs.zsh"
source "$ZSH_CONFIG_DIR/plugins.zsh"
source "$ZSH_CONFIG_DIR/functions.zsh"
source "$ZSH_CONFIG_DIR/aliases.zsh"
source "$ZSH_CONFIG_DIR/completions.zsh"
source "$ZSH_CONFIG_DIR/prompt.zsh"

# =========================================================================== #
# Other
# =========================================================================== #

# Remove duplicates
typeset -aU path dpath fpath manpath module_path

# Appending additional path for manpages, because some plugins install it under
# `share` directory
manpath+="$ZPFX/share/man"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
