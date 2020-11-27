scriptencoding utf-8

" =========================================================================== "
" Vim Gitgutter settings
" ----------------------
" https://github.com/airblade/vim-gitgutter
" =========================================================================== "

" Gitgutter will suppress the signs when a file has more than 500 changes,
" to avoid slowing down the UI
let g:gitgutter_max_signs = -1

" Customize the symbols in signcolumn
let g:gitgutter_sign_added = ''
let g:gitgutter_sign_modified = ''
let g:gitgutter_sign_removed = ''
let g:gitgutter_sign_removed_first_line = 'ﬢ'
let g:gitgutter_sign_removed_above_and_below = ''
let g:gitgutter_sign_modified_removed = ''

" Show Git summary with `GitGutter` in the statusline with `lightline` plugin
function! LightlineGitGutter()
	if winwidth(0) > 160
		let [l:added, l:modified, l:removed] = GitGutterGetHunkSummary()
		if l:added == 0 && l:modified == 0 && l:removed == 0
			return ''
		endif
		return printf('%d %d %d', l:added, l:modified, l:removed)
	else
		return ''
	endif
endfunction

