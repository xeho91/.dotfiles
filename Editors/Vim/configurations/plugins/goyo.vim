" =========================================================================== "
" Goyo settings
" -------------
" https://github.com/junegunn/goyo.vim
" =========================================================================== "

" Bind toggle Goyo to hotkey
map <F10> :Goyo<CR>

" Integrate with Limelight plugin
autocmd! vimrc User GoyoEnter Limelight
autocmd! vimrc User GoyoLeave Limelight!

