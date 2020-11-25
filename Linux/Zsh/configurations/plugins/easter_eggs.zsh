# =========================================================================== #
# `lolcat` - rainbow and unicorns
# -------------------------------
# https://github.com/jaseg/lolcat
# =========================================================================== #
zinit \
	id-as"lolcat" \
	nocompile \
	make"DESTDIR=$ZPFX/bin install" \
	for @jaseg/lolcat

# =========================================================================== #
# `boxes` - boxes with fancy shapes
# ---------------------------------
# https://github.com/ascii-boxes/boxes
# =========================================================================== #
zinit \
	id-as"boxes" \
	nocompile \
	make!'GLOBALCONF=$ZINIT[PLUGINS_DIR]/boxes/boxes-config build' \
	atclone'cp doc/boxes.1 $ZPFX/man/man1' \
	atpull"%atclone" \
	pick"src/boxes" \
	as"program" \
	for @ascii-boxes/boxes

# =========================================================================== #
# `screenfetch` - fetches system/theme information in terminal for Linux
#                 desktop screenshots
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

# =========================================================================== #
# `emojify` - emoji on the command line
# -------------------------------------
# https://github.com/mrowa44/emojify
# =========================================================================== #
zinit wait"2" lucid \
	id-as"emojify" \
	pick"emojify" \
	as"program" \
	for mrowa44/emojify

# =========================================================================== #
# Emoji completion with `fzf`
# ---------------------------
# https://github.com/b4b4r07/emoji-cli
# =========================================================================== #
zinit wait"2" lucid \
	has"jq fzf" \
	id-as"emoji-cli" \
	for @b4b4r07/emoji-cli

# =========================================================================== #
# `hacker-laws-cli` - Laws, Theories, Principles and Patterns that developers
#                     will find useful #hackerlaws
# ------------------------------------------------
# https://github.com/umutphp/hacker-laws-cli
# =========================================================================== #
zinit \
	id-as"hacker-laws-cli" \
	nocompile \
	atclone'go build' \
	atpull"%atclone" \
	pick"hacker-laws-cli" \
	as"program" \
	for @umutphp/hacker-laws-cli

