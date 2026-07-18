# # https://github.com/ajeetdsouza/zoxide
if (( $+commands[zoxide] )); then
	eval "$(zoxide init zsh --cmd j)"
fi

# https://github.com/junegunn/fzf
# if (( $+commands[fzf] )); then
# 	export FZF_COMPLETION_TRIGGER="@@"; \
# 	export FZF_DEFAULT_OPTS=" \
# 		--layout=reverse \
# 		--info=inline \
# 		--height=75% \
# 		--multi \
# 		--border \
# 		--preview-window=:hidden \
# 		--preview \"([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200\" \
# 		--prompt=\"∼ \" \
# 		--pointer=\"▶\" \
# 		--marker=\"✓\" \
# 		--bind \"?:toggle-preview\" \
# 		--bind \"ctrl-a:select-all\" \
# 		--bind \"ctrl-d:deselect-all\" \
# 		--bind \"ctrl-t:toggle-all\" \
# 		--bind \"ctrl-r:reload($FZF_DEFAULT_COMMAND)\" \
# 		--bind \"ctrl-y:execute-silent(echo {+} | pbcopy)\" \
# 		--bind \"ctrl-e:execute(echo {+} | xargs -o vim)\" \
# 		--bind \"ctrl-v:execute(code {+})\" \
# 		--bind \"ctrl-j:preview-page-down\" \
# 		--bind \"ctrl-k:preview-page-up\" \
# 	"
# 	if (( $+commands[fd] )); then
# 		export FZF_DEFAULT_COMMAND="fd --hidden --follow --exclude \".git\" --exclude \"node_modules\""; \
# 		export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"; \
# 		export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type d"; \
# 	fi
# fi

# https://github.com/stedolan/jq
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

# https://github.com/Spotifyd/spotifyd
# TODO: It breaks
# if (( $+commands[spt] )); then
# 	eval "$(spt --completions zsh)"
# fi

# https://pnpm.io/installation
if [[ -e "$XDG_DATA_HOME/pnpm" ]]; then
  export PNPM_HOME="$XDG_DATA_HOME/pnpm"
  path+="$PNPM_HOME"
fi

# https://cli.github.com
if (( $+commands[gh] )); then
  export GH_BINPATH="$HOME/.local/bin"
fi

# https://github.com/luarocks/luarocks
if (( $+commands[luarocks] )); then
  eval $(luarocks path)
fi

# https://github.com/rust-lang/rustup
if (( $+commands[rustup] )); then
	if [ -d "$HOME/.cargo/bin" ]; then
		path+="$HOME/.cargo/bin"
	fi
	if [ -d "$HOME/.cargo/env" ]; then
		. "$HOME/.cargo/env"
	fi
fi

# https://github.com/MordechaiHadad/bob
if (( $+commands[bob] )); then
	path+="$XDG_DATA_HOME/bob/nvim-bin"
fi

# https://github.com/Schniz/fnm
if (( $+commands[fnm] )); then
    eval "$(fnm env --use-on-cd)"
fi


if (( $+commands[less] )); then
  # Set passing default options when running `less` command
  export LESS='--raw-control-chars --status-column --tab=4 --window=5 --chop-long-lines'
fi

if (( $+commands[node] )); then
	export NODE_OPTIONS="--max-old-space-size=8192"
fi
