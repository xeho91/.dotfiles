# =========================================================================== #
# Oh My Zsh
# =========================================================================== #
plugins=(
  # External
  zsh-autosuggestions
  fast-syntax-highlighting
  zsh-completions
  fzf-tab
  zsh-autopair

  # OMZ built-in
  aliases
  colorize
  copybuffer
  copypath
  dirhistory
  dotenv
  extract
  fancy-ctrl-z
  frontend-search
  fzf
  git-auto-fetch
  gulp
  history-substring-search
  node
  pip
  pipenv
  vi-mode
  web-search
)

# Path to your oh-my-zsh installation.
if [[ -f "$ZDOTDIR/ohmyzsh/oh-my-zsh.sh" ]]; then
	export ZSH_CACHE_DIR="$XDG_CACHE_HOME/oh-my-zsh"
	source $ZDOTDIR/ohmyzsh/oh-my-zsh.sh
fi

