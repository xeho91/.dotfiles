" =========================================================================== "
" Mapping keys
" ------------
" https://vim.fandom.com/wiki/Mapping_keys_in_Vim_-_Tutorial_(Part_1)
" =========================================================================== "

let g:which_key_questionMark = { 'name': 'Mapped keys for general usage' }
nnoremap <silent> ? :<C-u>WhichKey '?'<CR>

" --------------------------------------------------------------------------- "
"                                                       Defining default keys
" --------------------------------------------------------------------------- "

" Esc
" ---
let g:which_key_questionMark['Esc'] = 'Close help'

" g
" -
let g:which_key_questionMark['g']   = 'Goto... & other'

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
	let g:which_key_questionMark['<C-j>'] = '[Plugin] Next problem (`ALE`)'
	nmap <silent> <C-k> <Plug>(ale_previous_wrap)
	let g:which_key_questionMark['<C-k>'] = '[Plugin] Previous problem (`ALE`)'
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

" Ctrl + F12
" ----------
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

nnoremap <Leader> :<c-u>WhichKey g:mapleader<CR>
" nnoremap <LocalLeader> :<c-u>WhichKey g:maplocalleader<CR>

" =========================================================================== "
" Definitions for default keys
" =========================================================================== "

" --------------------------------------------------------------------------- "
"                                                       `g` (Goto... & other)
" --------------------------------------------------------------------------- "

let g:which_key_g = { 'name': 'Goto... & other' }

nnoremap <silent><nowait> [G] :<C-u>WhichKey 'g'<CR>
nmap g [G]

" g + #
" -----
nnoremap g# g#
let g:which_key_g['#'] = '... previous occurence of what is under the cursor (backward)'

" g + $
" -----
nnoremap g$ g$
let g:which_key_g['$'] = '... rightmost (last) character on the line'

" g + %
" -----
if g:plugins.is_installed('matchup')
	nnoremap g% g%
	let g:which_key_g['%'] = '[Plugin] ... matching text of what is under the cursor (`vim-matchup`)'
endif

" g + &
" -----
nmap g& g&
let g:which_key_g['&'] = '[Other] Repeat last `:substitue` on ALL lines'

" g + '
" -----
nnoremap g' g'
let g:which_key_g["'"] = '... {count} mark from `:marks`'

" g + +
" -----
nnoremap g+ g+
let g:which_key_g['+'] = '... {count} newer text state (move forward in history)'

" g + ,
" -----
nnoremap g, g,
let g:which_key_g[','] = '... {count} newer position in change list'

" g + `
" -----
nnoremap g` g`
let g:which_key_g['`'] = '... {count} mark from `:marks`'

" g + -
" -----
nnoremap g- g-
let g:which_key_g['-'] = '... older text state (move backward in history)'

" g + ;
" -----
nnoremap g; g;
let g:which_key_g[';'] = '... {count} older position in change list'

" g + 0
" -----
nnoremap g0 g0
let g:which_key_g['0'] = '... leftmost (first) character on the line'

" g + <
" -----
if g:plugins.is_installed('swap')
	nnoremap g< g<
	let g:which_key_g['<'] = '[Plugin] Swap left delimited items (`vim-swap`)'
endif

" g + Ctrl + ]
" ------------
nnoremap g<C-]> g<C-]>
let g:which_key_g['<C-]>'] = '... tag of what is under the cursor'

" g + Ctrl + g
" ------------
nnoremap g<C-g> g<C-g>
let g:which_key_g['<C-g>'] = '[Other] Show information under the cursor'

" g + End
" -------
nnoremap g<End> g<End>
let g:which_key_g['<End>'] = '... rightmost (last) character on the line'

" g + Home
" --------
nnoremap g<Home> g<Home>
let g:which_key_g['<Home>'] = '... leftmost (first) character on the line'

" g + >
" -----
if g:plugins.is_installed('swap')
	nnoremap g> g>
	let g:which_key_g['>'] = '[Plugin] Swap right delimited items (`vim-swap`)'
endif

" g + @
" -----
nnoremap g@ g@
let g:which_key_g['@'] = '[Other] Call operatorfunc'

" g + ]
" -----
nnoremap g] g]
let g:which_key_g[']'] = '... tag which matches name of what is under the cursor (`:tselect`)'

" g + ^
" -----
nnoremap g^ g^
let g:which_key_g['^'] = '... first non-blank character on the line'

