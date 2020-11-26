" =========================================================================== "
" Vim fugitive settings
" ---------------------
" https://github.com/tpope/vim-fugitive
" =========================================================================== "

" --------------------------------------------------------------------------- "
"                                                                   Lightline
" --------------------------------------------------------------------------- "

" Show current Git branch name in Lightline statusline
function! LightlineGitFugitive()
	let branchName = FugitiveHead()
	return branchName !=# ''
		\ ? 'שׂ '. branchName
		\ : ''
endfunction

