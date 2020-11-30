" ========================================================================== "
" GutenTags settings
" ------------------
" https://github.com/ludovicchabant/vim-gutentags
" =========================================================================== "

augroup MyGutentagsStatusLineRefresher
	autocmd!
	autocmd User GutentagsUpdating call lightline#update()
	autocmd User GutentagsUpdated call lightline#update()
augroup END

