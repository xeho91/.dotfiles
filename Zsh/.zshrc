# Random fun distraction to kill the loading time
# -----------------------------------------------
if type shuf > /dev/null; then
	cowfile="$(cowsay -l | sed "1 d" | tr ' ' '\n' | shuf -n 1)"
  else
	cowfiles=( $(cowsay -l | sed "1 d")  );
	cowfile=${cowfiles[$(($RANDOM % ${#cowfiles[*]}))]}
fi
#
fortune | cowsay -f "$cowfile"

# =============================================================================
# GPG - GnuPrivacy Guard
# ----------------------
# https://www.gnupg.org/documentation/manpage.html
# https://help.github.com/en/github/authenticating-to-github/generating-a-new-gpg-key
# =============================================================================
#
# Enable passphrase prompt
export GPG_TTY=$(tty)

# =============================================================================
# # SSH - Secure Shell
# --------------------
# https://www.openssh.com/manual.html
# https://help.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh
# =============================================================================
#
# Start the ssh-agent on session start
eval "$(keychain --eval --agents ssh xeho91_rsa)"

# =============================================================================
# Zsh (Z shell) configuration
# ---------------------------
# http://zsh.sourceforge.net/Doc/
# =============================================================================

# Changing directories options
# ----------------------------
# http://zsh.sourceforge.net/Doc/Release/Options.html#Changing-Directories
#
# Use the shorthand `~` for `cd ~`
setopt AUTO_CD
#
# Keep a directory stack of all the directories you cd to in a session
setopt AUTO_PUSHD
#
# Push multiple copies of the same directory onto the directory stack
unsetopt PUSHD_IGNORE_DUPS
#
# Use Git-like `-N` instead of the default `+N`
# (e.g. `cd -2` as opposed to `cd +2`)
setopt PUSHD_MINUS

# Completion options
# ------------------
# http://zsh.sourceforge.net/Doc/Release/Options.html#Completion-4
#
# Move the cursor to the end of the word after accepting a completion
setopt ALWAYS_TO_END
#
# TAB⇥ to show a menu of all completion suggestions. TAB⇥ a second time
# to enter the menu. TAB⇥ again to circulate through the list, or use
# the arrow keys. ENTER to accept a completion from the menu.
setopt AUTO_MENU
#
# If you type TAB⇥ in the middle of a word, the cursor will move to the end
# of the word and zsh will open the completions menu.
# (I.e. type `add`, hit LEFT←, # and then TAB⇥, the cursor will move to
# after the second `d` and completions will be shown for add)
setopt COMPLETE_IN_WORD
#
# Disables the use of ⌃S to stop terminal output and the use of ⌃Q to resume it
unsetopt FLOW_CONTROL
#
# This option prevents the completion menu from showing
# even if AUTO_MENU is set
unsetopt MENU_COMPLETE

# History options
# ---------------
# http://zsh.sourceforge.net/Doc/Release/Options.html#History
#
# Path to zsh's history log file
export HISTFILE=$HOME/.zsh_history
#
# Number of lines or commands that:
# (a) are allowed in the history file at startup time of a session,
# (b) are stored in the history file at the end of your bash session for use
#     in future sessions
export HISTFILESIZE=1000000
#
# Number of commands that are loaded into memory from the history file
export HISTSIZE=1000000
#
# Number of commands that are stored in the zsh history file
export SAVEHIST=1000000
#
# Append to history file instead of overwriting
setopt APPEND_HISTORY
#
# Treat the '!' character specially during expansion
setopt BANG_HIST
#
# Write the history file in the ":start:elapsed;command" format
setopt EXTENDED_HISTORY
#
# Beep when accessing nonexistent history
setopt HIST_BEEP
#
# Expire duplicate entries first when trimming history
setopt HIST_EXPIRE_DUPS_FIRST
#
# Do not display a line previously found
setopt HIST_FIND_NO_DUPS
#
# Delete old recorded entry if new entry is a duplicate
setopt HIST_IGNORE_ALL_DUPS
#
# Don't record an entry that was just recorded again
setopt HIST_IGNORE_DUPS
#
# Don't record an entry starting with a space
setopt HIST_IGNORE_SPACE
#
# Remove superfluous blanks before recording entry
setopt HIST_REDUCE_BLANKS
#
# Don't write duplicate entries in the history file
setopt HIST_SAVE_NO_DUPS
#
# Don't execute immediately upon history expansion
setopt HIST_VERIFY
#
# Write to the history file immediately, not when the shell exits
setopt INC_APPEND_HISTORY
#
# Share history between all sessions
setopt SHARE_HISTORY

# Prompting options
# ----------------
# http://zsh.sourceforge.net/Doc/Release/Options.html#Prompting
#
# Adds support for command substitution
setopt PROMPT_SUBST

# Zsh Completion System configuration
# -----------------------------------
# http://zsh.sourceforge.net/Doc/Release/Completion-System.html#Completion-System-Configuration
#
zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '/home/xeho91/.zshrc'
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix 
#
autoload -Uz compinit
compinit

# =============================================================================
# Zinit - plugin manager
# ----------------------
# https://github.com/zdharma/zinit
# =============================================================================

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi
#
source "$HOME/.zinit/bin/zinit.zsh"
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

# =============================================================================
# Plugins & Tools & Programs
# =============================================================================

# Multi-word, syntax highlighted history searching for Zsh
# --------------------------------------------------------
# https://github.com/zdharma/history-search-multi-word
#
zinit ice wait lucid
zinit light zdharma/history-search-multi-word

# Syntax highlighting for commands in Zsh
# ---------------------------------------
# https://github.com/zdharma/fast-syntax-highlighting
# -
# Additional completion definitions for Zsh
# -----------------------------------------
# https://github.com/zsh-users/zsh-completions
# -
# Suggestion of commands as you type based on completions and history
# -------------------------------------------------------------------
# https://github.com/zsh-users/zsh-autosuggestions
#
zinit wait lucid for \
	atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
	zdharma/fast-syntax-highlighting \
	blockf \
	zsh-users/zsh-completions \
	atload"!_zsh_autosuggest_start" \
	zsh-users/zsh-autosuggestions

# A command-line fuzzy finder
# ---------------------------
# https://github.com/junegunn/fzf
#
zinit ice wait lucid from"gh-r" as"program"
zinit light junegunn/fzf

# A simple, fast and user-friendly alternative to 'find'
# ------------------------------------------------------
# https://github.com/sharkdp/fd
#
zinit ice as"command" from"gh-r" mv"fd* -> fd" pick"fd/fd"
zinit light sharkdp/fd
zinit ice as"completion"
zinit snippet OMZP::fd/_fd

# A 'cat' clone with wings
# ------------------------
# https://github.com/sharkdp/bat
#
zinit ice as"command" from"gh-r" mv"bat* -> bat" pick"bat/bat"
zinit light sharkdp/bat
alias cat="bat"

# The next generation 'ls' command
# --------------------------------
# https://github.com/Peltoche/lsd
#
zinit ice as"program" from"gh-r" mv"lsd* -> lsd" pick"lsd/lsd"
zinit light Peltoche/lsd
alias ls="lsd"

# A modern replacement for 'ls'
# ----------------------------
# https://github.com/ogham/exa
#
zinit ice from"gh-r" as"program" mv"exa-* -> exa"
zinit light ogham/exa
zinit as"completion" mv"c* -> _exa" \
	for "https://github.com/ogham/exa/blob/master/completions/completions.zsh"

# Terminal based markdown reader
# ------------------------------
# https://github.com/charmbracelet/glow
#
zinit ice from"gh-r" as"program" bpick"*.tar.gz"
zinit light charmbracelet/glow

# Text editor program for UNIX - improved version of Vi
# -----------------------------------------------------
# https://github.com/vim/vim/
#
zinit ice as"program" \
	atclone"rm -f src/auto/config.cache; \
			./configure \
				--with-features=huge \
				--enable-gui=auto \
				--enable-multibyte \
				--enable-gtk2-check \
				--enable-wcsope \
				--with-x \
				--prefix=/usr/local \
				--with-python3-config-dir=$(python3-config --configdir) \
				--enable-pythoninterp=yes \
				--enable-python3interp=yes \
				--enable-luainterp=yes \
				--enable-rubyinterp=yes \
				--enable-perlinterp=yes \
				--disable-arabic \
				--enable-fail-if-missing" \
	atpull"%atclone" make pick"src/vim"
zinit light vim/vim
export VIMRUNTIME=~/.zinit/plugins/vim---vim/runtime
alias vi=vim

# 'rg' recursively searching directories for a regex pattern with gitignore
# -------------------------------------------------------------------------
# https://github.com/BurntSushi/ripgrep
#
zinit ice from"gh-r" as"program" bpick"*amd64.deb" mv"usr/bin/rg -> rg"
zinit light BurntSushi/ripgrep

# Interactive cheatsheet tool for the command-line and application launchers
# --------------------------------------------------------------------------
# https://github.com/denisidoro/navi
#
zinit ice from"gh-r" as"program" bpick"*linux*" mv"navi -> navi"
zinit light denisidoro/navi

# Crowd-sourced code mentorship and practice, conversations about code
# --------------------------------------------------------------------
# https://exercism.io/
#
zinit ice from"gh-r" as"program" bpick"exercism-linux-64bit.tgz"
zinit light exercism/cli

# GitHub's official command line tool
# -----------------------------------
# https://github.com/cli/cli/
#
zinit ice from"gh-r" as"program" bpick"*.tar.gz" mv"gh*/bin/gh -> gh"
zinit load cli/cli

# Quick access to files and directories, inspired by 'autojump', 'z' and 'v'
# --------------------------------------------------------------------------
# https://github.com/clvv/fasd
#
zinit ice as"program" pick"fasd" make"install"
zinit light clvv/fasd
eval "$(fasd --init auto)"

# Collection of extension:color mappings for LS_COLORS environment variable
# -------------------------------------------------------------------------
# https://github.com/trapd00r/LS_COLORS
zinit ice atclone"dircolors -b LS_COLORS > c.zsh" atpull"%atclone" pick"c.zsh"
zinit ice wait"0c" lucid reset \
	atclone"local P=${${(M)OSTYPE:#*darwin*}:+g}
				\${P}sed -i \
				'/DIR/c\DIR 38;5;63;1' LS_COLORS; \
			\${P}dircolors -b LS_COLORS > c.zsh" \
	atpull'%atclone' pick"c.zsh" nocompile'!' \
	atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zinit light trapd00r/LS_COLORS

# A next-generation 'cd' command with installed interactive filter
# ----------------------------------------------------------------
# https://github.com/b4b4r07/enhancd
#
zinit ice pick"init.sh"
zinit light b4b4r07/enhancd
export ENHANCD_DISABLE_DOT=1

# A utility tool powered by 'fzf' for using Git interactively
# -----------------------------------------------------------
# https://github.com/wfxr/forgit
#
zinit light wfxr/forgit

# Auto-close and delete matching delimiters in Zsh
# ------------------------------------------------
# https://github.com/hlissner/zsh-autopair
#
zinit ice wait lucid
zinit light hlissner/zsh-autopair

# Prompt theme with lots of features
# ----------------------------------
# https://github.com/romkatv/powerlevel10k
#
zinit ice depth=1
zinit light romkatv/powerlevel10k
# To customize prompt, run `p10k configure`
[[ ! -f $DOTFILES/Zsh/.p10k.zsh ]] || source $DOTFILES/Zsh/.p10k.zsh

# 'fpp' - command line tool for selecting files out of bash output
# ----------------------------------------------------------------
# https://github.com/facebook/PathPicker
#
zinit ice as"program" cd"PathPicker/debian" atpull"./package.sh" \
	pick"facebook/PathPicker"
zinit light facebook/PathPicker

# Yank terminal output to clipboard
# ---------------------------------
# https://github.com/mptre/yank
#
zinit ice as"program" pick"yank" make
zinit light mptre/yank

# Extendable version manager
# --------------------------
# https://github.com/asdf-vm/asdf
#
zinit load asdf-vm/asdf

# command line tool to highlight terms
# ------------------------------------
# https://github.com/paoloantinori/hhighlighter
#
zinit ice pick"h.sh"
zinit light paoloantinori/hhighlighter

# Better, human readable Git diffs
# --------------------------------
# https://github.com/zdharma/zsh-diff-so-fancy
#
zinit ice wait"2" lucid as"program" pick"bin/git-dsf"
zinit load zdharma/zsh-diff-so-fancy

# n³ The unorthodox terminal file manager
# ---------------------------------------
# https://github.com/jarun/nnn
#
zinit ice as"program" make"O_NERD=1"
zinit light jarun/nnn

# A simple, fast fuzzy finder for the terminal
# --------------------------------------------
# https://github.com/jhawthorn/fzy
zinit ice as"program" make
zinit light jhawthorn/fzy

# Simplistic interactive filtering tool
# -------------------------------------
# https://github.com/peco/peco
#
zinit ice as"program" from"gh-r" mv"peco* -> peco" pick"peco/peco";
zinit light peco/peco

# Jump back to a specific directory, without doing `cd ../../..`
# --------------------------------------------------------------
# https://github.com/Tarrasch/zsh-bd
#
zinit light Tarrasch/zsh-bd

# Command-line JSON processor
# ---------------------------
# https://github.com/stedolan/jq
#
zinit ice as"program" from"gh-r" mv"jq* -> jq"
zinit light stedolan/jq
#
# Colors configuration
# https://stedolan.github.io/jq/manual/#Colors
# In this order: null, false, true, numbers, strings, arrays, objects
export JQ_COLORS="1;30:0;31:0;32:0;33:0;37:1;35:1;36"

# Git utilities
# -------------
# https://github.com/tj/git-extras
zinit ice as"program" pick"$ZPFX/bin/git-*" make"PREFIX=$ZPFX"
zinit light tj/git-extras

# =============================================================================
# Oh My Zsh (OMZ) - open source framework for managing Zsh configuration
# ----------------------------------------------------------------------
# https://github.com/ohmyzsh/ohmyzsh
# =============================================================================

# Plugins from OMZ
# ----------------
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins
#
zinit snippet OMZP::alias-finder
zinit snippet OMZP::autojump
zinit snippet OMZP::colored-man-pages
zinit snippet OMZP::command-not-found
zinit snippet OMZP::git-extras
zinit snippet OMZP::gitignore
zinit snippet OMZP::jira
zinit snippet OMZP::jsontools
zinit snippet OMZP::last-working-dir
zinit snippet OMZP::node
zinit ice as"completion"; zinit snippet OMZP::pip/_pip
zinit snippet OMZP::thefuck
zinit snippet OMZP::tmux
zinit snippet OMZP::vi-mode
zinit snippet OMZP::web-search

# Functionalities (libary) from OMZ
# ---------------------------------
# https://github.com/ohmyzsh/ohmyzsh/tree/master/lib
#
zinit snippet OMZL::clipboard.zsh
zinit snippet OMZL::correction.zsh
zinit snippet OMZL::directories.zsh
zinit snippet OMZL::functions.zsh
zinit snippet OMZL::history.zsh
zinit snippet OMZL::misc.zsh
zinit snippet OMZL::spectrum.zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# ------------------------------------------------------------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# =============================================================================
# Other
# =============================================================================
#
