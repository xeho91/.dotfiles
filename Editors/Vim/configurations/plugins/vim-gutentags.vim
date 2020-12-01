" ========================================================================== "
" GutenTags settings
" ------------------
" https://github.com/ludovicchabant/vim-gutentags
" =========================================================================== "

augroup GutentagsStatusLine
	autocmd User GutentagsUpdating call lightline#update()
	autocmd User GutentagsUpdated call lightline#update()
augroup END

