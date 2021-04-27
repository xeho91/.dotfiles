# =========================================================================== #
# Aliases for existing Linux commands
# =========================================================================== #
alias cls="clear"
alias open="xdg-open"
alias :q="exit"

# =========================================================================== #
# Aliases for installed programs
# =========================================================================== #
(( $+commands[nvim] )) && alias vim="nvim"
(( $+commands[bat] )) && alias cat="bat"
(( $+commands[lsd] )) && alias ls="lsd -a"
(( $+commands[bat] )) && alias cat="bat"
(( $+commands[procs] )) && alias ps="procs"
(( $+commands[tre] )) && alias tree="tre"
(( $+commands[nnn] )) && alias n="nnn"
(( $+commands[exa] )) && alias exa="exa --git --all --long --icons --header"
(( $+commands[trans] )) && alias trman="trans :zh-TW"
(( $+commands[dust] )) && alias du="dust"
(( $+commands[btm] )) && alias btm="btm --battery --color=gruvbox"
(( $+commands[grex] )) && alias grex="grex --colorize --verbose"

# =========================================================================== #
# Make these commands always verbose for a feedback of what happened
# =========================================================================== #
alias mkdir="mkdir -v"
alias rmdir="rmdir -v"

# =========================================================================== #
# Print a human readable list of $PATH
# =========================================================================== #
# <:> Split by colon
alias list_path='print -l "${(s<:>)PATH}" | nl'

# =========================================================================== #
# Reload the Zsh configurations
# =========================================================================== #
alias reload="exec $SHELL -i -l"

# =========================================================================== #
# Suffix aliases (set default program to open files with specifed extension)
# =========================================================================== #
declare -a extensions=("md" "txt")
for extension in $extensions; do
	if (( $+commands[glow] )); then
		alias -s "$extension"="glow --pager"
	else
		alias -s $extension="cat --color=auto | less"
	fi
done
unset extensions extension

# =========================================================================== #
# Aliases for existing functions
# =========================================================================== #
if [[ editor_open_file && ($EDITOR -eq "vim" || $EDITOR -eq "nvim") ]]; then
	alias vo="editor_open_file"
fi

