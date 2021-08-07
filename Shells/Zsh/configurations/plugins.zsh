# ======================================================================== #
# `git-extras` - Git utilities as in extra commands added to `git`
# ----------------------------------------------------------------
# https://github.com/tj/git-extras
# -----
# USES: Shell
# MANPAGE(s): Yes
# Completions: Yes
# NOTE: Completions will work AFTER loading `zsh-history-search-multiword`
# ======================================================================== #
zinit id-as"git-extras" \
	has"git" \
	if'[[ "$USER_MODE" == "developer" ]]' \
	make"PREFIX=$ZPFX" \
	pick"$ZPFX/bin/git-*" \
	as"program" \
	src"etc/git-extras-completion.zsh" \
	wait"2" lucid \
	for @tj/git-extras

# ======================================================================== #
# `git extra commands' - Collection of Git utilities
#                        and useful extra scripts
# -----------------------------------------------
# https://github.com/unixorn/git-extra-commands
# -----
# USES: Shell Python Ruby Perl
# MANPAGE(s): No
# Completions: Bugged
# FIXME: Completions collides with git-extras completions
# ======================================================================== #
#zinit id-as"git-extra-commands" \
#	has"git" \
#	pick"bin/git*" \
#	as"program" \
#	src"git-extra-commands.plugin.zsh" \
#	wait"2" lucid \
#	for @unixorn/git-extra-commands

# ======================================================================== #
# `git flow` - AVH Edition of the Git extensions to provide high-level
#              repository operations for Vincent Driessen's branching model
# -------------------------------------------------------------------------
# https://nvie.com/posts/a-successful-git-branching-model/
# https://github.com/petervanderdoes/gitflow-avh
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git-flow-avh
# -----
# USES: Shell
# MANPAGE(s): No
# Completions: Yes
# ======================================================================== #
zinit id-as"git-flow" \
	has"git" \
	if'[[ "$USER_MODE" == "developer" ]]' \
	make"prefix=$ZPFX install" \
	pick"$ZPFX/bin/git-flow*" \
	as"program" \
	wait"0a" lucid \
	for @petervanderdoes/gitflow-avh
zinit \
	has"git-flow" \
	wait"0b" lucid \
	for OMZP::git-flow-avh

# ======================================================================== #
# `git-recall` - an interactive way to peruse Git history from the terminal
# -------------------------------------------------------------------------
# https://github.com/Fakerr/git-recall
# -----
# USES: Shell
# MANPAGE(s): No
# Completions: No
# ======================================================================== #
zinit id-as"git-recall" \
	has"git" \
	if'[[ "$USER_MODE" == "developer" ]]' \
	make"PREFIX=$ZPFX install" \
	pick"$ZPFX/bin/git-recall" \
	as"program" \
	for @Fakerr/git-recall

# ======================================================================== #
# `git open` - open the GitHub page or website for a repo in a browser
# --------------------------------------------------------------------
# https://github.com/paulirish/git-open
# -----
# USES: Shell
# MANPAGE(s): Yes
# Completions: No
# ======================================================================== #
zinit id-as"git-open" \
	has"git" \
	if'[[ -v "$DISPLAY" ]] && [[ "$USER_MODE" == "developer" ]]' \
	cp"git-open.1 $ZPFX/man/man1" \
	for @aulirish/git-open

# ======================================================================== #
# `git recent` - see latest local Git branches, formatted real fancy
# ------------------------------------------------------------------
# https://github.com/paulirish/git-recent
# -----
# USES: Shell
# MANPAGE(s): No
# Completions: No
# ======================================================================== #
zinit id-as"git-recent" \
	has"git" \
	if'[[ "$USER_MODE" == "developer" ]]' \
	pick"git-recent" \
	as"program" \
	for @paulirish/git-recent

# ======================================================================== #
# `git my` - Lists a user's remote branches and shows
#            if it was merged and/or available locally
# ----------------------------------------------------
# https://github.com/davidosomething/git-my
# -----
# USES: Shell
# MANPAGE(s): No
# Completions: No
# ======================================================================== #
zinit id-as"git-my" \
	has"git" \
	if'[[ "$USER_MODE" == "developer" ]]' \
	pick"git-my" \
	as"program" \
	for @davidosomething/git-my

# ======================================================================== #
# `git quick-stats` - Git quick statistics is a simple and efficient way
#                     to access various statistics in Git repository
# ------------------------------------------------------------------
# https://github.com/arzzen/git-quick-stats
# -----
# USES: Shell
# MANPAGE(s): Yes
# Completions: No
# ======================================================================== #
zinit id-as"git-quick-stats" \
	has"git" \
	if'[[ "$USER_MODE" == "developer" ]]' \
	make"PREFIX=$ZPFX install" \
	for @arzzen/git-quick-stats

