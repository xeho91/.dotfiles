# =========================================================================== #
# `vim` (Vi iMproved) - Text editor program for UNIX
# --------------------------------------------------
# https://github.com/vim/vim/
# =========================================================================== #
zinit ice \
	id-as"vim" \
	atclone'rm -f src/auto/config.cache; \
		./configure \
			--prefix=/usr/local \
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
		alias vi=vim'
zinit load vim/vim
