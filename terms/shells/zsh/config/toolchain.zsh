# https://github.com/jdx/mise
if (( $+commands[mise] )); then
	eval "$(mise env --shell zsh)"
fi

# https://github.com/MordechaiHadad/bob
if (( $+commands[bob] )); then
	path+="$XDG_DATA_HOME/bob/nvim-bin"
fi

