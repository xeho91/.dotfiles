# =========================================================================== #
# `vim` (Vi iMproved) - Text editor program for UNIX
# --------------------------------------------------
# https://github.com/vim/vim/
# =========================================================================== #
zinit \
	id-as"vim" \
	atclone'rm -f src/auto/config.cache; \
		./configure \
			--prefix=$ZPFX \
			--with-features=huge \
			--with-x \
			--enable-fail-if-missing \
			--enable-gui=auto \
			--enable-gtk2-check \
			--enable-multibyte \
			--enable-cscope \
			--enable-luainterp=yes \
			--enable-perlinterp=yes \
			--enable-pythoninterp=yes \
			--enable-python3interp=yes \
			--enable-rubyinterp=yes \
			--disable-arabic \
	' \
	atpull"%atclone" \
	make"install" \
	pick"src/vim" \
	as"program" \
	atload'export VIMRUNTIME="$ZINIT[PLUGINS_DIR]/vim/runtime"; \
		alias vi=vim' \
	for @vim/vim

# zinit wait'0' lucid \
#     from'gh-r' ver'nightly' as'program' pick'nvim*/bin/nvim' \
#     atclone'echo "" > ._zinit/is_release' \
#     atpull'%atclone' \
#     run-atpull \
#     light-mode for @neovim/neovim

