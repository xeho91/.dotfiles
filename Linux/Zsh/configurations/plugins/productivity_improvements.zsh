# =========================================================================== #
# Alias tips - helps remembering defined aliases
# ----------------------------------------------
# https://github.com/djui/alias-tips
# =========================================================================== #
zinit \
	id-as"alias-tips" \
	pick"alias-tips.plugin.zsh" \
	atload'export ZSH_PLUGINS_ALIAS_TIPS_REVEAL=1' \
	for @djui/alias-tips

# =========================================================================== #
# Jump back to a specific directory, without doing `cd ../../..`
# --------------------------------------------------------------
# https://github.com/Tarrasch/zsh-bd
# =========================================================================== #
zinit \
	id-as"bd" \
	for https://github.com/Tarrasch/zsh-bd/blob/master/bd.zsh

# =========================================================================== #
# Yank terminal output to clipboard
# ---------------------------------
# https://github.com/mptre/yank
# =========================================================================== #
zinit ice \
	id-as"yank" \
	if'[[ -v "$DISPLAY" ]]' \
	make"PREFIX=$ZPFX install" \
	pick"yank" \
	as"program" \
	for @mptre/yank

# =========================================================================== #
# quick access to files and directories, inspired by 'autojump', 'z' and 'v'
# --------------------------------------------------------------------------
# https://github.com/clvv/fasd
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/fasd/fasd.plugin.zsh
# =========================================================================== #
zinit \
	id-as"fasd" \
	make"PREFIX=$ZPFX install" \
	pick"fasd" \
	as"program" \
	atload'export _FASD_DATA=$XDG_CACHE_HOME/.fasd; \
		eval "$(fasd --init auto)"' \
	for @clvv/fasd
zinit wait lucid \
	has"fasd" \
	for OMZP::fasd

# =========================================================================== #
# `fzf` + `fasd` integration
# --------------------------
# https://github.com/wookayin/fzf-fasd/blob/master/fzf-fasd.plugin.zsh
# =========================================================================== #
zinit wait lucid \
	id-as"fzf-fasd" \
	if'[[ -n "$commands[fzf]" && -n "$commands[fasd]" ]]' \
	for https://github.com/wookayin/fzf-fasd/blob/master/fzf-fasd.plugin.zsh

# =========================================================================== #
# `fpp` - command line tool for selecting files out of shell output
# -----------------------------------------------------------------
# https://github.com/facebook/PathPicker
# ---
# TODO: Bugged?
# =========================================================================== #
# zinit ice \
#     cd"PathPicker/debian" \
#     atclone"./package.sh" \
#     atpull"%atclone" \
#     pick"fpp" \
#     as"program"
# zinit load facebook/PathPicker

# =========================================================================== #
# `frontend` -quickly search in documentations for FrontEnd stuff
# ---------------------------------------------------------------
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/frontend-search
# =========================================================================== #
zinit wait"2a" lucid \
	if'[[ -v "$DISPLAY" ]]' \
	atload'export FRONTEND_SEARCH_FALLBACK="duckduckgo"' \
	for OMZP::frontend-search
# zinit wait"0b" lucid \
#     has"frontend" \
#     as"completion" \
#     for OMZP::frontend-search/_frontend-search.sh

# =========================================================================== #
# Vi mode in interactive command (when typing commands into shell)
# ----------------------------------------------------------------
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vi-mode
# =========================================================================== #
zinit wait"2" lucid \
	for OMZP::vi-mode

# =========================================================================== #
# `Ctrl + Z` to back to Vim (in backgroung proces) instead of `fg`
# ----------------------------------------------------------------
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/fancy-ctrl-z
# =========================================================================== #
zinit wait"2" lucid \
	for OMZP::fancy-ctrl-z

