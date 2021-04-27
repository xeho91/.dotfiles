" =========================================================================== "
" Goyo settings
" -------------
" https://github.com/junegunn/goyo.vim
" =========================================================================== "

" Bind toggle Goyo to hotkey
map <F10> :Goyo<CR>

" Integrate with Limelight plugin
if g:plugins.is_installed('limelight')
	augroup Goyo
		autocmd! User GoyoEnter Limelight
		autocmd! User GoyoLeave Limelight!
	augroup END
endif

" Set default width (add what got trimmed by signcolumn?)
let g:goyo_width = 82
" Set default height
let g:goyo_height = '75%'

