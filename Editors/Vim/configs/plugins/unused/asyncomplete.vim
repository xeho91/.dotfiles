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
set completeopt=menuone,noinsert,noselect,preview

" Tab completion
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

" --------------------------------------------------------------------------- "
"                                                 Languages/FileTypes/Sources
" --------------------------------------------------------------------------- "
augroup AsyncComplete

	" Auto close preview window when completion is done
	autocmd! completedone * if pumvisible() == 0 | pclose | endif

	" ALE
	" ---
	" https://github.com/prabirshrestha/asyncomplete-emmet.vim
	if has_key(g:plugs, 'asyncomplete-ale.vim')
		autocmd User asyncomplete_setup call asyncomplete#ale#register_source({
			\ 'name': 'reason',
			\ 'linter': 'flow',
		\ })
	endif

	" Buffer
	" ------
	" https://github.com/prabirshrestha/asyncomplete-buffer.vim
	if has_key(g:plugs, 'asyncomplete-buffer.vim')
		autocmd User asyncomplete_setup call asyncomplete#register_source(
			\ asyncomplete#sources#buffer#get_source_options({
				\ 'name': 'buffer',
				\ 'allowlist': ['*'],
				\ 'blocklist': ['go'],
				\ 'completor': function('asyncomplete#sources#buffer#completor'),
				\ 'config': {
					\ 'max_buffer_size': 5000000,
				\ },
		\ }))
	endif

	" Dictionary (look)
	" -----------------
	" https://github.com/htlsne/asyncomplete-look
	if has_key(g:plugs, 'asyncomplete-look')
		autocmd User asyncomplete_setup call asyncomplete#register_source({
		    \ 'name': 'look',
		    \ 'allowlist': ['text', 'markdown'],
		    \ 'completor': function('asyncomplete#sources#look#completor'),
		\ })
	endif

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

	" Emoji
	" ------
	" https://github.com/prabirshrestha/asyncomplete-emoji.vim
	if has_key(g:plugs, 'asyncomplete-emoji.vim')
		autocmd User asyncomplete_setup call asyncomplete#register_source(
			\ asyncomplete#sources#emoji#get_source_options({
				\ 'name': 'emoji',
				\ 'allowlist': ['*'],
				\ 'completor': function('asyncomplete#sources#emoji#completor'),
		\ }))
	endif

	" Filenames / directories
	" -----------------------
	" https://github.com/prabirshrestha/asyncomplete-file.vim
	if has_key(g:plugs, 'asyncomplete-file.vim')
		autocmd User asyncomplete_setup call asyncomplete#register_source(
			\ asyncomplete#sources#file#get_source_options({
				\ 'name': 'file',
				\ 'allowlist': ['*'],
				\ 'priority': 10,
				\ 'completor': function('asyncomplete#sources#file#completor')
		\ }))
	endif

	" Git commit message
	" ------------------
	" https://github.com/laixintao/asyncomplete-gitcommit
	if has_key(g:plugs, 'asyncomplete-gitcommit')
		autocmd User asyncomplete_setup call asyncomplete#register_source({
			\ 'name': 'gitcommit',
			\ 'whitelist': ['gitcommit'],
			\ 'priority': 10,
			\ 'completor': function('asyncomplete#sources#gitcommit#completor')
		\ })
	endif

	" UltiSnips
	" ---------
	" https://github.com/prabirshrestha/asyncomplete-ultisnips.vim
	if has_key(g:plugs, 'asyncomplete-ultisnips.vim')
		autocmd User asyncomplete_setup call asyncomplete#register_source(
			\ asyncomplete#sources#ultisnips#get_source_options({
		        \ 'name': 'ultisnips',
		        \ 'allowlist': ['*'],
		        \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
		\ }))
	endif

	" GutenTags
	" ---------
	" https://github.com/prabirshrestha/asyncomplete-tags.vim
	if has_key(g:plugs, 'asyncomplete-tags.vim')
		autocmd User asyncomplete_setup call asyncomplete#register_source(
			\ asyncomplete#sources#tags#get_source_options({
				\ 'name': 'tags',
				\ 'allowlist': ['c'],
				\ 'completor': function('asyncomplete#sources#tags#completor'),
				\ 'config': {
					\ 'max_file_size': 5000000,
				\ }
		\ }))
	endif

augroup END

