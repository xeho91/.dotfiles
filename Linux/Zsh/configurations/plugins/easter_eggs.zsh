# =========================================================================== #
# `lolcat` - rainbow and unicorns
# -------------------------------
# https://github.com/jaseg/lolcat
# =========================================================================== #
zinit \
	id-as"lolcat" \
	make \
	pick"lolcat censor" \
	as"program" \
	for @jaseg/lolcat

# =========================================================================== #
# `boxes` - boxes with fancy shapes
# ---------------------------------
# https://github.com/ascii-boxes/boxes
# =========================================================================== #
zinit \
	id-as"boxes" \
	make!"GLOBALCONF=$ZINIT[PLUGINS_DIR]/boxes/boxes-config" \
	atclone'cp doc/boxes.1 $ZPFX/man/man1' \
	atpull"%atclone" \
	pick"src/boxes" \
	as"program" \
	for @ascii-boxes/boxes

# =========================================================================== #
# `screenfetch` - fetches system/theme information in terminal for Linux
#				  desktop screenshots
# ----------------------------------------------------------------------
# https://github.com/KittyKatt/screenFetch
# =========================================================================== #
zinit \
	id-as"screenfetch" \
	mv"screenfetch-dev -> screenfetch" \
	atclone"mv screenfetch.1 $ZPFX/man/man1" \
	pick"screenfetch-dev" \
	as"program" \
	for @KittyKatt/screenFetch

