" =========================================================================== "
" Which Key settings
" ------------------
" https://github.com/liuchengxu/vim-which-key
" =========================================================================== "

" Set timeout to wait for popup - default is 1000 ms
set timeoutlen=1000

augroup WhichKey
	autocmd User vim-which-key call
		\ which_key#register('?', 'g:which_key_questionMark')
	autocmd User vim-which-key call
		\ which_key#register('\', 'g:which_key_leader')
	autocmd User vim-which-key call
		\ which_key#register(g:maplocalleader, 'g:which_key_localLeader')
	autocmd User vim-which-key call
		\ which_key#register('g', 'g:which_key_g')
augroup END