# ======================================================================== #
# A utility tool powered by 'fzf' for using Git interactively
# -----------------------------------------------------------
# https://github.com/wfxr/forgit
# -----
# USES: Shell
# MANPAGE(s): No
# Completions: No
# ======================================================================== #
zinit id-as"forgit" \
	has"git" \
	if'[[ "$USER_MODE" == "developer" ]]' \
	has="fzf" \
	as"program" \
	for https://github.com/wfxr/forgit/blob/master/forgit.plugin.zsh

# # =========================================================================== #
# # Spotify for the terminal
# # ------------------------
# # https://github.com/Rigellute/spotify-tui
# # -----
# # USES: Rust
# # MANPAGE(s): No
# # COMPLETIONS: Yes
# # =========================================================================== #
# zinit id-as"spotify-tui" \
# 	from"gh-r" \
# 	if'[[ "$USER_MODE" == "developer" ]]' \
# 	atclone"./spt --completions zsh > _spt" \
# 	pick"spt" \
# 	as"program" \
# 	wait"1" lucid \
# 	for @Rigellute/spotify-tui

# =========================================================================== #
# `lolcat` - rainbow and unicorns
# -------------------------------
# https://github.com/jaseg/lolcat
# -----
# USES: C
# MANPAGE(s): No
# COMPLETIONS: No
# =========================================================================== #
zinit id-as"lolcat" \
	nocompile \
	if'[[ "$USER_MODE" == "developer" ]]' \
	make"DESTDIR=$ZPFX/bin install" \
	for @jaseg/lolcat

# =========================================================================== #
# `boxes` - boxes with fancy shapes
# ---------------------------------
# https://github.com/ascii-boxes/boxes
# -----
# USES: C
# MANPAGE(s): Yes
# COMPLETIONS: No
# =========================================================================== #
zinit id-as"boxes" \
	if'[[ "$USER_MODE" == "developer" ]]' \
	nocompile \
	make!!'GLOBALCONF=boxes/boxes-config build' \
	cp"doc/boxes.1 $ZPFX/share/man/man1" \
	atclone"cp boxes-config $XDG_CONFIG_HOME" \
	atpull"%atclone" \
	pick"src/boxes" \
	as"program" \
	atload'export BOXES="$XDG_CONFIG_HOME/boxes-config"' \
	for @ascii-boxes/boxes

# =========================================================================== #
# `hacker-laws-cli` - Laws, Theories, Principles and Patterns that developers
#                     will find useful #hackerlaws
# ------------------------------------------------
# https://github.com/umutphp/hacker-laws-cli
# -----
# USES: Go
# MANPAGE(s): No
# COMPLETIONS: No
# =========================================================================== #
zinit id-as"hacker-laws-cli" \
	has"go" \
	if'[[ "$USER_MODE" == "developer" ]]' \
	nocompile \
	atclone'go build' \
	atpull"%atclone" \
	pick"hacker-laws-cli" \
	as"program" \
	for @umutphp/hacker-laws-cli

# =============================================================================
# Oh My Zsh (OMZ) - open source framework for managing Zsh configuration
# ----------------------------------------------------------------------
# https://github.com/ohmyzsh/ohmyzsh
# ============================================================================

# Add path for caching the selected functionalities from OMZ
export ZSH_CACHE_DIR="$XDG_CACHE_HOME/oh-my-zsh"

# ----------------------------------------------------------------------
# Functionalities (libary) from OMZ
# ---------------------------------
# https://github.com/ohmyzsh/ohmyzsh/tree/master/lib
# ----------------------------------------------------------------------

# Clipboard
zinit \
 	if'[[ -n "$DISPLAY" ]] && [[ "$USER_MODE" == "developer" ]]' \
	wait lucid \
	for OMZL::clipboard.zsh

# Completions
zinit \
	atload'export COMPLETION_WAITING_DOTS=true' \
	wait lucid \
	for OMZL::completion.zsh

# Correction
zinit \
	atload'export ENABLE_CORRECTION=true' \
	wait lucid \
	for OMZL::correction.zsh

# Directories
zinit \
	wait lucid \
	for OMZL::directories.zsh

# Improving `grep`
zinit \
	wait lucid \
	for OMZL::grep.zsh

# Key bindings (based on emacs)
#zinit \
#	wait lucid \
#	for OMZL::key-bindings.zsh

# Termninal support (setting terminal window tab/icon title)
zinit \
	if'[[ "$USER_MODE" == "developer" ]]' \
	wait lucid \
	for OMZL::termsupport.zsh

