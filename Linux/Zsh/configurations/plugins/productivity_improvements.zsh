# =========================================================================== #
# Vi mode in interactive command (when typing commands into shell)
# ----------------------------------------------------------------
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vi-mode
# =========================================================================== #
zinit snippet OMZP::vi-mode

# =========================================================================== #
# `Ctrl + Z` to back to Vim (in backgroung proces) instead of `fg`
# ----------------------------------------------------------------
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/fancy-ctrl-z
# =========================================================================== #
zinit snippet OMZP::fancy-ctrl-z

# =========================================================================== #
# Alias finder
# ------------
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/alias-finder
# ---
# NOTE: This plugin doesn't read Git's aliases
# =========================================================================== #
# zinit ice \
#     atload'ZSH_ALIAS_FINDER_AUTOMATIC=true'
# zinit snippet OMZP::alias-finder

# =========================================================================== #
# Alias tips - helps remembering defined aliases
# ----------------------------------------------
# https://github.com/djui/alias-tips
# =========================================================================== #
zinit ice \
	id-as"alias-tips" \
	pick"alias-tips.plugin.zsh" \
	atload'export ZSH_PLUGINS_ALIAS_TIPS_REVEAL=1'
zinit load djui/alias-tips

# =========================================================================== #
# Jump back to a specific directory, without doing `cd ../../..`
# --------------------------------------------------------------
# https://github.com/Tarrasch/zsh-bd
# =========================================================================== #
zinit ice \
	id-as"bd"
zinit snippet https://github.com/Tarrasch/zsh-bd/blob/master/bd.zsh

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
	as"program"
zinit load mptre/yank

# =========================================================================== #
# quick access to files and directories, inspired by 'autojump', 'z' and 'v'
# --------------------------------------------------------------------------
# https://github.com/clvv/fasd
# =========================================================================== #
zinit ice \
	id-as"fasd" \
	make"PREFIX=$ZPFX install" \
	pick"fasd" \
	as"program" \
	atload'export _FASD_DATA=$XDG_CACHE_HOME/.fasd; \
		eval "$(fasd --init auto)"'
zinit load clvv/fasd

# =========================================================================== #
# `fzf` + `fasd` integration
# --------------------------
# https://github.com/wookayin/fzf-fasd/blob/master/fzf-fasd.plugin.zsh
# =========================================================================== #
zinit ice wait'1' lucid \
	id-as"fzf-fasd" \
	if'[[ -n "$commands[fzf]" && -n "$commands[fasd]" ]]'
zinit snippet https://github.com/wookayin/fzf-fasd/blob/master/fzf-fasd.plugin.zsh

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

