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
# =========================================================================== #
zinit ice wait lucid \
	id-as"jq" \
	mv"jq* -> jq" \
	atclone'autoreconf -i; \
		./configure \
			--prefix=$ZPFX \
			--with-oniguruma=builtin \
			--disable-maintainer-mode' \
	atpull"%atclone" \
	make"clean all install" \
	pick"jq/jq" \
	as"program" \
	atload'export JQ_COLORS="1;30:0;31:0;32:0;33:0;37:1;35:1;36"'
zinit load stedolan/jq

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

