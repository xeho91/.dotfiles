# =============================== #
# Aliases for known UNIX commands
# =============================== #
alias :q="exit"
# Make these commands always verbose
alias mkdir="mkdir -v"
alias rmdir="rmdir -v"

# ============================== #
# Aliases for installed programs
# ============================== #
(( $+commands[bat] )) && alias cat="bat"
(( $+commands[btm] )) && alias btm="btm --battery --color=gruvbox"
(( $+commands[docker] )) && alias dc="docker compose"
(( $+commands[docker] )) && alias dce="docker compose exec"
(( $+commands[dust] )) && alias du="dust"
(( $+commands[exa] )) && alias exa="exa --git --all --long --icons --header"
(( $+commands[git] )) && alias sos="git add . && git wip"
(( $+commands[gitui] )) && alias gu="gitui"
(( $+commands[gpg-tui] )) && alias gpg-tui="gpg-tui --style=colored"
(( $+commands[grex] )) && alias grex="grex --colorize --verbose"
(( $+commands[lazygit] )) && alias lz="lazygit"
(( $+commands[lsd] )) && alias ls="lsd -a"
(( $+commands[nvim] )) && alias vi="nvim"
(( $+commands[nvim] )) && alias vim="nvim"
(( $+commands[procs] )) && alias ps="procs"
(( $+commands[tre] )) && alias tree="tre"
(( $+commands[yazi] )) && alias n="yazi"

# ============= #
# Other aliases
# ============= #

# Print a human readable list of $PATH
# NOTE: <:> Split by colon
alias lspath='print -l "${(s<:>)PATH}" | nl'

# Reload the Zsh config
alias reload="exec $SHELL -i -l"
