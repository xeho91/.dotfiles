zmodload zsh/datetime
typeset -gF ZSHRC_START=$EPOCHREALTIME

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
source "$ZSH_CONFIG_DIR/toolchain.zsh"
source "$ZSH_CONFIG_DIR/aliases.zsh"
source "$ZSH_CONFIG_DIR/preferred.zsh"
source "$ZSH_CONFIG_DIR/plugins.zsh"
source "$ZSH_CONFIG_DIR/programs.zsh"
source "$ZSH_CONFIG_DIR/functions.zsh"
source "$ZSH_CONFIG_DIR/prompt.zsh"


# =========================================================================== #
# Other
# =========================================================================== #

# Remove duplicates
typeset -aU path dpath fpath manpath module_path

typeset -gF ZSHENV_ELAPSED
typeset -gF ZSHRC_ELAPSED=$(( EPOCHREALTIME - ZSHRC_START ))
printf '\033[1m.zshenv\033[0m loaded in \033[36m%.2f secs\033[0m\n' "$ZSHENV_ELAPSED"
if [[ -n ${ZPROFILE_ELAPSED:-} ]]; then
	printf '\033[1m.zprofile\033[0m loaded in \033[36m%.2f secs\033[0m\n' "$ZPROFILE_ELAPSED"
	unset ZPROFILE_ELAPSED
fi
printf '\033[1m.zshrc\033[0m loaded in \033[36m%.2f secs\033[0m\n' "$ZSHRC_ELAPSED"
unset ZSHENV_ELAPSED ZSHRC_START ZSHRC_ELAPSED
