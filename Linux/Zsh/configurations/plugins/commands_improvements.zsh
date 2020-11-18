# =========================================================================== #
# A `cat` clone with wings
# ------------------------
# https://github.com/sharkdp/bat
# =========================================================================== #
zinit \
	id-as"bat" \
	from"gh-r" \
	mv"bat* -> bat" \
	atclone'mv bat/autocomplete/bat.zsh bat/autocomplete/_bat' \
	atpull'%atclone' \
	pick"bat/bat" \
	as"program" \
	atload'alias cat="bat"' \
	for @sharkdp/bat

# =========================================================================== #
# The next generation 'ls' command
# --------------------------------
# https://github.com/Peltoche/lsd
# =========================================================================== #
zinit \
	id-as"lsd" \
	from"gh-r" \
	mv"lsd* -> lsd" \
	pick"lsd/lsd" \
	as"program" \
	atload'alias ls="lsd"' \
	for @Peltoche/lsd

# =========================================================================== #
# A next-generation 'cd' command with installed interactive filter
# ----------------------------------------------------------------
# https://github.com/b4b4r07/enhancd
# =========================================================================== #
zinit \
	id-as"enhancd" \
	has"fzy" \
	nocompile \
	atinit'export ENHANCD_DISABLE_DOT=1; \
		export ENHANCD_DIR="$XDG_CACHE_HOME/.enhancd"' \
	atclone'rm -f *.fish */*.fish' \
	atpull"%atclone" \
	src"init.sh" \
	for @b4b4r07/enhancd

# =========================================================================== #
# `procs` - a modern replacement for `ps`
# ---------------------------------------
# https://github.com/dalance/procs
# =========================================================================== #
zinit \
	id-as"procs" \
	atclone"cargo build --release" \
	atpull"%atclone" \
	pick"target/release/procs" \
	as"program" \
	atload'alias ps="procs"' \
	for @dalance/procs

# =========================================================================== #
# package of completions for existing linux commands
# --------------------------------------------------
# https://github.com/zsh-users/zsh-completions
# =========================================================================== #
zinit \
	id-as"zsh-completions" \
	blockf \
	for @zsh-users/zsh-completions


# =========================================================================== #
# `colormake` - colorize the `make` output for better readability
# ---------------------------------------------------------------
# https://github.com/pagekite/Colormake
# =========================================================================== #
zinit \
	id-as"colormake" \
	atclone"mv colormake.1 $ZPFX/man/man1" \
	pick"colormake" \
	as"program" \
	atload'alias make="colormake"' \
	for @pagekite/Colormake

