" =========================================================================== "
" CtrlSF settings
" ---------------
" https://github.com/dyng/ctrlsf.vim
" =========================================================================== "

let g:which_key_ctrlF = { 'name': 'Find with CtrlSF' }
nmap <C-f>f <Plug>CtrlSFPrompt
let g:which_key_ctrlF['f'] = 'Input `:CtrlSF` in command line'
vmap <C-f>f <Plug>CtrlSFVwordPath
let g:which_key_ctrlF['f'] = 'Input `:CtrlSF <word under cursor>` in command line'
vmap <C-f>F <Plug>CtrlSFVwordExec
nmap <C-f>n <Plug>CtrlSFCwordPath
nmap <C-f>p <Plug>CtrlSFPwordPath
nnoremap <C-f>o :CtrlSFOpen<CR>
nnoremap <C-f>t :CtrlSFToggle<CR>
inoremap <C-f>t <Esc>:CtrlSFToggle<CR>

map <F2> :CtrlSFToggle<CR>
let g:which_key_questionMark['<F2>'] = 'Toggle search results with CtrlSF'

let g:ctrlsf_position = 'right'

let g:ctrlsf_default_view_mode = 'compact'

let g:ctrlsf_auto_focus = {
	\ 'at': 'done',
	\ 'duration_less_than': 1000
\ }


