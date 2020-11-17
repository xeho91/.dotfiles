# =========================================================================== #
# `fd` -  simple, fast and user-friendly alternative to `find`
# ------------------------------------------------------------
# https://github.com/sharkdp/fd
# =========================================================================== #
zinit \
	id-as"fd" \
	from"gh-r" \
	mv"fd* -> fd" \
	pick"fd/fd" \
	as"program" \
	for @sharkdp/fd

# =========================================================================== #
# `ag` - code-searching tool similar to `ack`, but faster
# -------------------------------------------------------
# https://github.com/ggreer/the_silver_searcher
# NOTE:
# Depedencies:
# automake pkg-config libpcre3-dev zlib1g-dev liblzma-dev
# =========================================================================== #
zinit \
	id-as"ag" \
	has"automake" \
	atclone'./build.sh; \
		./configure --prefix=$ZPFX' \
	atpull'%atclone' \
	make'install' \
	pick"$ZPFX/bin/ag" \
	as"program" \
	for @ggreer/the_silver_searcher

# =========================================================================== #
# `rg` - recursively searching directories for a regex pattern with gitignore
# ---------------------------------------------------------------------------
# https://github.com/BurntSushi/ripgrep
# =========================================================================== #
zinit \
	id-as"rg" \
	from"gh-r" \
	mv"rip* -> rg" \
	atclone"mv rg/doc/rg.1 $ZPFX/man/man1" \
	pick"rg/rg" \
	as"program" \
	for @BurntSushi/ripgrep
