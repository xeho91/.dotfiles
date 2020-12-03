" =========================================================================== "
" Goyo settings
" -------------
" https://github.com/junegunn/goyo.vim
" =========================================================================== "

" Bind toggle Goyo to hotkey
map <F10> :Goyo<CR>

" Integrate with Limelight plugin
if g:plugin.is_installed('limelight')
	augroup Goyo
		autocmd! User GoyoEnter Limelight
		autocmd! User GoyoLeave Limelight!
	augroup END
endif

