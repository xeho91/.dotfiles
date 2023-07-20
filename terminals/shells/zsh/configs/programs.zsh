# https://github.com/nvm-sh/nvm
# export NVM_DIR="$HOME/.nvm"
# if [[ $IS_MACOS == true ]]; then
# 	source "$(brew --prefix nvm)/nvm.sh"
# else
# 	source /usr/share/nvm/init-nvm.sh
# fi

# https://github.com/denisidoro/navi
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
	# source "$XDG_CONFIG_HOME/broot/launcher/bash/br"
fi

# https://github.com/Spotifyd/spotifyd
# TODO: It breaks
# if (( $+commands[spt] )); then
# 	eval "$(spt --completions zsh)"
# fi

# https://github.com/mgunyho/tere
if (( $+commands[tere] )); then
	tere() {
		local result=$(command tere "$@")
		[ -n "$result" ] && cd -- "$result"
	}
fi

# https://pnpm.io/installation
	export PNPM_HOME="$XDG_DATA_HOME/pnpm"
	export PATH="$PNPM_HOME:$PATH"

# https://cli.github.com
if (( $+commands[gh] )); then
  export GH_BINPATH="$HOME/.local/bin"
fi
# GitHub Copilot CLI
if (( $+commands[github-copilot-cli] )); then
	eval "$(github-copilot-cli alias -- "$0")"
fi

# https://github.com/luarocks/luarocks
if (( $+commands[luarocks] )); then
  eval $(luarocks path)
fi


# https://github.com/rust-lang/rustup
if (( $+commands[rustup-init] )); then
    export PATH="$HOME/.cargo/bin:$PATH"
fi

# https://github.com/MordechaiHadad/bob
if (( $+commands[bob] )); then
	export PATH="$XDG_DATA_HOME/bob/nvim-bin:$PATH"
fi

# bun completions
# if (( $+commands[bun] )); then
#     [ -s "$HOME/.bun/_bun" ] && source "/Users/xeho91/.bun/_bun"
# fi

# https://github.com/mklabs/tabtab
if (( $+commands[tabtab] )); then
    [[ -f $HOME/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true
fi

# https://github.com/Schniz/fnm
if (( $+commands[fnm] )); then
    eval "$(fnm env --use-on-cd)"
fi
