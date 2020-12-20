# =========================================================================== #
# `vim` (vi improved) - text editor program for unix
# --------------------------------------------------
# https://github.com/vim/vim/
# =========================================================================== #
# zinit \
#     id-as"vim" \
#     atclone'rm -f src/auto/config.cache; \
#         ./configure \
#             --prefix=$ZPFX \
#             --with-features=huge \
#             --with-x \
#             --enable-fail-if-missing \
#             --enable-gui=auto \
#             --enable-multibyte \
#             --enable-cscope \
#             --enable-perlinterp=yes \
#             --enable-python3interp=yes \
#             --enable-rubyinterp=yes \
#             --disable-arabic \
#     ' \
#     atpull"%atclone" \
#     make"install" \
#     pick"src/vim" \
#     as"program" \
#     atload'export EDITOR="vim"; \
#         alias vi=vim' \
#     for @vim/vim

# =========================================================================== #
# `nvim` (neovim) - for of `vim` focused on extensibility and usability
# ---------------------------------------------------------------------
# https://github.com/neovim/neovim
# =========================================================================== #
zinit \
	id-as"nvim" \
	nocompile \
	make!"CMAKE_INSTALL_PREFIX=$ZPFX CMAKE_BUILD_TYPE=Release install" \
	atload'export EDITOR="nvim"; \
		alias nvi="nvim"' \
	for @neovim/neovim

# =========================================================================== #
# SpaceVim - a community driven distribution of (Neo)Vim
# ------------------------------------------------------
# https://github.com/SpaceVim/SpaceVim
# =========================================================================== #
# zinit \
#     id-as"spacevim" \
#     has"vim nvim" \
#     nocompile \
#     atload'export SPACEVIMDIR="$DOTFILES/Editors/Vim/.SpaceVim.d/"; \
#         alias svim="vim -u $ZINIT[PLUGINS_DIR]/spacevim/vimrc"; \
#         alias snvim="nvim -u $ZINIT[PLUGINS_DIR]/spacevim/init.vim"' \
#     for @spacevim/spacevim

