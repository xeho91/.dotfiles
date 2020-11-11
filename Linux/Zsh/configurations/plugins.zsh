# =========================================================================== #
# Zinit - plugin manager
# ----------------------
# https://github.com/zdharma/zinit
# =========================================================================== #

# Configration of paths for Zinit and its options
declare -A ZINIT
ZINIT[HOME_DIR]="$ZDOTDIR/.zinit"
ZINIT[BIN_DIR]="$ZINIT[HOME_DIR]/bin"
ZINIT[PLUGINS_DIR]="$ZINIT[HOME_DIR]/plugins"
ZINIT[COMPLETIONS_DIR]="$ZINIT[HOME_DIR]/completions"
ZINIT[SNIPPETS_DIR]="$ZINIT[HOME_DIR]/snippets"
# ZINIT[ZCOMPDUMP_PATH]="$ZDOTDIR"
ZINIT[COMPINIT_OPTS]="-C"
ZINIT[MUTE_WARNINGS]=0
ZINIT[OPTIMIZE_OUT_DISK_ACCESSES]=0

### Added by Zinit's installer
if [[ ! -f $ZINIT[HOME_DIR]/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$ZINIT[HOME_DIR]" && command chmod g-rwX "$ZINIT[HOME_DIR]"
    command git clone https://github.com/zdharma/zinit "$ZINIT[HOME_DIR]/bin" && \
		print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
		print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$ZINIT[HOME_DIR]/bin/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node
### End of Zinit's installer chunk

# Adding additional path for manpages, because some plugins install it under
# `share` directory
export MANPATH=$ZPFX/share/man:$(manpath)

# =========================================================================== #
# Sourcing (loading configurations) files
# =========================================================================== #
source "$ZSH_CONFIG[PLUGINS_DIR]/ux_improvements.zsh"
source "$ZSH_CONFIG[PLUGINS_DIR]/interactive_filters.zsh"
source "$ZSH_CONFIG[PLUGINS_DIR]/commands_improvements.zsh"
source "$ZSH_CONFIG[PLUGINS_DIR]/git_improvements.zsh"
source "$ZSH_CONFIG[PLUGINS_DIR]/productivity_improvements.zsh"
source "$ZSH_CONFIG[PLUGINS_DIR]/oh_my_zsh.zsh"
source "$ZSH_CONFIG[PLUGINS_DIR]/helpers.zsh"
source "$ZSH_CONFIG[PLUGINS_DIR]/easter_eggs.zsh"















# =========================================================================== #
# `rg` - recursively searching directories for a regex pattern with gitignore
# ---------------------------------------------------------------------------
# https://github.com/BurntSushi/ripgrep
# =========================================================================== #
# zinit ice from"gh-r" as"program" bpick"*amd64.deb" mv"usr/bin/rg -> rg"
# zinit light BurntSushi/ripgrep
# `fpp` - command line tool for selecting files out of bash output
# ----------------------------------------------------------------
# https://github.com/facebook/PathPicker
#
# zinit ice as"program" cd"PathPicker/debian" atpull"./package.sh" \
#     pick"facebook/PathPicker"
# zinit light facebook/PathPicker

# =============================================================================
# Editors & readers
# =============================================================================
#
# `glow` - Terminal based markdown reader
# ---------------------------------------
# https://github.com/charmbracelet/glow
#
# zinit ice from"gh-r" as"program" bpick"*.tar.gz"
# zinit light charmbracelet/glow

# =============================================================================
# Help, documentationm, cheatsheets
# =============================================================================

# =============================================================================
# Other
# TODO: Organize & clean
# =============================================================================

# Crowd-sourced code mentorship and practice, conversations about code
# --------------------------------------------------------------------
# https://exercism.io/
#
# zinit ice from"gh-r" as"program" bpick"exercism-linux-64bit.tgz"
# zinit light exercism/cli

# Quick access to files and directories, inspired by 'autojump', 'z' and 'v'
# --------------------------------------------------------------------------
# https://github.com/clvv/fasd
#
# zinit ice as"program" pick"fasd" make"install"
# zinit light clvv/fasd
# eval "$(fasd --init auto)"

# Yank terminal output to clipboard
# ---------------------------------
# https://github.com/mptre/yank
#
# zinit ice as"program" pick"yank" make
# zinit light mptre/yank

# Extendable version manager
# --------------------------
# https://github.com/asdf-vm/asdf
#
# zinit load asdf-vm/asdf

# command line tool to highlight terms
# ------------------------------------
# https://github.com/paoloantinori/hhighlighter
#
# zinit ice pick"h.sh"
# zinit light paoloantinori/hhighlighter

# n³ The unorthodox terminal file manager
# ---------------------------------------
# https://github.com/jarun/nnn
#
# zinit ice as"program" make"O_NERD=1"
# zinit light jarun/nnn

# Jump back to a specific directory, without doing `cd ../../..`
# --------------------------------------------------------------
# https://github.com/Tarrasch/zsh-bd
#
# zinit light Tarrasch/zsh-bd

# Command-line JSON processor
# ---------------------------
# https://github.com/stedolan/jq
#
# zinit ice as"program" from"gh-r" mv"jq* -> jq"
# zinit light stedolan/jq
#
# Colors configuration
# https://stedolan.github.io/jq/manual/#Colors
# In this order: null, false, true, numbers, strings, arrays, objects
# export JQ_COLORS="1;30:0;31:0;32:0;33:0;37:1;35:1;36"




# Plugins from OMZ
# ----------------
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins
#
# zinit snippet OMZP::autojump
# zinit snippet OMZP::gitignore
# zinit snippet OMZP::jira
# zinit snippet OMZP::jsontools
# zinit snippet OMZP::node
# zinit ice as"completion"; zinit snippet OMZP::pip/_pip
# zinit snippet OMZP::thefuck
# zinit snippet OMZP::tmux
# zinit snippet OMZP::vi-mode
# zinit snippet OMZP::web-search

