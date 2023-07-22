# =====
# MacOS
# =====
# Brew
if [[ $IS_MACOS = "true" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
	fpath+="$(brew --prefix)/share/zsh/site-functions"
fi

# =======
# Manjaro
# =======
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
	source /usr/share/zsh/manjaro-zsh-config
fi
