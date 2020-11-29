" =========================================================================== "
" CtrlP settings
" --------------
" https://github.com/ctrlpvim/ctrlp.vim
" ---
" NOTE: MRU means Most Recently Used
" =========================================================================== "

" Bind to hotkey toggling CtrlP
map <c-p> :CtrlP<CR>

" Show hidden files
let g:ctrlp_show_hidden = 1

" Use custom searcher
if executable('rg')
	let g:ctrlp_user_command = 'rg %s --files --color=never --glob "!.git/*" --hidden'
endif

" Ignore certain directories/files
" NOTE: This doesn't work if custom user command is set
let g:ctrlp_custom_ignore = {
	\ 'dir':  '\v[\/]\.(git|hg|svn)$',
	\ 'file': '\v\.(exe|so|dll)$',
	\ 'link': 'some_bad_symbolic_links'
\ }

" CtrlP will set its local working directory according to this variable
let g:ctrlp_working_path_mode = 'ca'
" Legend:
" `c` - the directory of the current file
" `a` - the directory of the current file, unless it is a subdirectory of the
" cwd
" `r` - the nearest ancestor of the current file that contains one of these
" directories or files: .git .hg .svn .bzr _darcs
" `w` - modifier to "r": start search from the cwd instead of the current
" file`s directory

