# =========================================================================== #
# Syntax highlighting for commands
# --------------------------------
# https://github.com/zdharma/fast-syntax-highlighting
# =========================================================================== #
zinit ice wait lucid \
	id-as"fast-syntax-highlighting" \
	atinit"zicompinit; zicdreplay"
zinit load zdharma/fast-syntax-highlighting

# =========================================================================== #
# Suggestion of commands as you type based on completions and history
# -------------------------------------------------------------------
# https://github.com/zsh-users/zsh-autosuggestions
# =========================================================================== #
zinit ice wait lucid \
	id-as"zsh-autosuggestions" \
	atload"!_zsh_autosuggest_start"
zinit load zsh-users/zsh-autosuggestions

# =========================================================================== #
# Multi-word, syntax highlighted history searching for Zsh
# --------------------------------------------------------
# https://github.com/zdharma/history-search-multi-word
# =========================================================================== #
zinit ice wait lucid \
	id-as"history-search-multi-word"
zinit load zdharma/history-search-multi-word

# =========================================================================== #
# Collection of extension color mappings for LS_COLORS environment variable,
# displayed when using `ls`
# --------------------------------------------------------------------------
# https://github.com/trapd00r/LS_COLORS
# =========================================================================== #
zinit pack for ls_colors

# =========================================================================== #
# Auto-close and delete matching delimiters in Zsh
# ------------------------------------------------
# https://github.com/hlissner/zsh-autopair
# =========================================================================== #
zinit ice wait lucid \
	id-as"zsh-autopair"
zinit load hlissner/zsh-autopair

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
# Fzf tabs - replace Zsh's default completion selection menu with `fzf`
# ---------------------------------------------------------------------
# https://github.com/Aloxaf/fzf-tab
# =========================================================================== #
zinit ice wait lucid \
	id-as"fzf-tab" \
	has"fzf"
zinit load Aloxaf/fzf-tab

# =========================================================================== #
# `mark` - manage bookmarks using `fzf`
# ---------------------------------------------------------------------
# https://github.com/urbainvaes/fzf-marks
# =========================================================================== #
zinit ice wait lucid \
	id-as"fzf-marks" \
	has"fzf" \
	atinit'export FZF_MARKS_FILE="$XDG_CACHE_HOME/.fzf-marks"'
zinit load urbainvaes/fzf-marks

# =========================================================================== #
# command line tool to highlight terms
# ------------------------------------
# https://github.com/paoloantinori/hhighlighter
# =========================================================================== #
zinit ice \
	id-as"highlighter"
zinit snippet https://github.com/paoloantinori/hhighlighter/blob/master/h.sh


