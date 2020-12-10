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

" Define themes
let g:theme = {
	\ 'default': 'slate',
	\ 'dark':    'srcery',
	\ 'light':   'PaperColor'
\ }

try
	execute 'colorscheme ' . g:theme.dark
catch
	execute 'colorscheme ' . g:theme.light
endtry

set background=dark

if g:plugins.is_installed('lightline')
	let g:lightline.colorscheme = g:colors_name
endif

