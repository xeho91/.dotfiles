# =========================================================================== #
# A `cat` clone with wings
# ------------------------
# https://github.com/sharkdp/bat
# =========================================================================== #
zinit ice wait lucid \
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
zinit ice wait lucid \
	as"program" \
	pick"init.sh" \
	atload"export ENHANCD_DISABLE_DOT=1"
zinit light b4b4r07/enhancd

