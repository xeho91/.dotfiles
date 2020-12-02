" =========================================================================== "
" Vim Gitgutter settings
" ----------------------
" https://github.com/airblade/vim-gitgutter
" =========================================================================== "

" Gitgutter will suppress the signs when a file has more than 500 changes,
" to avoid slowing down the UI
let g:gitgutter_max_signs = -1

" Customize the symbols in signcolumn
if g:enable_icons
	let g:gitgutter_sign_added                   = g:icons.git.added
	let g:gitgutter_sign_modified                = g:icons.git.modified
	let g:gitgutter_sign_removed                 = g:icons.git.removed
	let g:gitgutter_sign_removed_first_line      = g:icons.git.removed_first_line
	let g:gitgutter_sign_removed_above_and_below = g:icons.git.removed_above_and_below
	let g:gitgutter_sign_modified_removed        = g:icons.git.modified_removed
endif

