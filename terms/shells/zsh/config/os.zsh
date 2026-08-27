# ===== #
# macOS
# ===== #

if [[ "$OSTYPE" =~ ^"darwin" ]]; then
	export IS_MACOS=true
else
	export IS_MACOS=false
fi

# Brew
if [[ $IS_MACOS = "true" ]]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
	fpath+="$(brew --prefix)/share/zsh/site-functions"
fi
