#!/usr/bin/env bash

# FIX for WSL2 with high memory consumption
[ -z "$(ps -ef | grep cron | grep -v grep)" ] \
	&& sudo /etc/init.d/cron start &> /dev/null

# Add Windows' home path to environmental variables
export WIN_HOME="/mnt/c/Users/matka/"

# ==================
# SSH - Secure SHell
# ==================
# https://www.openssh.com/manual.html
# https://help.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh
# https://devblogs.microsoft.com/commandline/sharing-ssh-keys-between-windows-and-wsl-2/
#
# Start the ssh-agent when WSL starts
eval "$(keychain --eval --agents ssh xeho91)"

# ======================
# GPG - GnuPrivacy Guard
# ======================
# https://www.gnupg.org/documentation/manpage.html
# https://help.github.com/en/github/authenticating-to-github/generating-a-new-gpg-key
#
# Enable passphrase prompt
export GPG_TTY=$(tty)

# ===========
# zsh HISTORY
# ===========
# change path to zsh's history log file
HISTFILE=$HOME/.zsh_history
# the numbers of lines or commands that are stored
HISTSIZE=100000
SAVEHIST=100000
# Treat the '!' character specially during expansion
setopt BANG_HIST
# Write the history file in the ":start:elapsed;command" format
setopt EXTENDED_HISTORY
# Share history between all sessions
setopt SHARE_HISTORY
# Append to history file instead of overwriting
setopt APPEND_HISTORY
# Write to the history file immediately, not when the shell exits
setopt INC_APPEND_HISTORY
# Expire duplicate entries first when trimming history
setopt HIST_EXPIRE_DUPS_FIRST
# Don't record an entry that was just recorded again
setopt HIST_IGNORE_DUPS
# Delete old recorded entry if new entry is a duplicate
setopt HIST_IGNORE_ALL_DUPS
# Do not display a line previously found
setopt HIST_FIND_NO_DUPS
# Don't record an entry starting with a space
setopt HIST_IGNORE_SPACE
# Don't write duplicate entries in the history file
setopt HIST_SAVE_NO_DUPS
# Remove superfluous blanks before recording entry
setopt HIST_REDUCE_BLANKS
# Don't execute immediately upon history expansion
setopt HIST_VERIFY
# Beep when accessing nonexistent history
setopt HIST_BEEP

# ================================
# JQ - command line JSON processor
# ================================
# https://stedolan.github.io/jq/
#
# Configure colors
# https://stedolan.github.io/jq/manual/#Colors
# In this order: null, false, true, numbers, strings, arrays, objects
export JQ_COLORS="1;30:0;31:0;32:0;33:0;37:1;35:1;36"

# ================
# Custom functions
# ================
show_weather() { curl "http://wttr.in/$1"; }

# =======
# Aliases
# =======
source "$HOME/.dotfiles/.aliases"

# ==========================
# zinit - ZSH plugin manager
# ==========================
# https://github.com/zdharma/zinit
#
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
### End of Zinit's installer chunk
#
# A glance at the new for-syntax – load all of the above
# plugins with a single command. For more information see:
# https://zdharma.org/zinit/wiki/For-Syntax/
zinit for \
	light-mode zsh-users/zsh-autosuggestions \
	zdharma/fast-syntax-highlighting \
	zdharma/history-search-multi-word \
#
# Download the default profile
#
# diff-so-fancy
zinit ice wait"2" lucid as"program" pick"bin/git-dsf"
zinit load zdharma/zsh-diff-so-fancy
#
zinit wait lucid for \
	OMZP::colored-man-pages \
	OMZP::alias-finder \

# =============================
# Starship - cross-shell prompt
# =============================
# https://starship.rs/
# https://github.com/starship/starship
#
# Change terminal's tab title...
function set_terminal_tab_title() {
	echo -ne "\033]0;"
	# display opened file folder emoji
  	echo -ne "\U1F4C2"
 	# display current current folder (from current location)
 	echo -ne "${PWD##*/}"
	echo -ne "\007"
}
# ...and add it to pre-command functions
precmd_functions+=(set_terminal_tab_title)
# Import configuration file
export STARSHIP_CONFIG=~/.dotfiles/.starship.toml
# Initiate Starship prompt in zsh
eval "$(starship init zsh)"

# PLUGINS:
ZSH_ALIAS_FINDER_AUTOMATIC=true

 export PATH="/home/xeho91/.deno/bin:$PATH"

# ====================================================
# asdf-vm - multiple language runtime versions manager
# ====================================================
# https://asdf-vm.com/
#
# Initiate asdf
. $HOME/.asdf/asdf.sh
# Append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# Initialise completions with ZSH's compinit
autoload -Uz compinit
compinit

# =======================================================
# Color LS - colorizes the ls output with color and icons
# =======================================================
# https://github.com/athityakumar/colorls
#
# Enable tab completion for flags
source "$(dirname $(gem which colorls))/tab_complete.sh"
