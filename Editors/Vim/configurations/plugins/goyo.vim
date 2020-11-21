" =========================================================================== "
" Goyo settings
" -------------
" https://github.com/junegunn/goyo.vim
" =========================================================================== "

" Bind toggle Goyo to hotkey
map <F10> :Goyo<CR>

" Integrate with Limelight plugin
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

