# =========================================================================== #
# Syntax highlighting for commands in Zsh
# ---------------------------------------
# https://github.com/zdharma/fast-syntax-highlighting
# =========================================================================== #
zinit ice wait lucid \
	atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay"
zinit load zdharma/fast-syntax-highlighting

# =========================================================================== #
# Additional completion definitions for Zsh
# -----------------------------------------
# https://github.com/zsh-users/zsh-completions
# =========================================================================== #
zinit ice wait lucid \
	blockf \
zinit load zsh-users/zsh-completions

# =========================================================================== #
# Suggestion of commands as you type based on completions and history
# -------------------------------------------------------------------
# https://github.com/zsh-users/zsh-autosuggestions
# =========================================================================== #
zinit ice wait lucid \
	atload"!_zsh_autosuggest_start"
zinit load zsh-users/zsh-autosuggestions

# =========================================================================== #
# Multi-word, syntax highlighted history searching for Zsh
# --------------------------------------------------------
# https://github.com/zdharma/history-search-multi-word
# =========================================================================== #
zinit ice wait lucid
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
zinit ice wait lucid
zinit load hlissner/zsh-autopair

