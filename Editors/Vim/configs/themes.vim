" =========================================================================== "
" Theme settings
" --------------
" https://vimcolorschemes.com/
" =========================================================================== "

" Expand colors in terminal using GUI
if (has('termguicolors'))
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

	set termguicolors
endif

" Enable syntax highlight
syntax enable

" Define themes
let g:theme = {
	\ 'dark': 'spaceduck',
	\ 'light': ''
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

if g:plugins.is_installed('lualine')
	let g:lualine.options.theme = g:colors_name
endif
