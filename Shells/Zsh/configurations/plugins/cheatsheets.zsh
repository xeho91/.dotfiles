# =========================================================================== #
# `navi` - interactive cheatsheet tool for the command-line
#          and application launchers
# ---------------------------------------------------------
# https://github.com/denisidoro/navi
# FIXME: Completions not working?
# =========================================================================== #
if [[ "$IS_RASPBERRYPI" == true ]]; then
	zinit wait"2" lucid \
		id-as"navi" \
		has"cargo" \
		make"install \
			SRC_DIR=$ZINIT[PLUGINS_DIR] \
			BIN_DIR=$ZPFX/bin \
			TMP_DIR=$XDG_CACHE_HOME" \
		atload'eval "$(navi widget zsh)";' \
		for @denisidoro/navi
else
	zinit wait"2" lucid \
		id-as"navi" \
		from"gh-r" \
		pick"navi" \
		as"program" \
		atload'eval "$(navi widget zsh)";' \
		for @denisidoro/navi
fi

# =========================================================================== #
# `tldr` - collaborative cheatsheets for console commands
# -------------------------------------------------------
# https://github.com/tldr-pages/tldr
# https://github.com/dbrgn/tealdeer
# =========================================================================== #
zinit wait"0a" lucid \
	id-as"tldr" \
	from"gh-r" \
	mv"tldr* -> tldr" \
	pick"tldr" \
	as"program" \
	for @dbrgn/tealdeer
zinit wait"0b" lucid \
	id-as"tldr-completion" \
	has"tldr" \
	mv"tldr* -> _tldr" \
	as"completion" \
	for https://github.com/dbrgn/tealdeer/blob/master/zsh_tealdeer

# =========================================================================== #
# `cht.sh` - (Cheat.sh) community driven cheat sheets repositories
# ----------------------------------------------------------------
# https://github.com/chubin/cheat.sh
# =========================================================================== #
zinit wait"2a" lucid \
	id-as"cht.sh" \
	has'rlwrap' \
	as"program" \
	atload'export CHTSH="$XDG_CONFIG_HOME"' \
	for https://cht.sh/:cht.sh
zinit wait"2b" lucid \
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
zinit wait"2a" lucid \
	id-as"cheat" \
	from"gh-r" \
	mv"cheat* -> cheat" \
	pick"cheat" \
	as"program" \
	for @cheat/cheat
zinit wait"2b" lucid \
	id-as"cheat-completion" \
	mv"cheat* -> _cheat" \
	as"completion" \
	for https://github.com/cheat/cheat/blob/master/scripts/cheat.zsh

