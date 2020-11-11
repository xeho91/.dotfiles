# =========================================================================== #
# `navi` - Interactive cheatsheet tool for the command-line
#          and application launchers
# ---------------------------------------------------------
# https://github.com/denisidoro/navi
# =========================================================================== #
zinit ice wait lucid \
	id-as"navi" \
	has'cargo' \
	make"SRC_DIR=$ZINIT[PLUGINS_DIR] BIN_DIR=$ZPFX/bin TMP_DIR=$XDG_CACHE_HOME install" \
	as"program"
zinit load denisidoro/navi

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

