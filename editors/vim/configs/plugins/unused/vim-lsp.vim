" ========================================================================== "
" Vim LSP (Language Server Protocol) settings
" -------------------------------------------
" https://github.com/prabirshrestha/vim-lsp
" =========================================================================== "

function! s:on_lsp_buffer_enabled() abort
	setlocal omnifunc=lsp#complete
	setlocal signcolumn=yes
	if exists('+tagfunc')
		setlocal tagfunc=lsp#tagfunc
	endif
	nmap <buffer> gd <plug>(lsp-definition)
	nmap <buffer> gr <plug>(lsp-references)
	nmap <buffer> gi <plug>(lsp-implementation)
	nmap <buffer> gtd <plug>(lsp-type-definition)
	nmap <buffer> <leader>rn <plug>(lsp-rename)
	nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
	nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
	nmap <buffer> K <plug>(lsp-hover)
endfunction

augroup lsp_install
	autocmd!
	" call s:on_lsp_buffer_enabled only for languages that has the server
	" registered.
	autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()

" Let the language server automatically handle folding
" set foldmethod=expr
"   \ foldexpr=lsp#ui#vim#folding#foldexpr()
"   \ foldtext=lsp#ui#vim#folding#foldtext()

highlight link LspErrorText GruvboxRedSign
highlight clear LspWarningLine

" Highlight references to the symbol under the cursor
let g:lsp_highlight_references_enabled = 1

