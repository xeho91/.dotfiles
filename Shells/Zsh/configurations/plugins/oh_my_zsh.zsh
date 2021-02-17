# =============================================================================
# Oh My Zsh (OMZ) - open source framework for managing Zsh configuration
# ----------------------------------------------------------------------
# https://github.com/ohmyzsh/ohmyzsh
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

# Plugins from OMZ
# ----------------
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins

# =========================================================================== #
# `urlencode` and `urldecode`
# ---------------------------
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/urltools
# =========================================================================== #
zinit wait lucid \
	for OMZP::urltools
# =========================================================================== #
# `encode64` and `decode64`
# -------------------------
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/encode64/
# =========================================================================== #
zinit wait lucid \
	for OMZP::encode64

# =========================================================================== #
# `extract` - unpack archives without remembering
# -----------------------------------------------
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/extract
# =========================================================================== #
zinit wait"0a" lucid \
	for OMZP::extract
zinit wait"0b" lucid \
	has"extract" \
	as"completion" \
	for OMZP::extract/_extract

# =========================================================================== #
# Vi mode in interactive command (when typing commands into shell)
# ----------------------------------------------------------------
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vi-mode
# =========================================================================== #
zinit wait lucid \
	for OMZP::vi-mode

# =========================================================================== #
# `ctrl + z` to back to vim (in backgroung proces) instead of `fg`
# ----------------------------------------------------------------
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/fancy-ctrl-z
# =========================================================================== #
zinit wait lucid \
	for OMZP::fancy-ctrl-z

# =========================================================================== #
# Completions for `pip` - Python package manager + some functions
# ---------------------------------------------------------------
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/fancy-ctrl-z
# =========================================================================== #
zinit wait lucid \
	has"pip" \
	for OMZP::pip
zinit wait lucid \
	has"pip" \
	as"completion" \
	for OMZP::pip/_pip

# =========================================================================== #
# Completions for `gulp` - a Node.JS to automate & enhance your workflow
# ----------------------------------------------------------------------
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/fancy-ctrl-z
# =========================================================================== #
zinit wait lucid \
	has"gulp" \
	for OMZP::gulp

