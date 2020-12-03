" =========================================================================== "
" EditorConfig settings
" ---------------------
" https://github.com/editorconfig/editorconfig-vim
" =========================================================================== "

" To ensure that this plugin works well with Tim Pope's fugitive
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" Disable for specific filetype
augroup EditorConfig
	autocmd FileType gitcommit let b:EditorConfig_disable = 1
augroup END

