" =========================================================================== "
" Mapping keys
" ------------
" https://vim.fandom.com/wiki/Mapping_keys_in_Vim_-_Tutorial_(Part_1)
" =========================================================================== "

" Bind refreshing configuration to hotkey
map <F5> :RefreshConfig<CR>

" Bind opening configuration file to hotkey
map <F4> :EditConfig<CR>

" Bind hotkey to toggle dark/light theme
map <silent><F12> :let &background = ( &background == "dark"? "light" : "dark" )<CR>

" Bind hotkey to toggle displaying hidden characters (tabs, eol, etc)
" NOTE: To display the key number -> in insert mode press `Ctrl + k` then a
" key combination
" This is CTRL + F12
map <silent><F36> :let &list = ( &list ? 0 : 1 )<CR>

" Bind turning off highlighting to hotkey (":noh" alias)
nnoremap <Leader><Space> :nohlsearch<CR>

" Bind toggling QuickFix List to hotkey
nnoremap <silent><leader>qf :call QuickFixToggle()<cr>
let g:quickFix_is_open = 0
function! QuickFixToggle()
	if g:quickFix_is_open
		cclose
		let g:quickFix_is_open = 0
	else
		copen
		let g:quickFix_is_open = 1
	endif
endfunction

" Bind toggling Location List to hotkey
nnoremap <silent><leader>ll :call LocationListToggle()<cr>
let g:locationList_is_open = 0
function! LocationListToggle()
	if g:locationList_is_open
		lopen
		let g:locationList_is_open = 0
	else
		lclose
		let g:locationList_is_open = 1
	endif
endfunction

