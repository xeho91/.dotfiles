 " =============================================================================
 " CoC (Conquer of Completion) - intellisense engine
 " -------------------------------------------------
 " https://github.com/neoclide/coc.nvim
 " =============================================================================

 " TextEdit might fail if hidden is not set
 set hidden
 "
 " Give more space for displaying messages
 set cmdheight=2
 "
 " Don't pass messages to |ins-completion-menu|
 set shortmess+=c
 "
 " Always show the signcolumn, otherwise it would shift the text each time
 " diagnostics appear/become resolved
 set signcolumn=yes
 "
 " Global extensions
 " -----------------
 " https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions#implemented-coc-extensions
 let g:coc_global_extensions = [
	 \ 'coc-marketplace',
	 \ 'coc-tabnine',
	 \ 'coc-snippets',
	 \ 'coc-git'
 \ ]
 "
 " Snippet expansion
 " -----------------
 " Configure snippet completion to work similarly to VSCode
 inoremap <silent><expr> <TAB>
	 \ pumvisible()
		 \ ? coc#_select_confirm()
		 \ : coc#expandableOrJumpable()
			 \ ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>"
			 \ : <SID>check_back_space()
				 \ ? "\<TAB>"
				 \ : coc#refresh()
 inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
 "
 function! s:check_back_space() abort
	 let col = col('.') - 1
	 return !col || getline('.')[col - 1]  =~# '\s'
 endfunction
 "
 let g:coc_snippet_next = '<tab>'
 "
 " Use <c-space> to trigger completion
 inoremap <silent><expr> <c-space> coc#refresh()
 "
 " Make <CR> auto-select the first completion item and notify coc.nvim to
 " format on enter, <CR> could be remapped by other vim plugin
 inoremap <silent><expr> <cr> pumvisible()
	 \ ? coc#_select_confirm()
	 \ : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
 "
 " Diagnostic
 " ----------
 " Use `[g` and `]g` to navigate diagnostics
 " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
 nmap <silent> [g <Plug>(coc-diagnostic-prev)
 nmap <silent> ]g <Plug>(coc-diagnostic-next)
 "
 " Navigation on words under the cursor
 " ------------------------------------
 " GoTo code navigation
 nmap <silent> gd <Plug>(coc-definition)
 nmap <silent> gy <Plug>(coc-type-definition)
 nmap <silent> gi <Plug>(coc-implementation)
 nmap <silent> gr <Plug>(coc-references)
 "
 " Documentation
 " -------------
 " Use K to show documentation in preview window
 nnoremap <silent> K :call <SID>show_documentation()<CR>
 "
 function! s:show_documentation()
	 if (index(['vim','help'], &filetype) >= 0)
		 execute 'h '.expand('<cword>')
	 elseif (coc#rpc#ready())
		 call CocActionAsync('doHover')
	 else
		 execute '!' . &keywordprg . " " . expand('<cword>')
	 endif
 endfunction
 "
 " Highlight the symbol and its references when holding the cursor
 autocmd CursorHold * silent call CocActionAsync('highlight')
 "
 " Symbol renaming
 nmap <leader>rn <Plug>(coc-rename)
 "
 " Formatting selected code
 xmap <leader>f <Plug>(coc-format-selected)
 nmap <leader>f <Plug>(coc-format-selected)
 "
 augroup mygroup
	 autocmd!
	 " Setup formatexpr specified filetype(s)
	 autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
	 " Update signature help on jump placeholder
	 autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
 augroup end
 "
 " Applying codeAction to the selected region
 " Example: `<leader>aap` for current paragraph
 xmap <leader>a <Plug>(coc-codeaction-selected)
 nmap <leader>a <Plug>(coc-codeaction-selected)
 "
 " Remap keys for applying codeAction to the current buffer
 nmap <leader>ac <Plug>(coc-codeaction)
 " Apply AutoFix to problem on the current line
 nmap <leader>qf <Plug>(coc-fix-current)
 "
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
 "
 " Remap <C-f> and <C-b> for scroll float windows/popups
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
	 \ ? "\<c-r>=coc#float#scroll(0)\<cr>"
	 \: "\<Left>"
 "
 " Use CTRL-S for selections ranges
 " Requires 'textDocument/selectionRange' support of language server.
 nmap <silent> <C-s> <Plug>(coc-range-select)
 xmap <silent> <C-s> <Plug>(coc-range-select)
 "
 " Commands
 " --------
 " Add `:Format` command to format current buffer
 command! -nargs=0 Format :call CocAction('format')
 "
 " Add `:Fold` command to fold current buffer
 command! -nargs=? Fold :call CocAction('fold', <f-args>)
 "
 " Add `:Organize` command for organize imports of the current buffer
 command! -nargs=0 Organize :call CocAction('runCommand', 'editor.action.organizeImport')
 "
 " Mappings for CoCList
 " --------------------
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

