# =========================================================================== #
# `navi` - Interactive cheatsheet tool for the command-line
#          and application launchers
# ---------------------------------------------------------
# https://github.com/denisidoro/navi
# NOTE:
# Requires Cargo
# =========================================================================== #
# zinit ice wait lucid \
#     id-as"navi" \
#     make"SRC_DIR=$ZINIT[PLUGINS_DIR] BIN_DIR=$ZPFX/bin TMP_DIR=$XDG_CACHE_HOME install"
# zinit load denisidoro/navi

# =========================================================================== #
# `tldr` - Collaborative cheatsheets for console commands
# -------------------------------------------------------
# https://github.com/tldr-pages/tldr
# =========================================================================== #
zinit ice wait lucid \
	id-as"tldr" \
	pick"tldr tldr-lint" \
	as"program"
zinit load pepa65/tldr-bash-client

# =========================================================================== #
# Cheat.sh - the only cheatsheet you need
# ---------------------------------------
# https://github.com/chubin/cheat.sh
# =========================================================================== #
zinit ice wait lucid \
	id-as"cht.sh" \
	has'rlwrap' \
	as"program" \
	atload'export CHTSH="$XDG_CONFIG_HOME"'
zinit snippet "https://cht.sh/:cht.sh"
zinit ice wait"1" lucid \
	id-as"cht-completion" \
	has'rlwrap' \
	mv"cht* -> _cht" \
	as"completion"
zinit snippet https://cheat.sh/:zsh

# =========================================================================== #
# Cheat - create and view interactive cheatsheets on the command-line
# -------------------------------------------------------------------
# https://github.com/cheat/cheat
# =========================================================================== #
zinit ice wait lucid \
	id-as"cheat" \
	from"gh-r" \
	mv"cheat* -> cheat" \
	pick"cheat" \
	as"program"
zinit load cheat/cheat
zinit ice wait"1" lucid \
	id-as"cheat-completion" \
	mv"cheat* -> _cheat" \
	as"completion"
zinit snippet https://github.com/cheat/cheat/blob/master/scripts/cheat.zsh

