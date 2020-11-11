# =============================================================================
# Oh My Zsh (OMZ) - open source framework for managing Zsh configuration
# ----------------------------------------------------------------------
# https://github.com/ohmyzsh/ohmyzsh
# ----------------------------------
# Functionalities (libary) from OMZ
# ---------------------------------
# https://github.com/ohmyzsh/ohmyzsh/tree/master/lib
# ============================================================================

# Add path for caching the selected functionalities from OMZ
export ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/ohmyzsh"

# Clipboard
zinit ice \
	if'[[ -v "$DISPLAY" ]]'
zinit snippet OMZL::clipboard.zsh

# Completions
zinit ice \
	atload'export COMPLETION_WAITING_DOTS=true'
zinit snippet OMZL::completion.zsh

# Correction
zinit ice \
	atload'export ENABLE_CORRECTION=true'
zinit snippet OMZL::correction.zsh

# Directories
zinit snippet OMZL::directories.zsh

# Improving `grep`
zinit snippet OMZL::grep.zsh

# Functions
# zinit snippet OMZL::functions.zsh

# Key bindings (based on emacs)
# zinit snippet OMZL::key-bindings.zsh

# Misc
# zinit snippet OMZL::misc.zsh

# Spectrum
zinit snippet OMZL::spectrum.zsh

# Termninal support (setting terminal window tab/icon title)
zinit snippet OMZL::termsupport.zsh

