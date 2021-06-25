local packer = require("packer")
local use = packer.use

local plugins_list = function()
    use(
        {
            "wbthomason/packer.nvim",
            -- Packer can manage itself as an optional plugin Lua: Yes
            -- https://github.com/wbthomason/packer.nvim
            opt = true,
            keys = "<F5>",
            config = function()
                vim.api.nvim_set_keymap(
                    "n", "<F5>", "<cmd>PackerSync<CR>",
                    { noremap = true, expr = false }
                )
            end,
        }
    )

    -- --------------------------------------------------------------------
    -- Essentials
    -- --------------------------------------------------------------------

    use(
        {
            "tpope/vim-sensible",
            -- Vim defaults everyone can agree on Lua: No
            -- https://github.com/tpope/vim-sensible
        }
    )

    use(
        {
            "editorconfig/editorconfig-vim",
            -- EditorConfig
            -- Lua: No
            -- https://github.com/editorconfig/editorconfig-vim
        }
    )

    use(
        {
            "tpope/vim-sleuth",
            -- Heuristically set buffer options
            -- Lua: No
            -- https://github.com/tpope/vim-sleuth
        }
    )

    use(
        {
            "svermeulen/vimpeccable",
            -- Utils for maps, etc
            -- Lua: Yes
            -- https://github.com/svermeulen/vimpeccable
        }
    )

    use(
        {
            "nvim-lua/plenary.nvim",
            -- https://github.com/nvim-lua/plenary.nvim
        }
    )

    use(
        {
            "nvim-lua/popup.nvim",
            -- https://github.com/nvim-lua/popup.nvim
        }
    )

    use(
        {
            "folke/which-key.nvim",
            -- Show keybinding (mappings) in a popup (cheatsheet)
            -- Lua: Yes
            -- https://github.com/folke/which-key.nvim
            opt = true,
            cmd = { "WhichKey" },
            config = "require('configs/cheatsheet')",
        }
    )

    use(
        {
            "ahmedkhalf/lsp-rooter.nvim",
            -- Change the cwd to the project's root directory automagically
            -- Lua: Yes
            -- https://github.com/ahmedkhalf/lsp-rooter.nvim
        }
    )

    -- --------------------------------------------------------------------
    -- LSP - Language Server Protocol
    -- --------------------------------------------------------------------

    use(
        {
            "neovim/nvim-lspconfig",
            -- Quickstart configurations for the Nvim LSP client
            -- Lua: Yes
            -- https://github.com/neovim/nvim-lspconfig
            config = "require('configs/lsp')",
            requires = {
                --[[ {
				"kabouzeid/nvim-lspinstall"
				-- Plugin for easier installation of languages
				-- Lua: Yes
				-- https://github.com/kabouzeid/nvim-lspinstall
			}, ]]
                {
                    "glepnir/lspsaga.nvim",
                    -- Lightweight UI provider for LSP
                    -- Lua: Yes
                    -- https://github.com/glepnir/lspsaga.nvim
                },
                {
                    "ray-x/lsp_signature.nvim",
                    -- Signature hint when typing
                    -- Lua: Yes
                    -- https://github.com/ray-x/lsp_signature.nvim
                },
                {
                    "nvim-lua/lsp-status.nvim",
                    -- Generate statusline components from the built-in LSP client
                    -- Lua: Yes
                    -- https://github.com/nvim-lua/lsp-status.nvim
                },
                {
                    "onsails/lspkind-nvim",
                    -- Pictograms for LSP completion system
                    -- Lua: Yes
                    -- https://github.com/onsails/lspkind-nvim
                },
                {
                    "folke/lsp-trouble.nvim",
                    -- Better diagnostic list
                    -- Lua: Yes
                    -- https://github.com/folke/lsp-trouble.nvim
                },
            },
        }
    )

    -- --------------------------------------------------------------------
    -- Completion
    -- --------------------------------------------------------------------

    use(
        {
            "hrsh7th/nvim-compe",
            -- Auto completion plugin
            -- Lua: Yes
            -- https://github.com/hrsh7th/nvim-compe
            opt = true,
            event = "InsertEnter *",
            config = "require('configs/completion')",
            requires = {
                --[[ {
                    "tzachar/compe-tabnine",
                    -- TabNine AI completion
                    -- Lua: Yes
                    -- https://github.com/tzachar/compe-tabnine
                    run = "./install.sh",
                }, ]]
                --[[ {
                "L3MON4D3/LuaSnip",
                -- Snippet engine
                -- Lua: Yes
                -- https://github.com/L3MON4D3/LuaSnip
        	}), ]]
                {
                    "hrsh7th/vim-vsnip",
                    -- Snippets plugin
                    -- Lua: No
                    -- https://github.com/hrsh7th/vim-vsnip
                    requires = {
                        {
                            "hrsh7th/vim-vsnip-integ",
                            -- Integration with other plugins
                            -- Lua: No
                            -- https://github.com/hrsh7th/vim-vsnip-integ
                        },
                    },
                },
            },
        }
    )

    use(
        {
            "windwp/nvim-autopairs",
            -- Insert or delete brackets, parens, quotes in pair
            -- Lua: Yes
            -- https://github.com/windwp/nvim-autopairs
            config = "require('configs/autopairs')",
        }
    )

    -- --------------------------------------------------------------------
    -- Snippets
    -- --------------------------------------------------------------------

    use(
        {
            "rafamadriz/friendly-snippets",
            -- Set of preconfigured snippets
            -- Lua: No
            -- https://github.com/rafamadriz/friendly-snippets
            opt = true,
            event = "InsertEnter *",
        }
    )

    -- --------------------------------------------------------------------
    -- Syntax improvement
    -- --------------------------------------------------------------------

    use(
        {
            "nvim-treesitter/nvim-treesitter",
            -- Fast minimap written in Lua
            -- Lua: Yes
            -- https://github.com/nvim-treesitter/nvim-treesitter
            config = "require('configs/treesitter')",
            requires = {
                {
                    "nvim-treesitter/nvim-treesitter-refactor",
                    -- https://github.com/nvim-treesitter/nvim-treesitter-refactor
                },
                {
                    "nvim-treesitter/nvim-treesitter-textobjects",
                    -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
                },
                {
                    "nvim-treesitter/playground",
                    -- https://github.com/nvim-treesitter/playground
                    opt = true,
                    cmd = "TSPlaygroundToggle",
                },
                {
                    "romgrk/nvim-treesitter-context",
                    -- https://github.com/romgrk/nvim-treesitter-context
                },
                {
                    "p00f/nvim-ts-rainbow",
                    -- https://github.com/p00f/nvim-ts-rainbow
                },
                {
                    "JoosepAlviste/nvim-ts-context-commentstring",
                    -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
                },
            },
        }
    )

    use(
        {
            "lukas-reineke/indent-blankline.nvim",
            -- Indent guides
            -- Lua: Yes
            -- https://github.com/lukas-reineke/indent-blankline.nvim
            branch = "lua",
            config = "require('configs/indentline')",
        }
    )

    -- use({
    -- "yamatsum/nvim-cursorline"
    -- Highlights words and lines the cursor
    -- Lua: Yes
    -- https://github.com/yamatsum/nvim-cursorline
    -- }

    use(
        {
            "lewis6991/foldsigns.nvim",
            -- Signs for folded items
            -- Lua: Yes
            -- https://github.com/lewis6991/foldsigns.nvim
            config = function() require("foldsigns").setup() end,
        }
    )

    use(
        {
            "folke/todo-comments.nvim",
            -- Highlight, list and search todo comments in your projects
            -- Lua: Yes
            -- https://github.com/folke/todo-comments.nvim
            config = "require('configs/todo_comments')",
        }
    )

    --[[ use(
        {
            "edluffy/specs.nvim",
            -- Keep an eye on where your cursor has jumped
            -- Lua: Yes
            -- https://github.com/edluffy/specs.nvim
            config = "require('configs/specs')",
        }
    ) ]]

    use(
        {
            "neoclide/jsonc.vim",
            -- Syntax for JSON with comments
            -- Lua: No
            -- https://github.com/neoclide/jsonc.vim
        }
    )

    use(
        {
            "antonk52/vim-browserslist",
            -- Syntax for browserslist
            -- Lua: No
            -- https://github.com/browserslist/vim-browserslist
        }
    )

    -- --------------------------------------------------------------------
    -- Navigations & Previews
    -- --------------------------------------------------------------------

    use(
        {
            "glepnir/dashboard-nvim",
            -- ...
            -- Lua: Yes
            -- https://github.com/glepnir/dashboard-nvim
            event = "BufEnter *",
            opt = true,
            cmd = "Dashboard",
            setup = "require('setups/dashboard')",
        }
    )

    use(
        {
            "nvim-telescope/telescope.nvim",
            -- Find, Filter, Preview, Pick
            -- Lua: Yes
            -- https://github.com/nvim-telescope/telescope.nvim
            --[[ opt = true,
            cmd = "Telescope", ]]
            -- setup = "require('setups/telescope')",
            config = "require('configs/telescope')",
            requires = {
                {
                    "nvim-telescope/telescope-frecency.nvim",
                    -- https://github.com/nvim-telescope/telescope-frecency.nvim
                    requires = {
                        "tami5/sql.nvim",
                        -- https://github.com/tami5/sql.nvim
                    },
                },
            },
        }
    )

    use(
        {
            "gennaro-tedesco/nvim-peekup",
            -- Preview contents of the registers
            -- Lua: Yes
            -- https://github.com/gennaro-tedesco/nvim-peekup
            opt = true,
            keys = "\"\"",
            config = "require('configs/peekup')",
        }
    )

    use(
        {
            "kyazdani42/nvim-tree.lua",
            -- File explorer tree
            -- Lua: Yes
            -- https://github.com/kyazdani42/nvim-tree.lua
            opt = true,
            keys = "<F2>",
            cmd = "NvimTreeToggle",
            config = "require('configs/file_explorer')",
        }
    )

    use(
        {
            "npxbr/glow.nvim",
            -- A markdown preview
            -- Lua: Yes
            -- https://github.com/npxbr/glow.nvim
            run = ":GlowInstall",
            opt = true,
            cmd = "Glow",
        }
    )

    -- --------------------------------------------------------------------
    -- Helpers
    -- --------------------------------------------------------------------

    use(
        {
            "axelf4/vim-strip-trailing-whitespace",
            -- Lua: No
            -- Better whitespace trimming
            -- https://github.com/axelf4/vim-strip-trailing-whitespace
        }
    )

    use(
        {
            "voldikss/vim-floaterm",
            -- Terminal manager
            -- Lua: No
            -- https://github.com/voldikss/vim-floaterm
        }
    )

    use(
        {
            "kshenoy/vim-signature",
            -- Toggle, display and navigate marks
            -- Lua: No
            -- https://github.com/kshenoy/vim-signature
        }
    )

    use(
        {
            "junegunn/vim-easy-align",
            -- Alignment plugin
            -- Lua: No
            -- https://github.com/junegunn/vim-easy-align
            opt = true,
            keys = "ga",
            cmd = "EasyAlign",
            config = "require('configs/easy_align')",
        }
    )

    use(
        {
            "norcalli/nvim-colorizer.lua",
            -- Colorizer
            -- Lua: Yes
            -- https://github.com/norcalli/nvim-colorizer.lua
            --[[ opt = true,
		cmd = "ColorizerToggle",
		config = "require('configs/colorizer')" ]]
        }
    )

    use(
        {
            "tpope/vim-eunuch",
            -- Helpers for UNIX
            -- Lua: No
            -- https://github.com/tpope/vim-eunuch
            opt = true,
            cmd = {
                "Delete",
                "Unlink",
                "Move",
                "Rename",
                "Chmod",
                "Mkdir",
                "Cfind",
                "Clocate",
                "Lfind",
                "Llocate",
                "Wall",
                "SudoWrite",
                "SudoEdit",
            },
        }
    )

    -- --------------------------------------------------------------------
    -- Motions
    -- --------------------------------------------------------------------

    use(
        {
            "karb94/neoscroll.nvim",
            -- Smooth scrolling
            -- Lua: Yes
            -- https://github.com/karb94/neoscroll.nvim
            config = "require('configs/scrolling')",

        }
    )

    --[[ use(
        {
            "notomo/gesture.nvim",
            -- Mouse gestures
            -- Lua: No
            -- https://github.com/notomo/gesture.nvim
            opt = true,
            keys = { "<LeftDrag>", "<LeftRelease>" },
            config = "require('configs/gesture')",
        }
    ) ]]

    use(
        {
            "tpope/vim-unimpaired",
            -- Pairs of handy bracket mappings
            -- Lua: No
            -- https://github.com/tpope/vim-unimpaired
        }
    )

    use(
        {
            "machakann/vim-sandwich",
            -- The set of operator and textobject plugins to search/select/edit
            -- sandwiched textobjects
            -- Lua: No
            -- https://github.com/machakann/vim-sandwich
            opt = true,
            keys = { "sa", "sd", "sr" },
        }
    )

    use(
        {
            "terrortylor/nvim-comment",
            -- Comment stuff out
            -- Lua: Yes
            -- https://github.com/terrortylor/nvim-comment
            opt = true,
            keys = "gc",
            config = "require('configs/commenting')",
        }
    )
    -- use(
    -- {
    -- "b3nj5m1n/kommentary",
    -- Comment stuff out
    -- Lua: Yes
    -- https://github.com/b3nj5m1n/kommentary
    -- opt = true,
    -- keys = "gc",
    -- config = "require('configs/commenting')",
    -- }
    -- )

    use(
        {
            "wellle/targets.vim",
            -- Plugin that provides additional text objects
            -- Lua: No
            -- https://github.com/wellle/targets.vim
        }
    )

    use(
        {
            "mg979/vim-visual-multi",
            -- Multiple cursors
            -- Lua: No
            -- https://github.com/mg979/vim-visual-multi
        }
    )

    use(
        {
            "chaoren/vim-wordmotion",
            -- Useful word motions
            -- Lua: No
            -- https://github.com/chaoren/vim-wordmotion
        }
    )

    use(
        {
            "phaazon/hop.nvim",
            -- Missing motions
            -- Lua: Yes
            -- https://github.com/phaazon/hop.nvim
            opt = true,
            keys = "$",
            cmds = { "HopWord", "HopPattern", "HopChar1", "HopChar2", "HopLine" },
            config = "require('configs/hop')",
        }
    )

    use(
        {
            "monaqa/dial.nvim",
            -- Enhanced increment/decrement
            -- Lua: Yes
            -- https://github.com/monaqa/dial.nvim
            opt = true,
            keys = { "<C-x>", "<C-a>" },
            config = "require('configs/dial')",
        }
    )

    use(
        {
            "AckslD/nvim-revJ.lua",
            -- Opposite of join-line (J) of arguments
            -- Lua: Yes
            -- https://github.com/AckslD/nvim-revJ.lua
            opt = true,
            keys = { "<leader>J", "<leader>j" },
            config = "require('configs/revj')",
        }
    )

    use(
        {
            "mattn/emmet-vim",
            -- Emmet for Vim
            -- Lua: No
            -- https://github.com/mattn/emmet-vim
            opt = true,
            keys = "<C-y>",
            ft = { "html", "css", "svelte" },
        }
    )

    -- --------------------------------------------------------------------
    -- Git
    -- --------------------------------------------------------------------

    use(
        {
            "lewis6991/gitsigns.nvim",
            -- Git signs
            -- Lua: Yes
            -- https://github.com/lewis6991/gitsigns.nvim
            config = "require('configs/git')",
        }
    )

    use(
        {
            "TimUntersberger/neogit",
            -- Git porcelain (based on Magit)
            -- Lua: Yes
            -- https://github.com/TimUntersberger/neogit
            opt = true,
            cmd = "Neogit",
            config = "require('configs/neogit')",
        }
    )

    use(
        {
            "sindrets/diffview.nvim",
            -- Single tabpage interface to easily cycle through diffs for all
            -- modified files for any git rev
            -- Lua: Yes
            -- https://github.com/sindrets/diffview.nvim
            opt = true,
            cmd = { "DiffviewOpen", "DiffviewToggleFiles", "DiffviewFocusFiles" },
            config = "require('configs/diffview')",
        }
    )

    -- --------------------------------------------------------------------
    -- Profiling
    -- --------------------------------------------------------------------

    use(
        {
            "dstein64/vim-startuptime",
            -- Profile Neovim startup time
            -- Lua: No
            -- https://github.com/dstein64/vim-startuptime
            opt = true,
            cmd = { "StartupTime" },
        }
    )

    -- --------------------------------------------------------------------
    -- Debugging
    -- --------------------------------------------------------------------

    use(
        {
            "tpope/vim-dotenv",
            -- Basic support for .env and Procfile
            -- Lua: No
            -- https://github.com/tpope/vim-dotenv
            opt = true,
            cmd = { "Dotenv" },
        }
    )

    use(
        {
            "michaelb/sniprun",
            -- Profile Neovim startup time
            -- Lua: Yes
            -- https://github.com/michaelb/sniprun
            run = ":!cargo build --release",
            opt = true,
            cmd = { "SnipRun" },
        }
    )

    -- use({
    --	"mfussenegger/nvim-dap",
    -- Debug Adapter Protocol client implementation
    -- Lua: Yes
    -- https://github.com/mfussenegger/nvim-dap
    --	config = [[ require("configs/dap") ]],
    --	requires = {
    --		{
    --			"theHamsta/nvim-dap-virtual-text"
    -- https://github.com/theHamsta/nvim-dap-virtual-text
    --		},
    --		{
    --			"jbyuki/one-small-step-for-vimkind"
    -- https://github.com/jbyuki/one-small-step-for-vimkind
    --		}
    --	}
    -- }
    -- use({ "nvim-telescope/telescope-dap.nvim" }

    -- --------------------------------------------------------------------
    -- Development
    -- --------------------------------------------------------------------

    use(
        {
            "rafcamlet/nvim-luapad",
            -- Profile Neovim startup time
            -- Lua: Yes
            -- https://github.com/rafcamlet/nvim-luapad
            opt = true,
            cmd = { "LuaPad" },
        }
    )

    use(
        {
            "bfredl/nvim-luadev",
            -- Profile Neovim startup time
            -- Lua: Yes
            -- https://github.com/bfredl/nvim-luadev
            opt = true,
            cmd = { "Luadev" },
        }
    )

    use(
        {
            "folke/lua-dev.nvim",
            -- Profile Neovim startup time
            -- Lua: Yes
            -- https://github.com/folke/lua-dev.nvim
            opt = true,
            filetype = { "lua", "vim" },
            config = "require('configs/lua-dev')",
        }
    )

    -- --------------------------------------------------------------------
    -- Testing
    -- --------------------------------------------------------------------

    --[[ use({
		"tpope/vim-dispatch",
		-- Asynchronous build and test dispatcher
		-- Lua: No
		-- https://github.com/tpope/vim-dispatch
		opt = true,
		cmd = {"Dispatch", "Make", "Focus", "Start"}
	} ]]

    -- --------------------------------------------------------------------
    -- Themes & UI
    -- --------------------------------------------------------------------

    -- use({
    -- 	"Th3Whit3Wolf/Dusk-til-Dawn.nvim",
    -- 	-- Automatically change colorscheme based on time
    -- 	-- Lua: Yes
    -- 	-- https://github.com/Th3Whit3Wolf/Dusk-til-Dawn.nvim
    -- 	config = [[ require("configs/dusktildawn") ]]
    -- }

    use(
        {
            "folke/tokyonight.nvim",
            -- Dark and light theme
            -- Lua: Yes
            -- https://github.com/folke/tokyonight.nvim
            config = "require('configs/theme')",
            -- 	requires = {
            -- "rktjmp/lush.nvim"
            -- -- https://github.com/rktjmp/lush.nvim
            -- 	}
        }
    )

    use(
        {
            "glepnir/galaxyline.nvim",
            -- Statusline (bottom) plugin
            -- Lua: Yes
            -- https://github.com/glepnir/galaxyline.nvim
            branch = "main",
            config = "require('configs/statusline')",
        }
    )

    use(
        {
            "kyazdani42/nvim-web-devicons",
            -- Icons system
            -- Lua: Yes
            -- https://github.com/kyazdani42/nvim-web-devicons
        }
    )

    use(
        {
            "akinsho/nvim-bufferline.lua",
            -- A snazzy bufferline
            -- Lua: Yes
            -- https://github.com/akinsho/nvim-bufferline.lua
            config = "require('configs/bufferline')",
        }
    )

    use(
        {
            "wfxr/minimap.vim",
            -- Fast minimap written in Lua
            -- Lua: No
            -- https://github.com/wfxr/minimap.vim
            run = ":!cargo install --locked code-minimap",
            opt = true,
            cmd = "Minimap",
            keys = "<F8>",
            config = "require('configs/minimap')",
        }
    )

    -- use({
    -- 	"Xuyuanp/scrollbar.nvim",
    -- 	-- Scrollbar
    -- 	-- Lua: Yes
    -- 	-- https://github.com/Xuyuanp/scrollbar.nvim
    -- 	config = [[ require("configs/scrollbar") ]]
    -- }

    use(
        {
            "kdav5758/TrueZen.nvim",
            -- Elegant distraction-free writing
            -- Lua: Yes
            -- https://github.com/kdav5758/TrueZen.nvim
            opt = true,
            cmd = {
                "TZMinimalist",
                "TZFocus",
                "TZAtaraxis",
                "TZBottom",
                "TZTop",
                "TZLeft",
            },
            config = "require('configs/truezen')",
            requires = {
                "junegunn/limelight.vim",
                -- Dim the code, to improve focus on piece of code
                -- Lua: No
                -- https://github.com/junegunn/limelight.vim
                opt = true,
                cmd = { "Limelight" },
            },
        }
    )

    use(
        {
            "beauwilliams/focus.nvim",
            -- Auto-Focusing Splits/Windows
            -- Lua: Yes
            -- https://github.com/beauwilliams/focus.nvim
            opt = true,
            cmd = { "ToggleFocus" },
        }
    )

    -- --------------------------------------------------------------------
    -- Programming Languages helpers
    -- --------------------------------------------------------------------
    use(
        {
            "heavenshell/vim-jsdoc",
            -- Generate JSDoc to JavaScript code
            -- Lua: No
            -- https://github.com/heavenshell/vim-jsdoc
            run = "make install",
            opt = true,
            keys = "<Leader>dt",
            language = { "javascript", "typescript" },
            cmd = { "JsDoc" },
            config = "require('configs/jsdoc')",
        }
    )

end

packer.startup(plugins_list)

-- Testing
-- use({"vim-test/vim-test"}
-- use({ "rcarriga/vim-ultest", run = ":UpdateRemotePlugins" }

-- use({"nvim-telescope/telescope-symbols.nvim"}
-- -- use({
-- --     "nvim-telescope/telescope-arecibo.nvim",
-- --     rocks = {"openssl", "lua-http-parser"}
-- -- }
-- -- use({ "nvim-telescope/telescope-media-files.nvim" }
-- -- use({ "nvim-telescope/telescope-packer.nvim " }

-- -- Better LSP experience
-- use({"sbdchd/neoformat"}
-- use({"szw/vim-maximizer"}
-- use({"dyng/ctrlsf.vim"}
-- use({"dbeniamine/cheat.sh-vim"}

-- use({"wellle/context.vim"}
-- use({ "beauwilliams/focus.nvim" }
-- use({ "RRethy/vim-illuminate" }

-- use({ "nvim-telescope/telescope-snippets.nvim" }

-- Lua development
-- use({"tjdevries/nlua.nvim"}

-- Project
-- use({"nvim-telescope/telescope-project.nvim"}
-- use({"airblade/vim-rooter"}
-- use({"tpope/vim-projectionist"}

