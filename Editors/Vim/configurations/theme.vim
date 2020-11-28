" =========================================================================== "
" Theme settings
" ---
" https://vimcolorschemes.com/
" =========================================================================== "

" Expand colors in terminal using GUI
if (has('termguicolors'))
	set termguicolors
endif

" Enable syntax highlight
syntax enable

" Set theme
try
	colorscheme gruvbox
catch
	colorscheme slate
endtry

" Set mode (light/dark)
set background=dark

