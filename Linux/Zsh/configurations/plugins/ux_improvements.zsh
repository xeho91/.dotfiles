# =========================================================================== #
# Syntax highlighting for commands in Zsh
# ---------------------------------------
# https://github.com/zdharma/fast-syntax-highlighting
# =========================================================================== #
zinit ice wait lucid \
	id-as"fast-syntax-highlighting" \
	atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay"
zinit load zdharma/fast-syntax-highlighting

# =========================================================================== #
# Additional completion definitions for Zsh
# -----------------------------------------
# https://github.com/zsh-users/zsh-completions
# =========================================================================== #
zinit ice wait lucid \
	id-as"zsh-completions" \
	blockf \
zinit load zsh-users/zsh-completions

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
# Colored `man` pages
# -------------------
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/colored-man-pages
# =========================================================================== #
zinit snippet OMZP::colored-man-pages

# =========================================================================== #
# Command not found
# -----------------
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/command-not-found
# =========================================================================== #
zinit snippet OMZP::command-not-found

# =========================================================================== #
# Last working directory
# ----------------------
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/last-working-dir
# =========================================================================== #
zinit snippet OMZP::last-working-dir

# =========================================================================== #
# Alias finder
# ------------
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/alias-finder
# =========================================================================== #
zinit ice \
	atload'ZSH_ALIAS_FINDER_AUTOMATIC=true'
zinit snippet OMZP::alias-finder
