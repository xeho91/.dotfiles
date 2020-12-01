" =========================================================================== "
" Theme settings
" --------------
" https://vimcolorschemes.com/
" =========================================================================== "

" Expand colors in terminal using GUI
if (has('termguicolors'))
	set termguicolors
endif

" Enable syntax highlight
syntax enable

" Set theme(s)
let g:default_theme = 'slate'
let g:dark_theme = 'srcery'
let g:light_theme = 'PaperColor'
try
	colorscheme srcery
	set background=dark
catch
	colorscheme slate
endtry

function! ChangeTheme()
	if g:colors_name ==# g:dark_theme
		colorscheme PaperColor
		set background=light
	else
		colorscheme srcery
		set background=dark
	endif
endfunction

if has_key(g:plugs, 'lightline.vim')
	let g:lightline.colorscheme = g:colors_name
endif

