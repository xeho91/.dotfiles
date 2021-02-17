# =========================================================================== #
# `jq` - command-line JSON processor
# ----------------------------------
# https://github.com/stedolan/jq
# ---
# NOTE: Colors configuration in this order:
# "null:false:true:numbers:strings:arrays:objects"
# Source: https://stedolan.github.io/jq/manual/#Colors
# ---
# TODO: Fix adding to man pages
# =========================================================================== #
if [[ $IS_RASPBERRYPI == true ]]; then
	zinit wait lucid \
		id-as"jq" \
		atclone'autoreconf -i; \
			./configure \
				--prefix=$ZPFX \
				--with-oniguruma=builtin \
				--disable-maintainer-mode' \
		atpull"%atclone" \
		make"install" \
		pick"jq/jq" \
		as"program" \
		atload'export JQ_COLORS="1;30:0;31:0;32:0;33:0;37:1;35:1;36"' \
		for stedolan/jq
else
	zinit wait lucid \
		id-as"jq" \
		from"gh-r" \
		pick"jq/jq" \
		as"program" \
		atload'export JQ_COLORS="1;30:0;31:0;32:0;33:0;37:1;35:1;36"' \
		for stedolan/jq
fi

# =========================================================================== #
# `glow` - Terminal based markdown reader
# ---------------------------------------
# https://github.com/charmbracelet/glow
# =========================================================================== #
if [[ $IS_RASPBERRYPI == true ]]; then
	zinit \
		id-as"glow" \
		from"gh-r" \
		bpick"*linux_arm64.tar.gz" \
		pick"glow" \
		as"program" \
		for @charmbracelet/glow
else
	#
fi

# =========================================================================== #
# `nnn` (n³) -the unorthodox terminal file manager
# ------------------------------------------------
# https://github.com/jarun/nnn
# =========================================================================== #
zinit \
	id-as"nnn" \
	make"PREFIX=$ZPFX O_NERD=1 strip install" \
	atload'alias n="nnn"; \
		export NNN_USE_EDITOR=1' \
	for @jarun/nnn

# =========================================================================== #
# `h` - command line tool to highlight terms with colors
# ------------------------------------------------------
# https://github.com/paoloantinori/hhighlighter
# =========================================================================== #
zinit \
	id-as"highlighter" \
	for https://github.com/paoloantinori/hhighlighter/blob/master/h.sh

# =========================================================================== #
# `exa` - modern replacement for `ls`
# -----------------------------------
# https://github.com/ogham/exa
# ---
# NOTE: Latest binaries has chaos with versions? Installed v0.9 but is v0.8
# =========================================================================== #
zinit \
	id-as"exa" \
	from"gh-r" \
	mv"exa-* -> exa" \
	atload'alias exa="exa --git -la"' \
	as"program" \
	for @ogham/exa
zinit \
	id-as"exa-completions" \
	has"exa" \
	mv"exa* -> _exa" \
	as"completion" \
	for https://github.com/ogham/exa/blob/master/completions/completions.zsh

# =========================================================================== #
# `pet` - simple command line snippet manager
# -------------------------------------------
# https://github.com/knqyf263/pet
# ---
# FIXME: Problem with golang compiling
# =========================================================================== #
# zinit \
#     id-as"pet" \
#     has"fzf" \
#     make"install" \
#     for @knqyf263/pet

# =========================================================================== #
# `br` (Broot) - a better way to navigate directories
# ---------------------------------------------------
# https://github.com/Canop/broot
# ---
# NOTE: Requires cargo to build
# =========================================================================== #
# zinit \
#     id-as"broot" \
#     nocompile \
#     atclone"cargo build --release" \
#     atpull"%atclone" \
#     for @Canop/broot

# =========================================================================== #
# `taskwarrior` - CLI task management
# -----------------------------------
# https://github.com/GothenburgBitFactory/taskwarrior
# ---
# NOTE: Is better to install from distribution(s) package repository, as it
#		takes way too long to compile
# =========================================================================== #
zinit wait"1" lucid \
	id-as"taskwarrior" \
	atclone"cmake \
		-DCMAKE_INSTALL_PREFIX=$ZPFX \
		-DCMAKE_BUILD_TYPE=release ." \
	make"install" \
	for @gothenburgbitfactory/taskwarrior
zinit wait"1" lucid \
	id-as"taskwarrior_completion" \
	has"task" \
	as"completion" \
	for https://github.com/GothenburgBitFactory/taskwarrior/blob/2.5.2/scripts/zsh/_task


# =========================================================================== #
# `httpstat` - like `curl -v`, with graphs and colors
# ---------------------------------------------------
# https://github.com/b4b4r07/httpstat/blob/master/httpstat.sh
# =========================================================================== #
zinit wait"1" lucid \
	id-as"httpstat" \
	mv"httpstat.sh -> httpstat" \
	atpull"!git reset --hard" \
	pick"httpstat" \
	as"program" \
	for @b4b4r07/httpstat

# =========================================================================== #
# `trans` - command-line translator using popular online translators
# ------------------------------------------------------------------
# https://github.com/soimort/translate-shell
# =========================================================================== #
zinit wait"1" lucid \
	id-as"trans" \
	nocompile \
	make"PREFIX=$ZPFX install" \
	for @soimort/translate-shell

# =========================================================================== #
# https://github.com/koalaman/shellcheck
# =========================================================================== #
zinit \
	id-as"shellcheck" \
	from"gh-r" \
	mv"shellcheck* -> shellcheck" \
	pick"shellcheck/shellcheck" \
	as"program" \
	for @koalaman/shellcheck

