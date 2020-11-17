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

# Appending additional path for manpages, because some plugins install it under
# `share` directory
unset MANPATH
export MANPATH=:"$(manpath):$ZPFX/share/man"

# =========================================================================== #
# Sourcing (loading configurations) files
# =========================================================================== #
source "$ZSH_CONFIG[PLUGINS_DIR]/programming_languages.zsh"
source "$ZSH_CONFIG[PLUGINS_DIR]/searchers.zsh"
source "$ZSH_CONFIG[PLUGINS_DIR]/interactive_filters.zsh"
source "$ZSH_CONFIG[PLUGINS_DIR]/tools.zsh"
source "$ZSH_CONFIG[PLUGINS_DIR]/commands_improvements.zsh"
source "$ZSH_CONFIG[PLUGINS_DIR]/zsh_improvements.zsh"
source "$ZSH_CONFIG[PLUGINS_DIR]/git_improvements.zsh"
source "$ZSH_CONFIG[PLUGINS_DIR]/productivity_improvements.zsh"
source "$ZSH_CONFIG[PLUGINS_DIR]/oh_my_zsh.zsh"
source "$ZSH_CONFIG[PLUGINS_DIR]/easter_eggs.zsh"
source "$ZSH_CONFIG[PLUGINS_DIR]/cheatsheets.zsh"
source "$ZSH_CONFIG[PLUGINS_DIR]/recorders.zsh"

