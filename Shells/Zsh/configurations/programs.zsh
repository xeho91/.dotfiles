# # https://github.com/denisidoro/navi
if (( $+commands[navi] )); then
	eval "$(navi widget zsh)";
fi

# https://github.com/dduan/tre
if (( $+commands[tre] )); then
	function tre() {
		command tre "$@" -e && source "/tmp/tre_aliases_$USER" 2>/dev/null;
	}
fi


# https://github.com/knqyf263/pet
if (( $+commands[pet] )); then
	function prev() {
		PREV=$(fc -lrn | head -n 1)

		sh -c "pet new `printf %q "$PREV"`"
	}

	function pet-select() {
		BUFFER=$(pet search --query "$LBUFFER")
		CURSOR=$#BUFFER

		zle redisplay
	}

	zle -N pet-select
	stty -ixon
	bindkey "^s" pet-select
fi

# https://github.com/ajeetdsouza/zoxide
if (( $+commands[zoxide] )); then
	eval "$(zoxide init zsh --cmd j)"
fi

# https://github.com/junegunn/fzf
if (( $+commands[fzf] )); then
	export FZF_COMPLETION_TRIGGER="@@"; \
	export FZF_DEFAULT_OPTS=" \
		--layout=reverse \
		--info=inline \
		--height=75% \
		--multi \
		--border \
		--preview-window=:hidden \
		--preview \"([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200\" \
		--prompt=\"∼ \" \
		--pointer=\"▶\" \
		--marker=\"✓\" \
		--bind \"?:toggle-preview\" \
		--bind \"ctrl-a:select-all\" \
		--bind \"ctrl-d:deselect-all\" \
		--bind \"ctrl-t:toggle-all\" \
		--bind \"ctrl-r:reload($FZF_DEFAULT_COMMAND)\" \
		--bind \"ctrl-y:execute-silent(echo {+} | pbcopy)\" \
		--bind \"ctrl-e:execute(echo {+} | xargs -o vim)\" \
		--bind \"ctrl-v:execute(code {+})\" \
		--bind \"ctrl-j:preview-page-down\" \
		--bind \"ctrl-k:preview-page-up\" \
	"
	if (( $+commands[fd] )); then
		export FZF_DEFAULT_COMMAND="fd --hidden --follow --exclude \".git\" --exclude \"node_modules\""; \
		export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"; \
		export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type d"; \
	fi
fi

# https://github.com/stedolan/jq
if (( $+commands[jq] )); then
	# NOTE:
	# Colors configuration in this order:
	# "null:false:true:numbers:strings:arrays:objects"
	# Source: https://stedolan.github.io/jq/manual/#Colors
	export JQ_COLORS="1;30:0;31:0;32:0;33:0;37:1;35:1;36"
fi

# https://github.com/junegunn/fzf
if (( $+commands[nnn] )); then
	export NNN_FIFO="/tmp/nnn.fifo"
	export NNN_USE_EDITOR=1
	export NNN_PLUG="p:preview-tui;"
fi

# https://github.com/Canop/broot
if (( $+commands[broot] )); then
	source "$XDG_CONFIG_HOME/broot/launcher/bash/br"
fi

# https://github.com/Spotifyd/spotifyd
if (( $+commands[spt] )); then
	eval "$(spt --completions zsh)"
fi
