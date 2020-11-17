# =========================================================================== #
# Alias tips - helps remembering defined aliases
# ----------------------------------------------
# https://github.com/djui/alias-tips
# =========================================================================== #
zinit wait"1" lucid \
	id-as"alias-tips" \
	has"python" \
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
zinit \
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
zinit \
	has"fasd" \
	for OMZP::fasd

# =========================================================================== #
# `fzf` + `fasd` integration
# --------------------------
# https://github.com/wookayin/fzf-fasd/blob/master/fzf-fasd.plugin.zsh
# =========================================================================== #
zinit \
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
# `frontend` - quickly search in documentations for frontend stuff
# ----------------------------------------------------------------
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/frontend-search
# =========================================================================== #
zinit wait"1a" lucid \
	if'[[ -v "$DISPLAY" ]]' \
	atload'export FRONTEND_SEARCH_FALLBACK="duckduckgo"' \
	for OMZP::frontend-search
zinit wait"1b" lucid \
	has"frontend" \
	as"completion" \
	for OMZP::frontend-search/_frontend-search.sh

# =========================================================================== #
# `mmv` - rename multiple files with editor
# -----------------------------------------
# https://github.com/itchyny/mmv
# =========================================================================== #
zinit \
	id-as"mmv" \
	has"go" \
	make"build install" \
	pick"mmv" \
	as"program" \
	for @itchyny/mmv

