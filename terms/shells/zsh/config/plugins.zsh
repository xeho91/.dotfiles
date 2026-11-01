# =========================================================================== #
# Oh My Zsh
# =========================================================================== #

# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git-auto-fetch/README.md
export GIT_AUTO_FETCH_INTERVAL=3600

# Add generated autoload completions before Oh My Zsh runs `compinit`
fpath=(
	"$ZDOTDIR/ohmyzsh/custom/plugins/zsh-completions/src"
	"$ZDOTDIR/completions"
	$fpath
)

plugins=(
  # External
  fast-syntax-highlighting
  zsh-autopair
  zsh-autosuggestions
  zsh-completions
  # OMZ built-in
  bgnotify
  colored-man-pages
  copybuffer
  copyfile
  copypath
  dirhistory
  encode64
  extract
  fzf
  git-auto-fetch
  vi-mode
  fzf-tab
)

if [[ -f "$ZDOTDIR/ohmyzsh/oh-my-zsh.sh" ]]; then
	export ZSH_CACHE_DIR="$XDG_CACHE_HOME/oh-my-zsh"
	source $ZDOTDIR/ohmyzsh/oh-my-zsh.sh
fi

# Source generated setup snippets after Oh My Zsh initializes `compdef`
for completion_file in "$ZDOTDIR"/completions/generated/*.zsh(N); do
	source "$completion_file"
done
