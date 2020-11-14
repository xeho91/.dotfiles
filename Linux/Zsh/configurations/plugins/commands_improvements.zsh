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
# ---
# NOTE: Latest binaries has chaos with versions & not maintained anymore?
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
zinit ice wait lucid \
	id-as"enhancd" \
	has'fzy' \
	atinit'export ENHANCD_DISABLE_DOT=1; \
		export ENHANCD_DIR="$XDG_CACHE_HOME/.enhancd"' \
	atclone'rm -f *.fish */*.fish' \
	atpull'%atclone' \
	pick"init.sh" \
	as"program"
zinit load b4b4r07/enhancd

# =========================================================================== #
# Completions for `ufw` (Uncomplicated FireWall)
# ----------------------------------------------
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/ufw/
# =========================================================================== #
zinit ice wait lucid \
	as"completion"
zinit snippet OMZP::ufw/_ufw

