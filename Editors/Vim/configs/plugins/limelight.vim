" =========================================================================== "
" Limelight settings
" ------------------
" https://github.com/junegunn/limelight.vim
" =========================================================================== "

" Bind hotkey for toggling Limelight on and off
map <F9> :Limelight!!<CR>

" Bind hotkey for invoking Limelight for a visual range:
" - NORMAL mode
nmap <Leader>l <Plug>(Limelight)
" - VISUAL mode
xmap <Leader>l <Plug>(Limelight)

" Set the conceal level
let g:limelight_default_coefficient = 0.8

