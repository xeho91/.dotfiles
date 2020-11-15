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
alias -s md="glow"

