# Activate mise hooks after its environment has put mise on PATH
if (( $+commands[mise] )); then
	eval "$(mise activate zsh)"
fi

# https://github.com/MordechaiHadad/bob
if (( $+commands[bob] )); then
	path+="$XDG_DATA_HOME/bob/nvim-bin"
fi

# https://github.com/gitleaks/gitleaks
if (( $+commands[gitleaks] )); then
	export GITLEAKS_CONFIG="$XDG_CONFIG_HOME/gitleaks/config.toml"
fi

# https://github.com/stedolan/jq
if (( $+commands[jq] )); then
	# NOTE:
	# Colors configuration in this order:
	# "null:false:true:numbers:strings:arrays:objects"
	# Source: https://stedolan.github.io/jq/manual/#Colors
	export JQ_COLORS="1;30:0;31:0;32:0;33:0;37:1;35:1;36"
fi

# https://github.com/Schniz/fnm
if (( $+commands[less] )); then
  # Set passing default options when running `less` command
  export LESS='--raw-control-chars --status-column --tab=4 --window=5 --chop-long-lines'
fi

if (( $+commands[node] )); then
	export NODE_OPTIONS="--max-old-space-size=8192"
fi

# Mason (Neovim package manager) - LSP servers, DAP, linters, formatters
if [[ -d "$XDG_DATA_HOME/nvim/mason/bin" ]]; then
  path+="$XDG_DATA_HOME/nvim/mason/bin"
fi

if (( $+commands[pnpm] )); then
	export PNPM_HOME="$XDG_DATA_HOME/pnpm"
	path+="$PNPM_HOME/bin"
fi

# Initialize after compinit so zoxide can register completion for `j`.
if (( $+commands[zoxide] )); then
	eval "$(zoxide init zsh --cmd j)"
fi
