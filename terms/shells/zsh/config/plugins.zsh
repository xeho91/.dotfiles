# =========================================================================== #
# Oh My Zsh
# =========================================================================== #

# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git-auto-fetch/README.md
export GIT_AUTO_FETCH_INTERVAL=3600

plugins=(
  # External
  fast-syntax-highlighting
  fzf-tab
  zsh-autopair
  zsh-autosuggestions
  zsh-completions
  # OMZ built-in
  1password
  alias-finder
  argocd
  bgnotify
  brew
  colored-man-pages
  copybuffer
  copypath
  dirhistory
  docker-compose
  docker
  extract
  fzf
  git-auto-fetch
  gh
  pass-cli
  procs
  rust
  uv
  vi-mode
)

# Path to your oh-my-zsh installation.
if [[ -f "$ZDOTDIR/ohmyzsh/oh-my-zsh.sh" ]]; then
	export ZSH_CACHE_DIR="$XDG_CACHE_HOME/oh-my-zsh"
	source $ZDOTDIR/ohmyzsh/oh-my-zsh.sh
fi
