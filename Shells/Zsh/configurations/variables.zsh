if (( $+commands[fzf] )); then
	if (( $+commands[fd] )); then
		export FZF_DEFAULT_COMMAND="fd --hidden --follow --exclude \".git\" --exclude \"node_modules\""; \
		export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"; \
		export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type d"; \
	fi
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
fi

if (( $+commands[jq] )); then
	# NOTE:
	# Colors configuration in this order:
	# "null:false:true:numbers:strings:arrays:objects"
	# Source: https://stedolan.github.io/jq/manual/#Colors
	export JQ_COLORS="1;30:0;31:0;32:0;33:0;37:1;35:1;36"
fi

if (( $+commands[nnn] )); then
	export NNN_FIFO="/tmp/nnn.fifo"
	export NNN_USE_EDITOR=1
	export NNN_PLUG="p:preview-tui;"
fi

