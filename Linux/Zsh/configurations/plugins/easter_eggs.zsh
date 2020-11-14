# =========================================================================== #
# `lolcat` - rainbow and unicorns
# -------------------------------
# https://github.com/jaseg/lolcat
# =========================================================================== #
zinit ice \
	id-as"lolcat" \
	make \
	pick"lolcat censor" \
	as"program"
zinit load jaseg/lolcat

# =========================================================================== #
# `boxes` - boxes with fancy shapes
# ---------------------------------
# https://github.com/ascii-boxes/boxes
# =========================================================================== #
zinit ice \
	id-as"boxes" \
	make!"GLOBALCONF=$ZINIT[PLUGINS_DIR]/boxes/boxes-config" \
	atclone'cp doc/boxes.1 $ZPFX/man/man1' \
	atpull"%atclone" \
	pick"src/boxes" \
	as"program"
zinit load ascii-boxes/boxes

# =========================================================================== #
# `screenfetch` - fetches system/theme information in terminal for Linux
#				  desktop screenshots
# ----------------------------------------------------------------------
# https://github.com/KittyKatt/screenFetch
# =========================================================================== #
zinit ice \
	id-as"screenfetch" \
	mv"screenfetch-dev -> screenfetch" \
	atclone"mv screenfetch.1 $ZPFX/man/man1" \
	pick"screenfetch-dev" \
	as"program"
zinit load @KittyKatt/screenFetch

# =========================================================================== #
# `quote` - display a random quote taken from quotationspage.com
# --------------------------------------------------------------
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/rand-quote
# =========================================================================== #
zinit snippet OMZP::rand-quote

