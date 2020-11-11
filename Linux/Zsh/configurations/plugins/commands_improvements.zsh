# =========================================================================== #
# A `cat` clone with wings
# ------------------------
# https://github.com/sharkdp/bat
# =========================================================================== #
zinit ice wait lucid \
	id-as"bat" \
	from"gh-r" \
	mv"bat* -> bat" \
	atclone'mv bat/autocomplete/bat.zsh bat/autocomplete/_bat' \
	atpull'%atclone' \
	pick"bat/bat" \
	as"program" \
	atload'alias cat="bat"'
zinit load sharkdp/bat

# =========================================================================== #
# The next generation 'ls' command
# --------------------------------
# https://github.com/Peltoche/lsd
# =========================================================================== #
zinit ice wait lucid \
	id-as"lsd" \
	from"gh-r" \
	mv"lsd* -> lsd" \
	pick"lsd/lsd" \
	as"program" \
	atload'alias ls="lsd"'
zinit load Peltoche/lsd

# =========================================================================== #
# `exa` - modern replacement for `ls`
# -----------------------------------
# https://github.com/ogham/exa
# NOTE: Wrong version & not maintained anymore?
# =========================================================================== #
# zinit ice wait lucid \
#     id-as"exa" \
#     from"gh-r" \
#     mv"exa-* -> exa" \
#     as"program"
# zinit load ogham/exa
# zinit ice \
#     mv"comp* -> _exa" \
#     as"completion"
# zinit snippet "https://github.com/ogham/exa/blob/master/completions/completions.zsh"

# =========================================================================== #
# A next-generation 'cd' command with installed interactive filter
# ----------------------------------------------------------------
# https://github.com/b4b4r07/enhancd
# =========================================================================== #
# FIXME:
# zinit ice wait lucid \
#     has'fzy' \
#     id-as"enhancd" \
#     as"program" \
#     atclone'rm -f *.fish */*.fish' \
#     pick"init.sh" \
#     as"program" \
#     atload'export ENHANCD_DISABLE_DOT=1'
# zinit light b4b4r07/enhancd

# =========================================================================== #
# `fd` -  simple, fast and user-friendly alternative to `find`
# ------------------------------------------------------------
# https://github.com/sharkdp/fd
# =========================================================================== #
zinit ice \
	if'[[ -v $LS_COLORS ]]' \
	id-as"fd" \
	from"gh-r" \
	mv"fd* -> fd" \
	pick"fd/fd" \
	as"program"
zinit light sharkdp/fd

# =========================================================================== #
# `ag` - code-searching tool similar to `ack`, but faster
# -------------------------------------------------------
# https://github.com/ggreer/the_silver_searcher
# =========================================================================== #
zinit ice \
	id-as"ag" \
	atclone'./build.sh; \
		./configure --prefix=$ZPFX' \
	atpull'%atclone' \
	make'install' \
	pick"$ZPFX/bin/ag" \
	as"program"
zinit load ggreer/the_silver_searcher

