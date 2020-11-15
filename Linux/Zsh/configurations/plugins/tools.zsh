# =========================================================================== #
# `zsh` - install the newest version of Zsh
# ---
# NOTE: Verify the version first
# =========================================================================== #
# zinit pack for zsh

# =========================================================================== #
# `jq` - command-line JSON processor
# ----------------------------------
# https://github.com/stedolan/jq
# ---
# NOTE: Colors configuration in this order:
# null, false, true, numbers, strings, arrays, objects
# Source: https://stedolan.github.io/jq/manual/#Colors
# ---
# TODO: Fix adding to man pages
# requires pipenv
# =========================================================================== #
# zinit ice wait lucid \
#     id-as"jq" \
#     mv"jq* -> jq" \
#     atclone'autoreconf -i; \
#         ./configure \
#             --prefix=$ZPFX \
#             --with-oniguruma=builtin \
#             --disable-docs \
#             --disable-maintainer-mode' \
#     atpull"%atclone" \
#     make"install" \
#     pick"jq/jq" \
#     as"program" \
#     atload'export JQ_COLORS="1;30:0;31:0;32:0;33:0;37:1;35:1;36"'
# zinit load stedolan/jq

# =========================================================================== #
# `glow` - Terminal based markdown reader
# ---------------------------------------
# https://github.com/charmbracelet/glow
# =========================================================================== #
zinit ice wait lucid \
	id-as"glow" \
	from"gh-r" \
	bpick"*linux_arm64.tar.gz" \
	pick"glow" \
	as"program"
zinit load charmbracelet/glow

# =========================================================================== #
# `nnn` (n³) -the unorthodox terminal file manager
# ------------------------------------------------
# https://github.com/jarun/nnn
# =========================================================================== #
zinit ice wait lucid \
	id-as"nnn" \
	make"PREFIX=$ZPFX O_NERD=1 strip install" \
	atload'alias n="nnn"'
zinit load jarun/nnn

# =========================================================================== #
# `br` (Broot) - a better way to navigate directories
# ---------------------------------------------------
# https://github.com/Canop/broot
# ---
# NOTE: Requires cargo to build
# =========================================================================== #
# zinit ice \
#     id-as"broot" \
#     has"cargo" \
#     pick"br" \
#     as"program"
# zinit load https://dystroy.org/broot/download/


# =========================================================================== #
# `urlencode` and `urldecode`
# ---------------------------
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/urltools
# =========================================================================== #
zinit snippet OMZP::urltools

# =========================================================================== #
# `extract` - unpack archives without remembering
# -----------------------------------------------
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/extract
# =========================================================================== #
zinit snippet OMZP::extract
zinit ice \
	as"completion"
zinit snippet OMZP::extract/_extract

# =========================================================================== #
# `encode64` and `decode64`
# -------------------------
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/encode64/encode64.plugin.zsh
# =========================================================================== #
zinit snippet OMZP::encode64

# =========================================================================== #
# `taskwarrior` - CLI task management
# -----------------------------------
# https://github.com/GothenburgBitFactory/taskwarrior
# ---
# NOTE: Is better to install from distribution(s) package repository, as it
#		takes way too long to compile
# =========================================================================== #
# zinit ice wait lucid \
#     id-as"taskwarrior" \
#     atclone"cmake \
#         -DCMAKE_INSTALL_PREFIX=$ZPFX \
#         -DCMAKE_BUILD_TYPE=release ." \
#     make"install"
# zinit load gothenburgbitfactory/taskwarrior

# =========================================================================== #
# Completions for `task` (taskwarrior)
# ------------------------------------
# https://github.com/GothenburgBitFactory/taskwarrior
# =========================================================================== #
zinit ice wait lucid \
	id-as"taskwarrior_completion" \
	has"task" \
	as"completion"
zinit snippet https://github.com/GothenburgBitFactory/taskwarrior/blob/2.5.2/scripts/zsh/_task

