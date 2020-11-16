# =========================================================================== #
# `navi` - interactive cheatsheet tool for the command-line
#          and application launchers
# ---------------------------------------------------------
# https://github.com/denisidoro/navi
# =========================================================================== #
zinit wait lucid \
	id-as"navi" \
	has"cargo" \
	make"SRC_DIR=$ZINIT[PLUGINS_DIR] BIN_DIR=$ZPFX/bin TMP_DIR=$XDG_CACHE_HOME install" \
	atload'eval "$(navi widget zsh)";' \
	for @denisidoro/navi

# =========================================================================== #
# `tldr` - collaborative cheatsheets for console commands
# https://github.com/tldr-pages/tldr
# -------------------------------------------------------
# https://github.com/dbrgn/tealdeer
# TODO: Fix!
# =========================================================================== #
# zinit wait"0a" lucid \
#     id-as"tldr" \
#     nocompile \
#     atclone'cargo build --release' \
#     atpull"%atclone" \
#     for @dbrgn/tealdeer
# zinit wait"0b" lucid \
#     id-as"tldr-completions" \
#     mv"zsh* -> _tldr" \
#     for https://github.com/dbrgn/tealdeer/blob/master/zsh_tealdeer

# =========================================================================== #
# `cht.sh` - (Cheat.sh) community driven cheat sheets repositories
# ----------------------------------------------------------------
# https://github.com/chubin/cheat.sh
# =========================================================================== #
zinit wait"0a" lucid \
	id-as"cht.sh" \
	has'rlwrap' \
	as"program" \
	atload'export CHTSH="$XDG_CONFIG_HOME"' \
	for https://cht.sh/:cht.sh
zinit wait"0b" lucid \
	id-as"cht-completion" \
	has'rlwrap' \
	mv"cht* -> _cht" \
	as"completion" \
	for https://cheat.sh/:zsh

# =========================================================================== #
# `cheat` - create and view interactive cheatsheets on the command-line
# ---------------------------------------------------------------------
# https://github.com/cheat/cheat
# =========================================================================== #
zinit wait"0a" lucid \
	id-as"cheat" \
	from"gh-r" \
	mv"cheat* -> cheat" \
	pick"cheat" \
	as"program" \
	for @cheat/cheat
zinit wait"0b" lucid \
	id-as"cheat-completion" \
	mv"cheat* -> _cheat" \
	as"completion" \
	for https://github.com/cheat/cheat/blob/master/scripts/cheat.zsh

