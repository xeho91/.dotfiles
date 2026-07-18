# =========================================================================== #
# Oh My Zsh
# =========================================================================== #
# Path to your oh-my-zsh installation.
if [[ -f "$ZDOTDIR/ohmyzsh/oh-my-zsh.sh" ]]; then
	export ZSH_CACHE_DIR="$XDG_CACHE_HOME/oh-my-zsh"
	source $ZDOTDIR/ohmyzsh/oh-my-zsh.sh
fi

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
source "$ZSH_CONFIG_DIR/programs.zsh"
source "$ZSH_CONFIG_DIR/functions.zsh"
source "$ZSH_CONFIG_DIR/aliases.zsh"
source "$ZSH_CONFIG_DIR/completions.zsh"
source "$ZSH_CONFIG_DIR/prompt.zsh"

# =========================================================================== #
# Other
# =========================================================================== #

# Remove duplicates
typeset -aU path dpath fpath manpath module_path



[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# pnpm
export PNPM_HOME="/Users/xeho91/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end
source /Users/xeho91/.safe-chain/scripts/init-posix.sh # Safe-chain Zsh initialization script


if (( $+commands[direnv] )); then
	eval "$(direnv hook zsh)"
fi

if (( $+commands[mise] )); then
	eval "$(mise activate zsh)"
fi

