" =========================================================================== "
" CoC (Conquer of Completion) - intellisense engine
" -------------------------------------------------
" https://github.com/neoclide/coc.nvim
" =========================================================================== "

" The location of global configuration
let g:coc_config_home = g:vim_plugins_config_dir_path

" --------------------------------------------------------------------------- "
"                                                           Snippet expansion
" --------------------------------------------------------------------------- "
"
" NOTE: `<SID>` means invoke local function prefixed with `s:<funcname()`
inoremap <silent><expr> <TAB> pumvisible()
	\ ? "\<C-n>"
	\ : <SID>check_back_space()
		\ ? "\<TAB>"
		\ : coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
	let l:col = col('.') - 1
	return !l:col || getline('.')[l:col - 1]  =~# '\s'
endfunction

" let g:coc_snippet_next = '<TAB>'

" Use <C-SPACE> to trigger completion
if has('nvim')
	inoremap <silent><expr> <C-SPACE> coc#refresh()
else
	inoremap <silent><expr> <C-@> coc#refresh()
endif

if g:plugin.is_installed('lexima.vim')
	" Do not imap <CR> ! Otherwise endwise will not work
else
	if exists('*complete_info')
		inoremap <expr> <CR> complete_info()["selected"] != "-1"
			\ ? "\<C-y>"
			\ : "\<C-g>u\<CR>"
	else
		inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
	endif
endif
" " Make <CR> auto-select the first completion item and notify coc.nvim to
" " format on enter, <CR> could be remapped by other vim plugin
" inoremap <silent><expr> <CR> pumvisible()
"     \ ? coc#_select_confirm()
"     \ : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" --------------------------------------------------------------------------- "
"                                                                  Diagnostic
" --------------------------------------------------------------------------- "
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location
" list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" --------------------------------------------------------------------------- "
"                                        Navigation on words under the cursor
" --------------------------------------------------------------------------- "

" Go to code... navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

if g:plugin.is_installed('vim-which-key')
	let g:which_key_g = extend(g:which_key_g, {
		\ 'd': 'code defintion (under the cursor)',
		\ 'y': 'code type definition (under the cursor)',
		\ 'i': 'code implementation (under the cursor)',
		\ 'r': 'code reference (under the cursor)',
	\ })
endif

" --------------------------------------------------------------------------- "
"														        Documentation
" --------------------------------------------------------------------------- "

" Use `K` to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	elseif (coc#rpc#ready())
		call CocActionAsync('doHover')
	else
		execute '!' . &keywordprg . ' ' . expand('<cword>')
	endif
endfunction

" --------------------------------------------------------------------------- "
"                                                       Renaming & Formatting
" --------------------------------------------------------------------------- "

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

" --------------------------------------------------------------------------- "
"                                                                     Autocmd
" --------------------------------------------------------------------------- "

augroup MyCoC
	autocmd!
	" Highlight the symbol and its references when holding the cursor
	autocmd CursorHold * silent call CocActionAsync('highlight')
	" Setup formatexpr specified filetype(s)
	autocmd FileType typescript,json,json5 setl formatexpr=CocAction('formatSelected')
	" Update signature help on jump placeholder
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" --------------------------------------------------------------------------- "
"                                                            CoC Code Actions
" --------------------------------------------------------------------------- "

" Applying codeAction to the selected region
" Example: `<leader>aap` for current paragraph
xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer
nmap <leader>ac <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line
nmap <leader>qf <Plug>(coc-fix-current)

" --------------------------------------------------------------------------- "
"                                             Function and Class text objects
" --------------------------------------------------------------------------- "

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" --------------------------------------------------------------------------- "
"                                              Scrolling float windows/popups
" --------------------------------------------------------------------------- "

" Remap `Ctrl+f` and `Ctrl+b` for scroll float windows/popups
nnoremap <nowait><expr> <C-f> coc#float#has_scroll()
	\ ? coc#float#scroll(1)
	\ : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll()
	\ ? coc#float#scroll(0)
	\ : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll()
	\ ? "\<c-r>=coc#float#scroll(1)\<cr>"
	\ : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll()


