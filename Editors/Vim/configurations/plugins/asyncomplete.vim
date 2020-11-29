" =========================================================================== "
" Asyncomplete settings
" ---------------------
" https://github.com/prabirshrestha/asyncomplete.vim
" =========================================================================== "

" Enable auto popup
let g:asyncomplete_auto_popup = 1

" Allow modifying the completeopt variable, or it will be overridden all the
" time
" let g:asyncomplete_auto_completeopt = 0
" set completeopt=menuone,noinsert,noselect,preview

" Auto close preview window when completion is done
" autocmd! Asyncomplete CompleteDone * if pumvisible() == 0 | pclose | endif

" --------------------------------------------------------------------------- "
"                                                 Languages/FileTypes/Sources
" --------------------------------------------------------------------------- "
augroup AsyncComplete

	" ALE
	" ---
	" https://github.com/prabirshrestha/asyncomplete-emmet.vim
	if has_key(g:plugs, 'asyncomplete-ale.vim')
		autocmd User asyncomplete_setup call asyncomplete#ale#register_source({
			\ 'name': 'reason',
			\ 'linter': 'flow',
		\ })
	endif

	" " Buffer
	" " ------
	" " https://github.com/prabirshrestha/asyncomplete-buffer.vim
	" if has_key(g:plugs, 'asyncomplete-buffer.vim')
	"     autocmd User asyncomplete_setup call asyncomplete#register_source
	"         \ (asyncomplete#sources#buffer#get_source_options({
	"             \ 'name': 'buffer',
	"             \ 'allowlist': ['*'],
	"             \ 'blocklist': ['go'],
	"             \ 'completor': function('asyncomplete#sources#buffer#completor'),
	"             \ 'config': {
	"                 \ 'max_buffer_size': 5000000,
	"             \ },
	"         \ }))
	" endif

	" Emmet
	" -----
	" https://github.com/prabirshrestha/asyncomplete-emmet.vim
	if has_key(g:plugs, 'asyncomplete-emmet.vim')
		autocmd User asyncomplete_setup call asyncomplete#register_source(
			\ asyncomplete#sources#emmet#get_source_options({
				\ 'name': 'emmet',
				\ 'whitelist': ['html'],
				\ 'completor': function('asyncomplete#sources#emmet#completor'),
			\ }))
	endif

augroup END

