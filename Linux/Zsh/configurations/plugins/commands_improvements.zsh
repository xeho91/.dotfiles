# =========================================================================== #
# A `cat` clone with wings
# ------------------------
# https://github.com/sharkdp/bat
# =========================================================================== #
zinit ice wait lucid \
	id-as"bat" \
	as"program" \
	from"gh-r" \
	mv"bat* -> bat" \
	atclone'mv bat/autocomplete/bat.zsh bat/autocomplete/_bat' \
	pick"bat/bat" \
	atload'alias cat="bat"'
zinit load sharkdp/bat

# =========================================================================== #
# The next generation 'ls' command
# --------------------------------
# https://github.com/Peltoche/lsd
# =========================================================================== #
zinit ice wait lucid \
	id-as"lsd" \
	as"program" \
	from"gh-r" \
	mv"lsd* -> lsd" \
	pick"lsd/lsd" \
	atload'alias ls="lsd"'
zinit load Peltoche/lsd

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
	as"program" \
	mv"fd* -> fd" \
	pick"fd/fd"
zinit light sharkdp/fd