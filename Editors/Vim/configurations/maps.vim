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

" Bind turning off highlighting to hotkey (":noh" alias)
nnoremap <Leader><Space> :nohlsearch<CR>

