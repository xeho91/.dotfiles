# ============================================================================ #
# Zsh Completion System configuration
# -----------------------------------
# http://zsh.sourceforge.net/Doc/Release/Completion-System.html#Completion-System-Configuration
# ============================================================================ #
#
# Provide a visual feedback when pressing completion (TAB⇥)
# http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Visual-effects
zstyle ':completion:*' format '%U%B%F{magenta}Possible completions for "%f%u%K{black}%d%k%U%F{magenta}":%u%f%b'
#
# Try filename completion as a default when other completions failed
# http://zsh.sourceforge.net/FAQ/zshfaq04.html
zstyle ':completion:*' completer _complete _ignored _files
#
# When running `compinstall` again, it lets `compinstall` find where it has
# written out `zstyle` statements last time. This way, is possible to run
# `compinstall` again to update them.
zstyle :compinstall filename '$DOTFILES/Zsh/.zshrc'
#
# Try to complete every partial directory name in the path entered and not just
# the first one
zstyle ':completion:*' list-suffixes true
#
# When there are two dirs 'nm' and 'node_modules' and with typing 'nm',
# it will never try to complete it to the latter
zstyle ':completion:*' accept-exact-dirs true
#
# Partial completion
# Typing 'cd /u/lo/b<TAB⇥>' becomes '/usr/local/bin'
# Typing 'cd ~/L/P/B<TAB⇥>' becomes '~/Library/Preferences/ByHost'
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' expand prefix suffix 

# =============================================================================
source "$ZDOTDIR/configurations/options.zsh"
# =============================================================================

# =============================================================================
# Booting / startup tasks
# =============================================================================

