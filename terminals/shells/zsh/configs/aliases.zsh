# =========================================================================== #
# Aliases for existing Linux commands
# =========================================================================== #
alias cls="clear"
# [[ $IS_MACOS != true ]] && alias open="xdg-open"
alias :q="exit"

# =========================================================================== #
# Aliases for installed programs
# =========================================================================== #
(( $+commands[bat] )) && alias cat="bat"
(( $+commands[btm] )) && alias btm="btm --battery --color=gruvbox"
(( $+commands[dust] )) && alias du="dust"
(( $+commands[exa] )) && alias exa="exa --git --all --long --icons --header"
(( $+commands[git] )) && alias sos="git add . && git wip"
(( $+commands[gitui] )) && alias gu="gitui"
(( $+commands[gpg-tui] )) && alias gpg-tui="gpg-tui --style=colored"
(( $+commands[grex] )) && alias grex="grex --colorize --verbose"
(( $+commands[lazygit] )) && alias lz="lazygit"
(( $+commands[lsd] )) && alias ls="lsd -a"
(( $+commands[neomutt] )) && alias mutt="neomutt"
(( $+commands[nnn] )) && alias n="yazi"
(( $+commands[nvim] )) && alias vim="nvim"
(( $+commands[procs] )) && alias ps="procs"
(( $+commands[trans] )) && alias trman="trans :zh-TW"
(( $+commands[tre] )) && alias tree="tre"
# GitHub CLI related
(( $+commands[gh] )) && alias mdp="gh markdown-preview --verbose --dark-mode --disable-auto-open"

if [[ $MACOS == true ]]; then
	alias git="/usr/local/bin/git"
fi

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
