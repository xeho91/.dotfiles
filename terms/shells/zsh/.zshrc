# =========================================================================== #
# Load Zsh configurations
# -----------------------
# NOTE: Order matters.
# Don't make it dynamic with loop, because there's no prioritization.
# =========================================================================== #
ZSH_CONFIG_DIR="$ZDOTDIR/config"

source "$ZSH_CONFIG_DIR/os.zsh"
source "$ZSH_CONFIG_DIR/term.zsh"
source "$ZSH_CONFIG_DIR/options.zsh"
source "$ZSH_CONFIG_DIR/keybindings.zsh"
source "$ZSH_CONFIG_DIR/programs.zsh"
source "$ZSH_CONFIG_DIR/plugins.zsh"
source "$ZSH_CONFIG_DIR/functions.zsh"
source "$ZSH_CONFIG_DIR/aliases.zsh"
source "$ZSH_CONFIG_DIR/completions.zsh"
source "$ZSH_CONFIG_DIR/preferred.zsh"
source "$ZSH_CONFIG_DIR/prompt.zsh"


# =========================================================================== #
# Other
# =========================================================================== #

# Remove duplicates
typeset -aU path dpath fpath manpath module_path
