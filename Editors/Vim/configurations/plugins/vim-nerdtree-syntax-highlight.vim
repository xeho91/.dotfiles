" =========================================================================== "
" Vim-Plug settings
" -----------------
" https://github.com/tiagofumo/vim-nerdtree-syntax-highlight
" =========================================================================== "

" Disable unmatched folder and file icons having the same color as their labels
" (normally green and white), if set by this plugin (it could have been set by
" some other plugin which is being used)
let g:WebDevIconsDisableDefaultFolderSymbolColorFromNERDTreeDir = 0
let g:WebDevIconsDisableDefaultFileSymbolColorFromNERDTreeFile = 0

" Disable highlight
let g:NERDTreeDisableFileExtensionHighlight = 0
let g:NERDTreeDisableExactMatchHighlight = 0
let g:NERDTreeDisablePatternMatchHighlight = 0

" Highlight full name (not only icons)
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

" Highlight folders using exact match
let g:NERDTreeHighlightFolders = 1
let g:NERDTreeHighlightFoldersFullName = 1

" Disable uncommon file extensions highlighting (prevents lags)
let g:NERDTreeLimitedSyntax = 0
let g:NERDTreeHighlightCursorline = 0

" Disable all default file highlighting
let g:NERDTreeSyntaxDisableDefaultExtensions = 0
let g:NERDTreeSyntaxDisableDefaultExactMatches = 0
let g:NERDTreeSyntaxDisableDefaultPatternMatches = 0

" Customize which file extensions are enabled
" set g:NERDTreeExtensionHighlightColor if you want a custom color instead of
" the default one
" let g:NERDTreeSyntaxEnabledExtensions = ['hbs', 'lhs'] " enable highlight to
" .hbs and .lhs files with default colors
" let g:NERDTreeSyntaxEnabledExactMatches = ['dropbox', 'node_modules',
" 'favicon.ico'] " enable highlight for dropbox and node_modules folders, and
" favicon.ico files with default colors"

