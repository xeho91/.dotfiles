" =========================================================================== "
" Neovim LSP settings
" -------------------
" https://github.com/neovim/nvim-lspconfig
" =========================================================================== "
"
" lua << EOF
" require'lspconfig'.vimls.setup{}
"
"     Commands:
"
"     Default Values:
"         cmd = { "vim-language-server", "--stdio" }
"         docs = {
"             description = "https://github.com/iamcco/vim-language-server\n\nIf you don't want to use Nvim to install it, then you can use:\n```sh\nnpm install -g vim-language-server\n`````\n"
"         }
"         filetypes = { "vim" }
"         init_options = {
"             diagnostic = {
"                 enable = true
"             },
"             indexes = {
"                 count = 3,
"                 gap = 100,
"                 projectRootPatterns = { "runtime", "nvim", ".git", "autoload", "plugin" },
"                 runtimepath = true
"             },
"             iskeyword = "@,48-57,_,192-255,-#",
"             runtimepath = "",
"             suggest = {
"                 fromRuntimepath = true,
"                 fromVimruntime = true
"             },
"             vimruntime = ""
"         }
"         on_new_config = <function 1>
"         root_dir = <function 1>
" EOF
"
