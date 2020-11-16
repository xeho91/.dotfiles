# =============================================================================
# Oh My Zsh (OMZ) - open source framework for managing Zsh configuration
# ----------------------------------------------------------------------
# https://github.com/ohmyzsh/ohmyzsh
# ----------------------------------
# ============================================================================

# Add path for caching the selected functionalities from OMZ
export ZSH_CACHE_DIR="$XDG_CACHE_HOME/ohmyzsh"

# Functionalities (libary) from OMZ
# ---------------------------------
# https://github.com/ohmyzsh/ohmyzsh/tree/master/lib

# Clipboard
zinit wait lucid \
 	if'[[ -v "$DISPLAY" ]]' \
	for OMZL::clipboard.zsh

# Completions
zinit wait lucid \
	atload'export COMPLETION_WAITING_DOTS=true' \
	for OMZL::completion.zsh

# Correction
zinit wait lucid \
	atload'export ENABLE_CORRECTION=true' \
	for OMZL::correction.zsh

# Directories
zinit wait lucid \
	for OMZL::directories.zsh

# Improving `grep`
zinit wait lucid \
	for OMZL::grep.zsh

# Key bindings (based on emacs)
zinit wait lucid \
	for OMZL::key-bindings.zsh

# Termninal support (setting terminal window tab/icon title)
zinit wait lucid \
	for OMZL::termsupport.zsh