# -------------------------------------------------------------------------- #
# Plugins from OMZ
# ----------------
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins
# -------------------------------------------------------------------------- #

# =========================================================================== #
# `urlencode` and `urldecode`
# ---------------------------
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/urltools
# =========================================================================== #
zinit \
	if'[[ "$USER_MODE" == "developer" ]]' \
	wait lucid \
	for OMZP::urltools

# =========================================================================== #
# `web_search` add aliases for searching popular services
# ---------------------------
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/web-search
# =========================================================================== #
zinit \
	if'[[ "$USER_MODE" == "developer" ]]' \
	atinit'ZSH_WEB_SEARCH_ENGINES=(reddit "https://www.reddit.com/search/?q=")' \
	wait lucid \
	for OMZP::web-search

# =========================================================================== #
# `encode64` and `decode64`
# -------------------------
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/encode64/
# =========================================================================== #
zinit \
	if'[[ "$USER_MODE" == "developer" ]]' \
	wait lucid \
	for OMZP::encode64

# =========================================================================== #
# `extract` - unpack archives without remembering
# -----------------------------------------------
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/extract
# =========================================================================== #
zinit \
	if'[[ "$USER_MODE" == "developer" ]]' \
	wait"0a" lucid \
	for OMZP::extract
zinit \
	has"extract" \
	if'[[ "$USER_MODE" == "developer" ]]' \
	as"completion" \
	wait"0b" lucid \
	for OMZP::extract/_extract

# =========================================================================== #
# `ctrl + z` to back to vim (in backgroung proces) instead of `fg`
# ----------------------------------------------------------------
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/fancy-ctrl-z
# =========================================================================== #
zinit \
	wait lucid \
	for OMZP::fancy-ctrl-z

# =========================================================================== #
# Completions for `npm` - Node Package Manager
# ----------------------------------------------------------
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/npm
# =========================================================================== #
zinit \
	has"npm" \
	if'[[ "$USER_MODE" == "developer" ]]' \
	wait lucid \
	for OMZP::npm

# =========================================================================== #
# `node-docs` - Quickly search Node documentation
# ----------------------------------------------------------------
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/node
# =========================================================================== #
zinit \
	has"node" \
	if'[[ "$USER_MODE" == "developer" ]]' \
	wait lucid \
	for OMZP::node

# =========================================================================== #
# Completions & functions for `pip` - Python package manager
# ----------------------------------------------------------
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/pip
# =========================================================================== #
zinit \
	has"pip" \
	if'[[ "$USER_MODE" == "developer" ]]' \
	wait lucid \
	for OMZP::pip
zinit \
	has"pip" \
	if'[[ "$USER_MODE" == "developer" ]]' \
	as"completion" \
	wait lucid \
	for OMZP::pip/_pip

# =========================================================================== #
# Completions & functions for `pipenv` - Python package manager for projects
# --------------------------------------------------------------------------
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/pipenv
# =========================================================================== #
zinit \
	has"pipenv" \
	if'[[ "$USER_MODE" == "developer" ]]' \
	wait lucid \
	for OMZP::pipenv

# =========================================================================== #
# Completions for `gulp` - a Node.JS to automate & enhance your workflow
# ----------------------------------------------------------------------
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/fancy-ctrl-z
# =========================================================================== #
zinit \
	has"gulp" \
	if'[[ "$USER_MODE" == "developer" ]]' \
	wait lucid \
	for OMZP::gulp

# =========================================================================== #
# `frontend` - quickly search in documentations for frontend stuff
# ----------------------------------------------------------------
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/frontend-search
# =========================================================================== #
zinit \
 	if'[[ -n "$DISPLAY" ]] && [[ "$USER_MODE" == "developer" ]]' \
	wait"0a" lucid \
	for OMZP::frontend-search
zinit \
	has"frontend" \
	if'[[ "$USER_MODE" == "developer" ]]' \
	as"completion" \
	atload'export FRONTEND_SEARCH_FALLBACK="duckduckgo"' \
	wait"bb" lucid \
	for OMZP::frontend-search/_frontend-search.sh

# =========================================================================== #
# Vi mode in interactive command (when typing commands into shell)
# ----------------------------------------------------------------
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vi-mode
# ----
# USES: Shell
# MANPAGE(s): No
# Completions: No
# =========================================================================== #
zinit id-as"zsh-vi-mode" \
	depth"1" \
	wait lucid \
	for @jeffreytse/zsh-vi-mode

