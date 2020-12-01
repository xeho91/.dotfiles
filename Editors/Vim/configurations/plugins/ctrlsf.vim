" =========================================================================== "
" CtrlSF settings
" ---------------
" https://github.com/dyng/ctrlsf.vim
" =========================================================================== "

" Bind to hotkeys for better experience
nmap <C-F>f <Plug>CtrlSFPrompt
vmap <C-F>f <Plug>CtrlSFVwordPath
vmap <C-F>F <Plug>CtrlSFVwordExec
nmap <C-F>n <Plug>CtrlSFCwordPath
nmap <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>

map <F2> :CtrlSFToggle<CR>

let g:ctrlsf_default_view_mode = 'compact'

let g:ctrlsf_auto_focus = {
	\ 'at': 'done',
	\ 'duration_less_than': 1000
\ }
