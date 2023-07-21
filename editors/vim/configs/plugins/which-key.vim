" =========================================================================== "
" Which Key settings
" ------------------
" https://github.com/liuchengxu/vim-which-key
" =========================================================================== "

" Set timeout to wait for popup - default is 1000 ms
set timeoutlen=1000

" let g:which_key_ctrlF = { 'name': 'Find with CtrlSF' }
" nnoremap <C-f> :<c-u>WhichKey "CtrlF"<CR>

augroup WhichKey
	autocmd User which-key call
		\ which_key#register('?', 'g:which_key_questionMark')
	autocmd User which-key call
		\ which_key#register(g:mapleader, 'g:which_key_leader')
	autocmd User which-key call
		\ which_key#register(g:maplocalleader, 'g:which_key_localLeader')
	autocmd User which-key call
		\ which_key#register('g', 'g:which_key_g')
	" autocmd User vim-which-key call
	"     \ which_key#register('CtrlF', 'g:which_key_ctrlF')
augroup END
