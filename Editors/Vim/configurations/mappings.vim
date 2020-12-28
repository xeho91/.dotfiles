" =========================================================================== "
" Mapping keys
" ------------
" https://vim.fandom.com/wiki/Mapping_keys_in_Vim_-_Tutorial_(Part_1)
" =========================================================================== "

let g:which_key_questionMark = { 'name': 'Mapped keys for general usage' }
nnoremap <silent> ? :<C-u>WhichKey '?'<CR>

" --------------------------------------------------------------------------- "
"                                                                General keys
" --------------------------------------------------------------------------- "

" Esc
" ---
let g:which_key_questionMark['Esc'] = 'Close this help'

" --------------------------------------------------------------------------- "
"                                                                  Ctrl + ...
" --------------------------------------------------------------------------- "

" Ctrl + /
" --------
if g:plugins.is_installed('nerdcommenter')
	nmap <C-_> <Plug>NERDCommenterToggle
	vmap <C-_> <Plug>NERDCommenterToggle<CR>gv
	let g:which_key_questionMark['<C-/>'] = '[Plugin] (Un)comment line (`NERDCommenter`)'
endif

" Ctrl + j
" Ctrl + k
" --------
if g:plugins.is_installed('ale')
	nmap <silent> <C-j> <Plug>(ale_next_wrap)
	let g:which_key_questionMark['<C-j>'] = '[Plugin] Go to next problem (`ALE`)'
	nmap <silent> <C-k> <Plug>(ale_previous_wrap)
	let g:which_key_questionMark['<C-k>'] = '[Plugin] Go to previous problem (`ALE`)'
endif

" Ctrl + p
" --------
if g:plugins.is_installed('fzf')
	nnoremap <C-p> :<C-u>OpenFileSearch<CR>
	let g:which_key_questionMark['<C-p>'] = '[Plugin] Open file search (`fzf.vim`)'
endif

" --------------------------------------------------------------------------- "
"                                                  Functional keys `<F1..12>`
" --------------------------------------------------------------------------- "

" F1
" --
nnoremap <F1> :ToggleHelp<CR>
imap <F1> <Esc><F1>
let g:which_key_questionMark['<F1>'] = "Open help (editor's manual) in the split window"

" F2
" --
if g:plugins.is_installed('ctrlsf')
	nnoremap <F2> :CtrlSFToggle<CR>
	let g:which_key_questionMark['<F2>'] = '[Plugin] Toggle search results (`CtrlSF`)'
endif

" F3
" --
if g:plugins.is_installed('nerdtree')
	nnoremap <F3> :NERDTreeToggle<CR>
	let g:which_key_questionMark['<F3>'] = '[Plugin] Toggle file explorer (`NERDtree`)'
endif

" F4
" --
nnoremap <F4> :EditConfig<CR>
let g:which_key_questionMark['<F4>'] = "Edit editor's configuration"

" F5
" --
nnoremap <F5> :RefreshConfig<CR>
let g:which_key_questionMark['<F5>'] = "Refresh editor's configuration"

" F6
" --
if g:plugins.is_installed('mundo')
	nnoremap <F6> :MundoToggle<CR>
	let g:which_key_questionMark['<F6>'] = '[Plugin] Toggle edit history (`Mundo`)'
endif

" F7
" --

" F8
" --
if g:plugins.is_installed('vista')
	nnoremap <F8> :Vista!!<CR>
	let g:which_key_questionMark['<F8>'] = '[Plugin] Toggle tags & symbols viewer (`Vista`)'
endif

" F12
" ---
nnoremap <F12> :ChangeTheme<CR>
let g:which_key_questionMark['<F12>'] = 'Change theme (to dark/light)'

" --------------------------------------------------------------------------- "
"								            Functional keys `<Ctrl + F1..12>`
" --------------------------------------------------------------------------- "
" NOTE: To display the key number -> in insert mode press `Ctrl + k` then a
" key combination

" map <silent> <F25> <CR>
" let g:which_key_questionMark['<C-F1'] = ''
" map <silent> <F26> <CR>
" let g:which_key_questionMark['<C-F2'] = ''
" map <silent> <F27> <CR>
" let g:which_key_questionMark['<C-F3'] = ''
" map <silent> <F28> <CR>
" let g:which_key_questionMark['<C-F4'] = ''
" map <silent> <F29> <CR>
" let g:which_key_questionMark['<C-F5'] = ''
" map <silent> <F30> <CR>
" let g:which_key_questionMark['<C-F6'] = ''
" map <silent> <F31> <CR>
" let g:which_key_questionMark['<C-F7'] = ''
" map <silent> <F32> <CR>
" let g:which_key_questionMark['<C-F8'] = ''
" map <silent> <F33> <CR>
" let g:which_key_questionMark['<C-F9'] = ''
" map <silent> <F34> <CR>
" let g:which_key_questionMark['<C-F10'] = ''
" map <silent> <F35> <CR>
" let g:which_key_questionMark['<C-F11'] = ''

" Bind hotkey to toggle displaying hidden characters (tabs, eol, etc)
map <silent> <F36> :ToggleList<CR>
let g:which_key_questionMark['<C-F12>'] = 'Toggle displaying hidden characters'

" --------------------------------------------------------------------------- "
"                                             Custom maps added to `<Leader>`
" --------------------------------------------------------------------------- "

