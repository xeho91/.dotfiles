" =========================================================================== "
" Vim LSP settings
" ----------------
" https://github.com/mattn/vim-lsp-settings
" =========================================================================== "

" List language servers to install
let g:lsp_settings = {
	\ 'vim-language-server': { 'disabled': v:false },
\ }

let g:lsp_settings_filetype_vim = ['vim-language-server']

" When resolving the root directory for a language server, this plugin will
" look for directories containing special root markers
let g:lsp_settings_root_markers = [
	\ '.git',
	\ '.git/',
	\ '.svn',
	\ '.hg',
	\ '.bzr'
\ ]
