# =========================================================================== #
# `zsh` - install the newest version of Zsh
# =========================================================================== #
zinit \
	pack"default" \
	for zsh

# =========================================================================== #
# Syntax highlighting for commands
# --------------------------------
# https://github.com/zdharma/fast-syntax-highlighting
# =========================================================================== #
zinit wait lucid \
	id-as"fast-syntax-highlighting" \
	atinit"zicompinit; zicdreplay" \
	for @zdharma/fast-syntax-highlighting

# =========================================================================== #
# Suggestion of commands as you type based on completions and history
# -------------------------------------------------------------------
# https://github.com/zsh-users/zsh-autosuggestions
# =========================================================================== #
zinit wait lucid \
	id-as"zsh-autosuggestions" \
	atload"!_zsh_autosuggest_start" \
	for @zsh-users/zsh-autosuggestions

# =========================================================================== #
# Multi-word, syntax highlighted history searching for Zsh
# --------------------------------------------------------
# https://github.com/zdharma/history-search-multi-word
# =========================================================================== #
zinit wait"3" lucid \
	id-as"history-search-multi-word" \
	for @zdharma/history-search-multi-word

# =========================================================================== #
# Collection of extension color mappings for LS_COLORS environment variable,
# displayed when using `ls`
# --------------------------------------------------------------------------
# https://github.com/trapd00r/LS_COLORS
# =========================================================================== #
zinit wait lucid \
	pack"default" \
	for ls_colors

# =========================================================================== #
# Auto-close and delete matching delimiters in Zsh
# ------------------------------------------------
# https://github.com/hlissner/zsh-autopair
# =========================================================================== #
zinit wait lucid \
	id-as"zsh-autopair" \
	for @hlissner/zsh-autopair

# =========================================================================== #
# Fzf tabs - replace Zsh's default completion selection menu with `fzf`
# ---------------------------------------------------------------------
# https://github.com/Aloxaf/fzf-tab
# =========================================================================== #
zinit wait lucid \
	id-as"fzf-tab" \
	has"fzf" \
	for @Aloxaf/fzf-tab

# =========================================================================== #
# `mark` - manage bookmarks using `fzf`
# ---------------------------------------------------------------------
# https://github.com/urbainvaes/fzf-marks
# =========================================================================== #
zinit wait lucid \
	id-as"fzf-marks" \
	has"fzf" \
	atinit'export FZF_MARKS_FILE="$XDG_CACHE_HOME/.fzf-marks"; \
		export FZF_MARKS_JUMP="^b"' \
	for @urbainvaes/fzf-marks

# =========================================================================== #
# Real-time type-ahead completion for Zsh
# ---------------------------------------
# https://github.com/marlonrichert/zsh-autocomplete
# ---
# NOTE: Quite unfriendly at the moment, because is completely changing the
# defaults
# =========================================================================== #
# zinit ice wait lucid \
#     id-as"zsh-autocomplete"
# zinit load marlonrichert/zsh-autocomplete