" --------------------------------------------------------------------------- "
"                                                            Selection ranges
" --------------------------------------------------------------------------- "

" Use `CTRL-s` for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" --------------------------------------------------------------------------- "
"																     Commands
" --------------------------------------------------------------------------- "

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Add `:Organize` command for organize imports of the current buffer
command! -nargs=0 Organize :call CocAction('runCommand', 'editor.action.organizeImport')

" --------------------------------------------------------------------------- "
"                                                     Mappings for `:CoCList`
" --------------------------------------------------------------------------- "

" Show all diagnostics
nnoremap <silent><nowait> <space>a :<C-u>CocList diagnostics<cr>

" Manage extensions
nnoremap <silent><nowait> <space>e :<C-u>CocList extensions<cr>

" Show commands
nnoremap <silent><nowait> <space>c :<C-u>CocList commands<cr>

" Find symbol of current document
nnoremap <silent><nowait> <space>o :<C-u>CocList outline<cr>

" Search workspace symbols
nnoremap <silent><nowait> <space>s :<C-u>CocList -I symbols<cr>

" Do default action for next item
nnoremap <silent><nowait> <space>j :<C-u>CocNext<CR>

" Do default action for previous item
nnoremap <silent><nowait> <space>k :<C-u>CocPrev<CR>

" Resume latest CoC list
nnoremap <silent><nowait> <space>p :<C-u>CocListResume<CR>

" Open all list options
" nnoremap <silent> <space> :<C-u>CocList<CR>

" =========================================================================== "
" CoC Extensions settings
" -----------------------
" https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions
" =========================================================================== "

" Function to check if extension is installed
function! CoCextension_is_installed(extensionName) abort
	let l:extensions = get(g:, 'coc_global_extensions', {})
	return (count(l:extensions, a:extensionName) != 0)
endfunction

" --------------------------------------------------------------------------- "
"                                                           Global extensions
" --------------------------------------------------------------------------- "
let g:coc_global_extensions = [
	\ 'coc-marketplace',
	\ 'coc-tabnine',
	\ 'coc-snippets',
	\ 'coc-json',
	\ 'coc-format-json'
\ ]

" --------------------------------------------------------------------------- "
"                                                                 Marketplace
" https://github.com/fannheyward/coc-marketplace
" --------------------------------------------------------------------------- "

if CoCextension_is_installed('coc-marketplace')
	" Search CoC marketplace
	nnoremap <silent><nowait> <space>m :<C-u>CocList marketplace<CR>
endif

" --------------------------------------------------------------------------- "
"                                                                     TabNine
" https://github.com/neoclide/coc-tabnine
" --------------------------------------------------------------------------- "

" if CoCextension_is_installed('coc-tabnine')
" endif

" --------------------------------------------------------------------------- "
"                                                                    Snippets
" https://github.com/neoclide/coc-snippets
" --------------------------------------------------------------------------- "

if CoCextension_is_installed('coc-snippets')
	" Use <C-l> for trigger snippet expand
	imap <C-l> <Plug>(coc-snippets-expand)

	" Use <C-j> for select text for visual placeholder of snippetk
	vmap <C-j> <Plug>(coc-snippets-select)

	" Use <C-j> for jump to next placeholder, it's default of coc.nvim
	let g:coc_snippet_next = '<c-j>'

	" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
	let g:coc_snippet_prev = '<c-k>'

	" Use <C-j> for both expand and jump (make expand higher priority)
	imap <C-j> <Plug>(coc-snippets-expand-jump)

	" Use <leader>x for convert visual selected code to snippet
	xmap <leader>x  <Plug>(coc-convert-snippet)

	" Make <tab> used for trigger completion, completion confirm, snippet
	" expand and jump like VSCode
	" inoremap <silent><expr> <TAB>
	"       \ pumvisible() ? coc#_select_confirm() :
	"       \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
	"       \ <SID>check_back_space() ? "\<TAB>" :
	"       \ coc#refresh()
	" function! s:check_back_space() abort
	"       let col = col('.') - 1
	"         return !col || getline('.')[col - 1]  =~# '\s'
	"     endfunction
	"     let g:coc_snippet_next = '<tab>'
	" endfunction
endif