# Random fun distraction to kill the loading time
if type shuf > /dev/null; then
	cowfile="$(cowsay -l | sed "1 d" | tr ' ' '\n' | shuf -n 1)"
  else
	cowfiles=( $(cowsay -l | sed "1 d") );
	cowfile=${cowfiles[$(($RANDOM % ${#cowfiles[*]}))]}
fi
#
fortune | cowsay -f "$cowfile"

# GPG - GnuPrivacy Guard
# ----------------------
# https://www.gnupg.org/documentation/manpage.html
# https://help.github.com/en/github/authenticating-to-github/generating-a-new-gpg-key
#
# Enable passphrase prompt
export GPG_TTY=$(tty)

# # SSH - Secure Shell
# --------------------
# https://www.openssh.com/manual.html
# https://help.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh
#
# Start the ssh-agent on session start
eval "$(keychain --eval --agents ssh xeho91_rsa)"

# =============================================================================
# Zinit - plugin manager
# ----------------------
# https://github.com/zdharma/zinit
# =============================================================================

# Check if environment variable exists
if [ -z "$ZPLG_HOME" ]; then
	ZPLG_HOME="${ZHOMEDIR:-$HOME}/zinit"
fi

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
# Existing Linux commands improvements
# ------------------------------------
# NOTE:
# * `zinit load` -> causes reporting to be enabled – you can track what plugin
#					does, view the information with zinit report {plugin-spec}
#					and then also unload the plugin with `zinit unload`
#
# * `zinit light` -> significantly faster loading without tracking and
#					 reporting, by using which user resigns of the ability to
#					 view the plugin report and to unload information
# =============================================================================

# A `cat` clone with wings
# ------------------------
# https://github.com/sharkdp/bat
#
zinit ice as"program" from"gh-r" mv"bat* -> bat" pick"bat/bat"
zinit load sharkdp/bat
alias cat="bat"

# The next generation 'ls' command
# --------------------------------
# https://github.com/Peltoche/lsd
#
zinit ice as"program" from"gh-r" mv"lsd* -> lsd" pick"lsd/lsd"
zinit load Peltoche/lsd
alias ls="lsd"

# A next-generation 'cd' command with installed interactive filter
# ----------------------------------------------------------------
# https://github.com/b4b4r07/enhancd
#
zinit ice pick"init.sh"
zinit light b4b4r07/enhancd
export ENHANCD_DISABLE_DOT=1

# =============================================================================
# Zsh UX (User Experience) improvements
# =============================================================================

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

# Multi-word, syntax highlighted history searching for Zsh
# --------------------------------------------------------
# https://github.com/zdharma/history-search-multi-word
#
zinit ice wait lucid
zinit light zdharma/history-search-multi-word

# Collection of extension color mappings for LS_COLORS environment variable,
# displayed when using `ls`
# --------------------------------------------------------------------------
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

# Auto-close and delete matching delimiters in Zsh
# ------------------------------------------------
# https://github.com/hlissner/zsh-autopair
#
zinit ice wait lucid
zinit light hlissner/zsh-autopair

# =============================================================================
# Improving Git experience
# =============================================================================

# Git utilities as in extra commands added to `git`
# -------------------------------------------------
# https://github.com/tj/git-extras
zinit ice as"program" pick"$ZPFX/bin/git-*" make"PREFIX=$ZPFX"
zinit light tj/git-extras
zinit snippet OMZP::git-extras

# `gh` - GitHub's official command line tool
# ------------------------------------------
# https://github.com/cli/cli/
#
zinit ice from"gh-r" as"program" bpick"*.tar.gz" mv"gh*/bin/gh -> gh" \
	atload'gh completion --shell zsh > $ZINIT_DIR/completions/_gh'
zinit load cli/cli

# A utility tool powered by 'fzf' for using Git interactively
# -----------------------------------------------------------
# https://github.com/wfxr/forgit
#
zinit light wfxr/forgit

# Better, human readable Git diffs
# --------------------------------
# https://github.com/zdharma/zsh-diff-so-fancy
#
zinit ice wait"2" lucid as"program" pick"bin/git-dsf"
zinit load zdharma/zsh-diff-so-fancy

# =============================================================================
# Finders, filters, searchers
# =============================================================================

# `fzy` - simple, fast fuzzy finder for the terminal
# --------------------------------------------
# https://github.com/jhawthorn/fzy
zinit ice as"program" make
zinit light jhawthorn/fzy

# `fzf` - command-line fuzzy finder
# ---------------------------------
# https://github.com/junegunn/fzf
#
zinit ice wait lucid from"gh-r" as"program"
zinit load junegunn/fzf

# `rg` - recursively searching directories for a regex pattern with gitignore
# ---------------------------------------------------------------------------
# https://github.com/BurntSushi/ripgrep
#
zinit ice from"gh-r" as"program" bpick"*amd64.deb" mv"usr/bin/rg -> rg"
zinit light BurntSushi/ripgrep

# `fd` -  simple, fast and user-friendly alternative to `find`
# ------------------------------------------------------------
# https://github.com/sharkdp/fd
#
zinit ice from"gh-r" as"command" mv"fd* -> fd" pick"fd/fd"
zinit light sharkdp/fd
zinit ice as"completion"
zinit snippet OMZP::fd/_fd

# `peco` - simplistic interactive filtering tool
# -------------------------------------
# https://github.com/peco/peco
#
zinit ice from"gh-r" as"program" mv"peco* -> peco" pick"peco/peco";
zinit light peco/peco

# `fpp` - command line tool for selecting files out of bash output
# ----------------------------------------------------------------
# https://github.com/facebook/PathPicker
#
zinit ice as"program" cd"PathPicker/debian" atpull"./package.sh" \
	pick"facebook/PathPicker"
zinit light facebook/PathPicker

# =============================================================================
# Editors & readers
# =============================================================================

# `vim` (Vi iMproved) - Text editor program for UNIX
# --------------------------------------------------
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
export VIMRUNTIME=$HOME/.zinit/plugins/vim---vim/runtime
alias vi=vim

# `glow` - Terminal based markdown reader
# ---------------------------------------
# https://github.com/charmbracelet/glow
#
zinit ice from"gh-r" as"program" bpick"*.tar.gz"
zinit light charmbracelet/glow

# =============================================================================
# Help, documentationm, cheatsheets
# =============================================================================

# `navi` - Interactive cheatsheet tool for the command-line
#          and application launchers
# ---------------------------------------------------------
# https://github.com/denisidoro/navi
#
zinit ice from"gh-r" as"program" bpick"*linux*" mv"navi -> navi"
zinit light denisidoro/navi

# `tldr` - Collaborative cheatsheets for console commands
# -------------------------------------------------------
# https://github.com/tldr-pages/tldr
#
zinit ice as"program" pick"tldr tldr-lint" \
	atinit`cachedir=$HOME/.local/share/tldr \
		complete -W "$(q=($cachedir/*/*) \
		sed 's@\.md @ @g' <<<${q[@]##*/})" tldr`
zinit load pepa65/tldr-bash-client

# =============================================================================
# Other
# TODO: Organize & clean
# =============================================================================

# `exa` - modern replacement for `ls`
# -----------------------------------
# https://github.com/ogham/exa
#
zinit ice from"gh-r" as"program" mv"exa-* -> exa"
zinit light ogham/exa
zinit as"completion" mv"c* -> _exa" \
	for "https://github.com/ogham/exa/blob/master/completions/completions.zsh"

# Crowd-sourced code mentorship and practice, conversations about code
# --------------------------------------------------------------------
# https://exercism.io/
#
zinit ice from"gh-r" as"program" bpick"exercism-linux-64bit.tgz"
zinit light exercism/cli

# Quick access to files and directories, inspired by 'autojump', 'z' and 'v'
# --------------------------------------------------------------------------
# https://github.com/clvv/fasd
#
zinit ice as"program" pick"fasd" make"install"
zinit light clvv/fasd
eval "$(fasd --init auto)"

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

# n³ The unorthodox terminal file manager
# ---------------------------------------
# https://github.com/jarun/nnn
#
zinit ice as"program" make"O_NERD=1"
zinit light jarun/nnn

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

# =============================================================================
# Oh My Zsh (OMZ) - open source framework for managing Zsh configuration
# ----------------------------------------------------------------------
# https://github.com/ohmyzsh/ohmyzsh
# =============================================================================

# Functionalities (libary) from OMZ
# ---------------------------------
# https://github.com/ohmyzsh/ohmyzsh/tree/master/lib
#
zinit snippet OMZL::clipboard.zsh
zinit snippet OMZL::completion.zsh
zinit snippet OMZL::directories.zsh
zinit snippet OMZL::functions.zsh
zinit snippet OMZL::misc.zsh
zinit snippet OMZL::spectrum.zsh
zinit snippet OMZL::termsupport.zsh

# Plugins from OMZ
# ----------------
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins
#
zinit snippet OMZP::alias-finder; ZSH_ALIAS_FINDER_AUTOMATIC=true
zinit snippet OMZP::autojump
zinit snippet OMZP::colored-man-pages
zinit snippet OMZP::command-not-found
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

# =============================================================================
# Prompt
# =============================================================================

# Prompt theme with lots of features
# ----------------------------------
# https://github.com/romkatv/powerlevel10k
#
zinit ice depth=1
zinit light romkatv/powerlevel10k
# To customize prompt, run `p10k configure`
[[ ! -f $DOTFILES/Zsh/.p10k.zsh ]] || source $DOTFILES/Zsh/.p10k.zsh
#
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# ------------------------------------------------------------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Other
# Load & execute completions
autoload -Uz compinit
compinit