# =========================================================================== #
# Alias tips - helps remembering defined aliases
# ----------------------------------------------
# https://github.com/djui/alias-tips
# -----
# USES: Go
# MANPAGE(s): No
# Completions: No
# =========================================================================== #
#zinit ice from'gh-r' as'program'
#zinit light sei40kr/fast-alias-tips-bin
#zinit light sei40kr/zsh-fast-alias-tips

# =========================================================================== #
# Jump back to a specific directory, without doing `cd ../../..`
# --------------------------------------------------------------
# https://github.com/Tarrasch/zsh-bd
# -----
# USES: Perl Shell
# MANPAGE(s): No
# Completions: No
# =========================================================================== #
zinit id-as"bd" \
	for https://github.com/Tarrasch/zsh-bd/blob/master/bd.zsh

# =========================================================================== #
# Yank terminal output to clipboard
# ---------------------------------
# https://github.com/mptre/yank
# -----
# USES: C
# MANPAGE(s): Yes
# Completions: No
# =========================================================================== #
zinit id-as"yank" \
	if'[[ -n "$DISPLAY" ]]' \
	make"PREFIX=$ZPFX install" \
	pick"yank" \
	as"program" \
	for @mptre/yank

# =========================================================================== #
# `mmv` - rename multiple files with editor
# -----------------------------------------
# https://github.com/itchyny/mmv
# -----
# USES: Go
# MANPAGE(s): No
# Completions: No
# =========================================================================== #
if "$IS_RASPBERRYPI" && "$BUILD_FROM_SOURCE"; then
	zinit id-as"mmv" \
		has"go" \
		make"build install" \
		pick"mmv" \
		as"program" \
		for @itchyny/mmv
else
	zinit id-as"mmv" \
		from"gh-r" \
		mv"mmv* -> mmv" \
		pick"mmv/mmv/mmv" \
		as"program" \
		for @itchyny/mmv
fi

# =========================================================================== #
# `h` - command line tool to highlight terms with colors
# ------------------------------------------------------
# https://github.com/paoloantinori/hhighlighter
# ----
# USES: Shell
# MANPAGE(s): No
# COMPLETIONS: No
# =========================================================================== #
zinit id-as"highlighter" \
	for https://github.com/paoloantinori/hhighlighter/blob/master/h.sh

# =========================================================================== #
# `trans` - command-line translator using popular online translators
# ------------------------------------------------------------------
# https://github.com/soimort/translate-shell
# ----
# USES: Awk
# MANPAGE(s): No
# COMPLETIONS: No
# =========================================================================== #
zinit id-as"trans" \
	if'[[ "$USER_MODE" == "developer" ]]' \
	nocompile \
	make"PREFIX=$ZPFX install" \
	for @soimort/translate-shell

# =========================================================================== #
# `emojify` - emoji on the command line
# -------------------------------------
# https://github.com/mrowa44/emojify
# -----
# USES: Shell
# MANPAGE(s): No
# COMPLETIONS: No
# =========================================================================== #
zinit id-as"emojify" \
	if'[[ "$USER_MODE" == "developer" ]]' \
	pick"emojify" \
	as"program" \
	wait lucid \
	for mrowa44/emojify

# =========================================================================== #
# Emoji completion with `fzf`
# ---------------------------
# https://github.com/b4b4r07/emoji-cli
# -----
# USES: Shell
# MANPAGE(s): No
# COMPLETIONS: No
# =========================================================================== #
zinit id-as"emoji-cli" \
	if'[[ "$USER_MODE" == "developer" ]]' \
	has"jq" \
	has"fzf" \
	atinit' \
		export EMOJI_CLI_KEYBIND="^e";
		export EMOJI_CLI_USE_EMOJI="true";
	' \
	wait lucid \
	for @b4b4r07/emoji-cli

# =========================================================================== #
# `hr` - a horizontal line generator for terminal
# -----------------------------------------------
# https://github.com/LuRsT/hr
# ----
# USES: Shell
# MANPAGE(s): Yes
# COMPLETIONS: No
# =========================================================================== #
zinit id-as"hr" \
	if'[[ "$USER_MODE" == "developer" ]]' \
	make"PREFIX=$ZPFX MANPREFIX=$ZPFX/share install" \
	pick"hr" \
	as"program" \
	for @LuRsT/hr

# =========================================================================== #
# Vi mode in interactive command (when typing commands into shell)
# ----------------------------------------------------------------
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vi-mode
# ----
# FIXME:
# Temporarily disabled, because it overrides existing keybinds. Why?
# =========================================================================== #
zinit id-as"zsh-vi-mode" \
	depth"1" \
	wait lucid \
	for @jeffreytse/zsh-vi-mode

