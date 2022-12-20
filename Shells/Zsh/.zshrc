# =========================================================================== #
# Load Zsh configurations
# -----------------------
# NOTE: Order matters.
# Don't make it dynamic with loop, because there's no prioritization.
# =========================================================================== #
ZSH_CONFIG_DIR="$ZDOTDIR/configs"

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

# Activate nvm - Node.js version manager
export NVM_DIR="$HOME/.nvm"

if [[ $IS_MACOS == true ]]; then
	source "$(brew --prefix nvm)/nvm.sh"
else
	source /usr/share/nvm/init-nvm.sh
fi

# Remove duplicates
typeset -aU path dpath fpath manpath module_path

# Appending additional path for manpages, because some plugins install it under
# `share` directory
unset MANPATH # Disables warning when reloading
export MANPATH=:"$(manpath):$ZPFX/share/man"

# Volta - https://volta.sh/
export VOLTA_HOME="$HOME/.volta"

# Add binaries
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.deno/bin:$PATH"
export PATH="$VOLTA_HOME/bin:$PATH"
if [[ $IS_MACOS == true ]]; then
  export PATH="/opt/homebrew/bin:$PATH"
fi

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true
