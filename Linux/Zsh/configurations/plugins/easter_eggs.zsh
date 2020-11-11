# =========================================================================== #
# Rainbow and unicorns
# ---------------------------------
# https://github.com/jaseg/lolcat
# =========================================================================== #
zinit ice \
	id-as"lolcat" \
	as"program" \
	make
zinit load jaseg/lolcat

# =========================================================================== #
# Boxes with fancy shapes
# -----------------------
# https://github.com/ascii-boxes/boxes
# =========================================================================== #
zinit ice \
	id-as"boxes" \
	as"program" \
	make \
	pick"src/boxes" \
	atload'alias boxes="boxes -f $ZINIT[PLUGINS_DIR]/boxes/boxes-config"'
zinit load ascii-boxes/boxes