# =========================================================================== #
# Package of completions for existing linux commands
# --------------------------------------------------
# https://github.com/zsh-users/zsh-completions
# =========================================================================== #
zinit id-as"zsh-completions" \
	blockf \
	wait lucid \
	for @zsh-users/zsh-completions

# =========================================================================== #
# Syntax highlighting for commands
# --------------------------------
# https://github.com/zdharma/fast-syntax-highlighting
# =========================================================================== #
zinit id-as"fast-syntax-highlighting" \
	atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
	wait lucid \
	for @zdharma/fast-syntax-highlighting

# =========================================================================== #
# Suggestion of commands as you type based on completions and history
# -------------------------------------------------------------------
# https://github.com/zsh-users/zsh-autosuggestions
# =========================================================================== #
zinit id-as"zsh-autosuggestions" \
	atload"!_zsh_autosuggest_start" \
	wait lucid \
	for @zsh-users/zsh-autosuggestions

# =========================================================================== #
# Multi-word, syntax highlighted history searching for Zsh
# --------------------------------------------------------
# https://github.com/zdharma/history-search-multi-word
# =========================================================================== #
zinit id-as"history-search-multi-word" \
	wait lucid \
	for @zdharma/history-search-multi-word

# =========================================================================== #
# Collection of extension color mappings for LS_COLORS environment variable,
# displayed when using `ls`
# --------------------------------------------------------------------------
# https://github.com/trapd00r/LS_COLORS
# =========================================================================== #
zinit \
	if'[[ "$USER_MODE" == "developer" ]]' \
	pack"default" \
	wait lucid \
	for ls_colors

# =========================================================================== #
# Auto-close and delete matching delimiters in Zsh
# ------------------------------------------------
# https://github.com/hlissner/zsh-autopair
# =========================================================================== #
zinit id-as"zsh-autopair" \
	wait lucid \
	for @hlissner/zsh-autopair

# =========================================================================== #
# Fzf tabs - replace Zsh's default completion selection menu with `fzf`
# ---------------------------------------------------------------------
# https://github.com/Aloxaf/fzf-tab
# =========================================================================== #
zinit id-as"fzf-tab" \
	has"fzf" \
	if'[[ "$USER_MODE" == "developer" ]]' \
	wait lucid \
	for @Aloxaf/fzf-tab

# =========================================================================== #
# `mark` - manage bookmarks using `fzf`
# ---------------------------------------------------------------------
# https://github.com/urbainvaes/fzf-marks
# FIXME: Collides with defined keybindings, resets everything
# =========================================================================== #
# zinit id-as"fzf-marks" \
#	has"fzf" \
#	if'[[ "$USER_MODE" == "developer" ]]' \
#	atinit'
#		export FZF_MARKS_FILE="$XDG_CACHE_HOME/.fzf-marks"; \
#	' \
#	wait lucid \
#	for @urbainvaes/fzf-marks

# =========================================================================== #
# Real-time type-ahead completion for Zsh
# ---------------------------------------
# https://github.com/marlonrichert/zsh-autocomplete
# NOTE:
# Unfriendly, collides with...?
# =========================================================================== #
# zinit id-as"zsh-autocomplete" \
#	wait lucid \
#	for @marlonrichert/zsh-autocomplete

# =========================================================================== #
# A next-generation 'cd' command with installed interactive filter
# ----------------------------------------------------------------
# https://github.com/b4b4r07/enhancd
# -----
# USES: Shell
# MANPAGE(s): No
# COMPLETIONS: No
# =========================================================================== #
# zinit id-as"enhancd" \
# 	has"fzf" \
# 	if'[[ "$USER_MODE" == "developer" ]]' \
# 	nocompile \
# 	atinit' \
# 		export ENHANCD_DIR="$XDG_CACHE_HOME/.enhancd"; \
# 		export ENHANCD_DISABLE_DOT=1; \
# 	' \
# 	atclone'rm -f */*.fish' \
# 	atpull"%atclone" \
# 	src"init.sh" \
# 	for @b4b4r07/enhancd

# ======================================================================== #
# `httpstat` - like `curl -v`, with graphs and colors
# ---------------------------------------------------
# https://github.com/b4b4r07/httpstat/blob/master/httpstat.sh
# -----
# USES: Shell
# MANPAGE(s): No
# COMPLETIONS: No
# ======================================================================== #
zinit id-as"httpstat" \
	if'[[ "$USER_MODE" == "developer" ]]' \
	mv"httpstat.sh -> httpstat" \
	atpull"!git reset --hard" \
	pick"httpstat" \
	as"program" \
	wait lucid \
	for @b4b4r07/httpstat