" g + _
" -----
nnoremap g_ g_
let g:which_key_g['_'] = '... last non-blank character on the line'

" g + a
" -----
nnoremap ga ga
let g:which_key_g['a'] = '[Other] Print the ascii value of the character under the cursor'

" g + d
" -----
if g:plugins.is_installed('coc')
	nmap <silent> gd <Plug>(coc-definition)
	let g:which_key_g['d'] = '[Plugin] ... code DEFINITION of what is under the cursor (`CoC`)'
endif

" g + e
" -----
nnoremap ge ge
let g:which_key_g['e'] = '... {count} backward to the end of word'

" g + F
" -----
nnoremap gF gF
let g:which_key_g['F'] = '... file of path under the cursor (jump to line after name)'

" g + f
" -----
nnoremap gf gf
let g:which_key_g['f'] = '... file of path under the cursor'

" g + g
" -----
nnoremap gg gg
let g:which_key_g['g'] = '... {count} line number (default first line)'

" g + H
" -----
nnoremap gH gH
let g:which_key_g['H'] = '[Select mode] linewise'

" g + h
" -----
nnoremap gh gh
let g:which_key_g['h'] = '[Select mode] charwise'

" g + I
" -----
nnoremap gI gI
let g:which_key_g['I'] = '[Insert mode] add text to 1st column {count} times'

" g + i
" -----
if g:plugins.is_installed('coc')
	nmap <silent> gi <Plug>(coc-implementation)
	let g:which_key_g['i'] = '[Plugin] ... code IMPLEMENTATION of what is under the cursor (`CoC`)'
endif

" g + J
" -----
nnoremap gJ gJ
let g:which_key_g['J'] = '[Other] Join {count} lines without spaces'

" g + j
" -----
nnoremap gj gj
let g:which_key_g['j'] = '... {count} next lines (downward)'

" g + k
" -----
nnoremap gk gk
let g:which_key_g['k'] = '... {count} previous lines (upward)'

" g + M
" -----
nnoremap gM gM
let g:which_key_g['M'] = '... halfway the text of the line'

" g + m
" -----
nnoremap gm gm
let g:which_key_g['m'] = '... half a screenwidth to the right (or as much as possible)'

" g + N
" -----
nnoremap gN gN
let g:which_key_g['N'] = '... previous occurence (backward) of the last used search pattern'

" g + n
" -----
nnoremap gn gn
let g:which_key_g['n'] = '... next occurence (forward) of the last used search pattern'

" g + o
" -----
nnoremap go go
let g:which_key_g['o'] = '... {count} byte in the buffer'

" g + Q
" -----
nnoremap gQ gQ
let g:which_key_g['Q'] = '[Ex mode] Switch to command mode'

" g + q
" -----
nnoremap gq gq
let g:which_key_g['q'] = '[Other] Format the lines {motion} moves over'

" g + R
" -----
nnoremap gR gR
let g:which_key_g['R'] = '[VReplace mode] Switch to virtual replace mode'

" g + r
" -----
if g:plugins.is_installed('coc')
	nmap <silent> gr <Plug>(coc-references)
	let g:which_key_g['r'] = '[Plugin] ... code REFERENCE of what is under the cursor (`CoC`)'
endif

" g + s
" -----
if g:plugins.is_installed('swap')
	nnoremap gs gs
	let g:which_key_g['s'] = '[Plugin] Start interactive swap mode (`vim-swap`)'
endif

" g + T
" -----
nnoremap gT gT
let g:which_key_g['T'] = '... previous tab page (`:tabnext`)'

" g + t
" -----
nnoremap gt gt
let g:which_key_g['t'] = '... next tab page (`:tabprevious`)'

" g + U
" -----
nnoremap gU gU
let g:which_key_g['U'] = '[Other] Make {motion} text uppercase'

" g + u
" -----
nnoremap gu gu
let g:which_key_g['u'] = '[Other] Make {motion} text lowercase'

" g + v
" -----
nnoremap gv gv
let g:which_key_g['v'] = '[Visual mode] Start in the same area as the previous area'

" g + x
" -----
" let g:which_key_g['x'] = ''

" g + y
" -----
if g:plugins.is_installed('coc')
	nmap <silent> gy <Plug>(coc-type-definition)
	let g:which_key_g['y'] = '[Plugin] ... code TYPE definition of what is under the cursor (`CoC`)'
endif

" g + ~
" -----
nnoremap g~ g~
let g:which_key_g['~'] = '[Other] Switch case of {motion} text'

