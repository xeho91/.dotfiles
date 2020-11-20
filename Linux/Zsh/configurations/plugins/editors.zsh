# =========================================================================== #
# `vim` (vi improved) - text editor program for unix
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
			--enable-multibyte \
			--enable-cscope \
			--enable-perlinterp=yes \
			--enable-python3interp=yes \
			--enable-rubyinterp=yes \
			--disable-arabic \
	' \
	atpull"%atclone" \
	make"install" \
	pick"src/vim" \
	as"program" \
	atload'export EDITOR="vim"; \
		alias vi=vim' \
	for @vim/vim

# =========================================================================== #
# `vim` (vi improved) - text editor program for unix
# --------------------------------------------------
# https://github.com/vim/vim/
# ---
# NOTE: Requires:
# ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip
# =========================================================================== #
zinit \
	id-as"nvim" \
	nocompile \
	make!"CMAKE_INSTALL_PREFIX=$ZPFX CMAKE_BUILD_TYPE=Release install" \
	atload'export EDITOR="nvim"; \
		alias nvi="nvim"' \
	for @neovim/neovim

	# from'gh-r' \
	# ver'nightly' \
	# atclone'echo "" > ._zinit/is_release' \
	# atpull'%atclone' \
	# run-atpull \
	# pick'nvim*/bin/nvim' \
	# as'program' \