let g:which_key_leader = {
	\ 'name': '<Leader> key is `' . g:mapleader . '`',
	\ 't': { 'name': '+Toggle...' }
\ }

" Turn off search pattern highlighting
nnoremap <Leader>ts :TogglePatternSearchHighlight<CR>
let g:which_key_leader.t['s'] = 'Search pattern highlight'

" Toggling QuickFix List
nnoremap <Leader>tq :ToggleQuickFixList<CR>
let g:which_key_leader.t['q'] = 'QuickFix list'

" Toggling Location List
nnoremap <Leader>tl :ToggleLocationList<CR>
let g:which_key_leader.t['l'] = 'Location list'

nnoremap <Leader>      :<c-u>WhichKey g:mapleader<CR>
" nnoremap <LocalLeader> :<c-u>WhichKey g:maplocalleader<CR>

" =========================================================================== "
" Definitions for default keys
" =========================================================================== "

" --------------------------------------------------------------------------- "
"													            `g` (Goto...)
" --------------------------------------------------------------------------- "
let g:which_key_g = { 'name': 'Goto...' }
nnoremap <silent><nowait> [G] :<C-u>WhichKey 'g'<CR>
nmap g [G]

let g:which_key_g['<C-g>']  = 'show cursor info'
nnoremap g<C-g> g<C-g>
let g:which_key_g['&']      = 'repeat last ":s" on all lines'
nnoremap g& g&
let g:which_key_g["'"]      = 'jump to mark'
nnoremap g' g'
let g:which_key_g['`']      = 'jump to mark'
nnoremap g` g`
let g:which_key_g['+']      = 'newer text state'
nnoremap g+ g+
let g:which_key_g['-']      = 'older text state'
nnoremap g- g-
let g:which_key_g[',']      = 'newer position in change list'
nnoremap g, g,
let g:which_key_g[';']      = 'older position in change list'
nnoremap g; g;
let g:which_key_g['@']      = 'call operatorfunc'
nnoremap g@ g@
let g:which_key_g['#']      = 'search under cursor backward'
let g:which_key_g['*']      = 'search under cursor forward'
let g:which_key_g['/']      = 'stay incsearch'
let g:which_key_g['$']      = 'go to rightmost character'
nnoremap g$ g$
let g:which_key_g['<End>']  = 'go to rightmost character'
nnoremap g<End> g<End>
let g:which_key_g['0']      = 'go to leftmost character'
nnoremap g0 g0
let g:which_key_g['<Home>'] = 'go to leftmost character'
nnoremap g<Home> g<Home>
let g:which_key_g['e']      = 'go to end of previous word'
nnoremap ge ge
let g:which_key_g['<']      = 'last page of previous command output'
nnoremap g< g<
let g:which_key_g['f']      = 'edit file under cursor'
nnoremap gf gf
let g:which_key_g['F']      = 'edit file under cursor(jump to line after name)'
nnoremap gF gF
let g:which_key_g['j']      = 'move cursor down screen line'
nnoremap gj gj
let g:which_key_g['k']      = 'move cursor up screen line'
nnoremap gk gk
let g:which_key_g['u']      = 'make motion text lowercase'
nnoremap gu gu
let g:which_key_g['E']      = 'end of previous word'
nnoremap gE gE
let g:which_key_g['U']      = 'make motion text uppercase'
nnoremap gU gU
let g:which_key_g['H']      = 'select line mode'
nnoremap gH gH
let g:which_key_g['h']      = 'select mode'
nnoremap gh gh
let g:which_key_g['I']      = 'insert text in column 1'
nnoremap gI gI
let g:which_key_g['i']      = "insert text after '^ mark"
nnoremap gi gi
let g:which_key_g['J']      = 'join lines without space'
nnoremap gJ gJ
let g:which_key_g['N']      = 'visually select previous match'
nnoremap gN gN
let g:which_key_g['n']      = 'visually select next match'
nnoremap gn gn
let g:which_key_g['Q']      = 'switch to Ex mode'
nnoremap gQ gQ
let g:which_key_g['q']      = 'format Nmove text'
nnoremap gq gq
let g:which_key_g['R']      = 'enter VREPLACE mode'
nnoremap gR gR
let g:which_key_g['T']      = 'previous tag page'
nnoremap gT gT
let g:which_key_g['t']      = 'next tag page'
nnoremap gt gt
let g:which_key_g[']']      = 'tselect cursor tag'
nnoremap g] g]
let g:which_key_g['^']      = 'go to leftmost no-white character'
nnoremap g^ g^
let g:which_key_g['_']      = 'go to last char'
nnoremap g_ g_
let g:which_key_g['~']      = 'swap case for Nmove text'
nnoremap g~ g~
let g:which_key_g['a']      = 'print ascii value of cursor character'
nnoremap ga ga
let g:which_key_g['g']      = 'go to line N'
nnoremap gg gg
let g:which_key_g['m']      = 'go to middle of screenline'
nnoremap gm gm
let g:which_key_g['o']      = 'goto byte N in the buffer'
nnoremap go go
let g:which_key_g['s']      = 'sleep N seconds'
nnoremap gs gs
let g:which_key_g['v']      = 'reselect the previous Visual area'
nnoremap gv gv
let g:which_key_g['<C-]>']  = 'jump to tag cursor under'
nnoremap g<C-]> g<C-]>

