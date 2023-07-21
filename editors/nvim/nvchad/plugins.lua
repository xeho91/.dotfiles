local overrides = require "custom.overrides"

---@type NvPluginSpec[]
local plugins = {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = overrides.treesitter,
		dependencies = {
			{
				-- https://github.com/danymat/neogen
				"danymat/neogen",
				config = function()
					require "custom/plugins/configs/neogen"
				end,
			},
			{
				-- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
				"JoosepAlviste/nvim-ts-context-commentstring",
				lazy = false,
			},
			{
				-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
				"nvim-treesitter/nvim-treesitter-textobjects",
				lazy = false,
			},
			{
				-- https://github.com/RRethy/nvim-treesitter-textsubjects
				"RRethy/nvim-treesitter-textsubjects",
				lazy = false,
			},
			--[[ { ]]
			--[[ 	-- https://github.com/haringsrob/nvim_context_vt ]]
			--[[ 	"haringsrob/nvim_context_vt", ]]
			--[[ 	lazy = false, ]]
			--[[ }, ]]
			{
				-- https://github.com/nvim-treesitter/nvim-treesitter-context
				"nvim-treesitter/nvim-treesitter-context",
				lazy = false,
			},
			{
				-- https://github.com/nvim-treesitter/playground
				"nvim-treesitter/playground",
				cmd = "TSHighlightCapturesUnderCursor",
			},
			{
				-- https://github.com/p00f/nvim-ts-rainbow
				-- TODO: No longer maintained, needs to find replacement
				lazy = false,
				"p00f/nvim-ts-rainbow",
			},
			{
				-- https://github.com/windwp/nvim-ts-autotag
				lazy = false,
				"windwp/nvim-ts-autotag",
			},
			{
				-- https://github.com/CKolkey/ts-node-action
				"CKolkey/ts-node-action",
				lazy = false,
				config = function()
					require "custom/plugins/configs/ts-node-action"
				end,
			},
		},
	},
	{
		-- https://github.com/williamboman/mason.nvim
		"williamboman/mason.nvim",
		opts = overrides.mason,
		dependencies = {
			{
				"williamboman/mason-lspconfig.nvim",
				config = function()
					require("mason-lspconfig").setup()
				end,
			},
			{ "neovim/nvim-lspconfig" },
		},
	},
	{
		-- https://github.com/kyazdani42/nvim-tree.lua
		"nvim-tree/nvim-tree.lua",
		opts = overrides.tree,
	},

	{
		-- https://github.com/max397574/better-escape.nvim
		"max397574/better-escape.nvim",
		config = function()
			require("better_escape").setup()
		end,
		event = "InsertEnter",
	},

	{
		-- https://github.com/lukas-reineke/indent-blankline.nvim
		"lukas-reineke/indent-blankline.nvim",
		opts = overrides.indent,
	},

	-------------
	-- ESSENTIALS
	-------------

	{
		-- https://github.com/nvim-telescope/telescope.nvim
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{
				-- https://github.com/ecthelionvi/NeoComposer.nvim
				"ecthelionvi/NeoComposer.nvim",
				dependencies = { "kkharji/sqlite.lua" },
				opts = {},
				lazy = false,
				config = function()
					require("NeoComposer").setup()
					require("telescope").load_extension "macros"
				end,
			},
			{
				-- https://github.com/ahmedkhalf/project.nvim
				"ahmedkhalf/project.nvim",
				config = function()
					require "custom/plugins/configs/project"
				end,
			},
			--[[ { ]]
			--[[ 	-- https://github.com/nvim-telescope/telescope-dap.nvim ]]
			--[[ 	"nvim-telescope/telescope-dap.nvim", ]]
			--[[ }, ]]
		},
		opts = overrides.telescope,
	},

	--[[ { ]]
	--[[ 	-- https://github.com/roobert/search-replace.nvim ]]
	--[[ 	"roobert/search-replace.nvim", ]]
	--[[ 	keys = { "gcI", "egcI" }, ]]
	--[[ 	config = function() ]]
	--[[ 		require("search-replace").setup { ]]
	--[[ 			-- optionally override defaults ]]
	--[[ 			default_replace_single_buffer_options = "gcI", ]]
	--[[ 			default_replace_multi_buffer_options = "egcI", ]]
	--[[ 		} ]]
	--[[ 	end, ]]
	--[[ }, ]]

	{
		-- https://github.com/nvim-pack/nvim-spectre
		"nvim-pack/nvim-spectre",
		cmd = { "Spectre" },
		config = function()
			require("spectre").setup()
		end,
	},

	{
		-- https://github.com/kevinhwang91/nvim-bqf
		"kevinhwang91/nvim-bqf",
		ft = "qf",
	},

	{
		-- https://github.com/nathom/filetype.nvim
		"nathom/filetype.nvim",
		lazy = false,
		config = function()
			require "custom/plugins/configs/filetype"
		end,
	},

	{
		-- https://github.com/echasnovski/mini.nvim
		"echasnovski/mini.nvim",
		lazy = false,
		branch = "main",
		config = function()
			require "custom/plugins/configs/mini"
		end,
	},

	{
		-- https://github.com/folke/which-key.nvim
		"folke/which-key.nvim",
		disable = true,
	},

	---------------------------------
	-- LSP (Language Server Protocol)
	---------------------------------
	{
		"neovim/nvim-lspconfig",
		opts = function()
			require "custom.plugins.configs.lspconfig"
		end,
		dependencies = {
			{
				-- https://github.com/jose-elias-alvarez/typescript.nvim
				"jose-elias-alvarez/typescript.nvim",
				ft = {
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"svelte",
				},
			},
		},
	},

	{
		-- https://github.com/jose-elias-alvarez/null-ls.nvim
		"jose-elias-alvarez/null-ls.nvim",
		event = "VeryLazy",
		config = function()
			require "custom.plugins.configs.null-ls"
			--[[ require "custom.plugins.configs.typescript" ]]
		end,
		dependencies = {
			{ "neovim/nvim-lspconfig" },
			--[[ { ]]
			-- https://github.com/folke/neodev.nvim
			--[[ "folke/neodev.nvim", ]]
			--[[ }, ]]
		},
	},

	--[[ { ]]
	--[[ 	--https://github.com/simrat39/rust-tools.nvim ]]
	--[[ 	"simrat39/rust-tools.nvim", ]]
	--[[ 	ft = { "rust" }, ]]
	--[[ 	dependencies = { ]]
	--[[ 		{ "rust-lang/rust.vim" }, ]]
	--[[ 		{ "neovim/nvim-lspconfig" }, ]]
	--[[ 		{ "jose-elias-alvarez/null-ls.nvim" }, ]]
	--[[ 		{ "nvim-lua/plenary.nvim" }, ]]
	--[[ 		{ "mfussenegger/nvim-dap" }, ]]
	--[[ 	}, ]]
	--[[ 	opts = function() ]]
	--[[ 		require "custom.plugins.configs.rust-tools" ]]
	--[[ 	end, ]]
	--[[ }, ]]

	{
		-- https://github.com/Saecki/crates.nvim
		"Saecki/crates.nvim",
		event = "BufEnter Cargo.toml",
		config = function()
			require "custom.plugins.configs.crates"
		end,
		dependencies = {
			{ "jose-elias-alvarez/null-ls.nvim" },
			{ "hrsh7th/nvim-cmp" },
		},
	},

	{
		-- https://github.com/folke/lsp-trouble.nvim
		"folke/lsp-trouble.nvim",
		config = function()
			require "custom/plugins/configs/lsp-trouble"
		end,
	},

	----------
	--  MOTION
	----------

	{
		-- https://github.com/mg979/vim-visual-multi
		"mg979/vim-visual-multi",
		lazy = false,
	},

	{
		-- https://github.com/chaoren/vim-wordmotion
		"chaoren/vim-wordmotion",
		lazy = false,
	},

	{
		-- https://github.com/folke/flash.nvim
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					-- default options: exact mode, multi window, all directions, with a backdrop
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "o", "x" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
		},
	},

	-- NOTE: Replaced by flash.nvim
	--[[ { ]]
	--[[ 	-- https://github.com/ggandor/lightspeed.nvim ]]
	--[[ 	"ggandor/lightspeed.nvim", ]]
	--[[ 	config = function() ]]
	--[[ 		require "custom/plugins/configs/lightspeed" ]]
	--[[ 	end, ]]
	--[[ }, ]]

	-- https://github.com/tzachar/highlight-undo.nvim
	{
		"tzachar/highlight-undo.nvim",
		event = "VeryLazy",
		config = function()
			require "custom.plugins.configs.highlight-undo"
		end,
	},

	{
		-- https://github.com/monaqa/dial.nvim
		"monaqa/dial.nvim",
		lazy = false,
		config = function()
			require "custom.plugins.configs.dial"
		end,
	},

	{
		-- https://github.com/cbochs/portal.nvim
		"cbochs/portal.nvim",
		lazy = false,
		config = function()
			require "custom/plugins/configs/portal"
		end,
		dependencies = {
			"cbochs/grapple.nvim",
			-- https://github.com/ThePrimeagen/harpoon
			"ThePrimeagen/harpoon",
		},
	},

	----------------------
	-- UI (User Interface)
	----------------------

	{
		-- https://github.com/uga-rosa/ccc.nvim
		"uga-rosa/ccc.nvim",
		lazy = false,
		event = "BufRead",
		config = function()
			require "custom.plugins.configs.ccc"
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		enabled = false,
	},
	{
		-- https://github.com/folke/edgy.nvim
		"folke/edgy.nvim",
		event = "VeryLazy",
		init = function()
			vim.opt.laststatus = 3
			vim.opt.splitkeep = "screen"
		end,
	},

	{
		-- https://github.com/karb94/neoscroll.nvim
		"karb94/neoscroll.nvim",
		keys = {
			"<C-u>",
			"<C-d>",
			"<C-b>",
			"<C-f>",
			"<C-y>",
			"<C-e>",
			"zt",
			"zz",
			"zb",
		},
		config = function()
			require("neoscroll").setup()
		end,
	},

	{
		-- https://github.com/folke/zen-mode.nvim
		"folke/zen-mode.nvim",
		cmd = { "ZenMode" },
		keys = { "<leader>tz" },
		config = function()
			require "custom.plugins.configs.zen-mode"
		end,
		dependencies = {
			{
				-- httpss//github.com/folke/twilight.nvim
				"folke/twilight.nvim",
				cmd = { "Twilight" },
				config = function()
					require "custom.plugins.configs.twilight"
				end,
			},
		},
	},

	---------
	-- SYNTAX
	---------

	{
		-- httpss//github.com/folke/todo-comments.nvim
		"folke/todo-comments.nvim",
		config = function()
			require "custom/plugins/configs/todo-comments"
		end,
		lazy = false,
	},

	--------
	-- OTHER
	--------

	{
		-- https://github.com/tversteeg/registers.nvim
		"tversteeg/registers.nvim",
		cmd = "Registers",
		name = "registers",
		keys = {
			{ '"', mode = { "n", "v" } },
			{ "<C-R>", mode = "i" },
		},
		config = function()
			require("registers").setup()
		end,
	},

	{
		-- https://github.com/nanotee/zoxide.vim
		"https://github.com/nanotee/zoxide.vim",
		cmd = { "Z", "Lz", "Tz", "Zi", "Lzi", "Tzi" },
		dependencies = {
			{
				-- https://github.com/jvgrootveld/telescope-zoxide
				"jvgrootveld/telescope-zoxide",
				config = function()
					require("telescope").load_extension ""
				end,
				dependencies = {
					"nvim-telescope/telescope.nvim",
				},
			},
		},
	},

	{
		-- https://github.com/stevearc/oil.nvim
		"stevearc/oil.nvim",
		lazy = false,
		config = function()
			require("oil").setup()
		end,
	},

	{
		-- https://github.com/ellisonleao/glow.nvim
		"ellisonleao/glow.nvim",
		cmd = { "Glow" },
		config = function()
			require "custom/plugins/configs/glow"
		end,
	},

	{
		-- https://github.com/axieax/urlview.nvim
		"axieax/urlview.nvim",
		cmd = { "UrlView" },
		config = function()
			require "custom/plugins/configs/urlview"
		end,
	},

	{
		-- https://github.com/wakatime/vim-wakatime
		"wakatime/vim-wakatime",
		lazy = false,
	},

	{
		-- https://github.com/browserslist/vim-browserslist
		"browserslist/vim-browserslist",
	},

	--------------
	-- COMPLETIONS
	--------------

	-- https://github.com/hrsh7th/nvim-cmp
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{
				-- https://github.com/hrsh7th/cmp-calc
				"hrsh7th/cmp-calc",
				lazy = false,
			},
			{
				-- https://github.com/hrsh7th/cmp-emoji
				"hrsh7th/cmp-emoji",
				lazy = false,
			},
			{
				-- https://github.com/petertriho/cmp-git
				"petertriho/cmp-git",
				lazy = false,
				config = function()
					require("cmp_git").setup()
				end,
			},
			{
				-- https://github.com/David-Kunz/cmp-npm
				"David-Kunz/cmp-npm",
				event = "BufEnter package.json",
			},
			{
				-- https://github.com/ray-x/cmp-treesitter
				"ray-x/cmp-treesitter",
				lazy = false,
			},
		},
		opts = overrides.cmp,
	},

	------------------------------
	-- DE (Developer's Experience)
	------------------------------

	{
		-- https://github.com/lvimuser/lsp-inlayhints.nvim#rust
		"lvimuser/lsp-inlayhints.nvim",
		lazy = false,
		config = function()
			require("lsp-inlayhints").setup()
		end,
	},

	{
		--https://github.com/ThePrimeagen/refactoring.nvim
		"ThePrimeagen/refactoring.nvim",
		lazy = false,
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
		config = function()
			require "custom.plugins.configs.refactoring"
		end,
	},

	{
		-- https://github.com/AckslD/muren.nvim
		"AckslD/muren.nvim",
		cmd = { "Muren" },
		config = true,
	},

	{
		-- https://github.com/folke/noice.nvim
		"folke/noice.nvim",
		lazy = false,
		config = function()
			require "custom.plugins.configs.noice"
		end,
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			{ "MunifTanjim/nui.nvim" },
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			{ "rcarriga/nvim-notify" },
		},
	},

	{
		-- https://github.com/nvim-focus/focus.nvim
		"nvim-focus/focus.nvim",
		cmd = { "FocusSplitNicely", "FocusSplitCycle" },
		config = function()
			require "custom.plugins.configs.focus"
		end,
		-- module = "focus",
	},

	{
		-- https://github.com/RRethy/vim-illuminate
		"RRethy/vim-illuminate",
		config = function()
			require "custom/plugins/configs/illuminate"
		end,
		event = "CursorHold",
		-- module = "illuminate",
	},

	{
		-- https://github.com/cbochs/grapple.nvim
		"cbochs/grapple.nvim",
		config = function()
			require "custom/plugins/configs/grapple"
		end,
	},

	{
		-- https://github.com/RaafatTurki/hex.nvim
		"RaafatTurki/hex.nvim",
		cmd = {
			"HexDump",
			"HexAssemble",
			"HexToggle",
		},
		config = function()
			require("hex").setup()
		end,
	},

	----------------------------
	-- (A)rtifical (I)nteligence
	----------------------------

	--[[ { ]]
	--[[ 	"jackMort/ChatGPT.nvim", ]]
	--[[ 	cmd = { ]]
	--[[ 		"ChatGPT", ]]
	--[[ 		"ChatGPTActAs", ]]
	--[[ 		"ChatGPTInlineEdit", ]]
	--[[ 		"ChatGPTEditWithInstructions", ]]
	--[[ 	}, ]]
	--[[ 	config = function() ]]
	--[[ 		require "custom/plugins/configs/chatgpt" ]]
	--[[ 	end, ]]
	--[[ }, ]]

	--[[ { ]]
	--[[ 	-- httpss//github.com/zbirenbaum/copilot.lua ]]
	--[[ 	"zbirenbaum/copilot.lua", ]]
	--[[ 	event = "InsertEnter", ]]
	--[[ 	config = function() ]]
	--[[ 		require "custom.plugins.configs.copilot" ]]
	--[[ 	end, ]]
	--[[ 	dependencies = { ]]
	--[[ 		{ ]]
	--[[ 			-- httpss//github.com/zbirenbaum/copilot-cmp ]]
	--[[ 			"zbirenbaum/copilot-cmp", ]]
	--[[ 			config = function() ]]
	--[[ 				require("copilot_cmp").setup() ]]
	--[[ 			end, ]]
	--[[ 			dependencies = { "nvim-cmp" }, ]]
	--[[ 		}, ]]
	--[[ 	}, ]]
	--[[ }, ]]

	------------
	-- Debugging
	------------

	{
		-- https://github.com/mfussenegger/nvim-dap
		"mfussenegger/nvim-dap",
		keys = { "<leader>du" },
		config = function()
			require "custom.plugins.configs.dap"
		end,
		dependencies = {
			{
				-- https://github.com/rcarriga/nvim-dap-ui
				"rcarriga/nvim-dap-ui",
				config = function()
					require "custom.plugins.configs.dap-ui"
				end,
			},
			{
				-- https://github.com/jbyuki/one-small-step-for-vimkind
				"jbyuki/one-small-step-for-vimkind",
			},
			{
				-- https://github.com/jay-babu/mason-nvim-dap.nvim
				"jay-babu/mason-nvim-dap.nvim",
				cmd = { "DapInstall" },
				config = function()
					require("mason-nvim-dap").setup {
						automatic_setup = true,
					}
				end,
			},
			{
				-- https://github.com/theHamsta/nvim-dap-virtual-text
				"theHamsta/nvim-dap-virtual-text",
				config = function()
					require("nvim-dap-virtual-text").setup()
				end,
			},
		},
	},

	----------
	-- Testing
	----------

	--[[ { ]]
	-- https://github.com/nvim-neotest/neotest
	--[[ "nvim-neotest/neotest", ]]
	--[[ dependencies = { ]]
	--[[ 	{ "nvim-lua/plenary.nvim" }, ]]
	--[[ 	{ "nvim-neotest/neotest-plenary" }, ]]
	--[[ 	{ "nvim-treesitter/nvim-treesitter" }, ]]
	--[[ 	{ "antoinemadec/FixCursorHold.nvim" }, ]]
	--[[ { "haydenmeade/neotest-jest" }, ]]
	--[[ { "marilari88/neotest-vitest" }, ]]
	--[[ { "MarkEmmons/neotest-deno" }, ]]
	--[[ }, ]]
	--[[ config = function() ]]
	--[[ 	require("neotest").setup { ]]
	--[[ 		adapters = { ]]
	--[[ require "neotest-deno", ]]
	--[[ require "neotest-jest" { jestCommand = "jest --watch " }, ]]
	--[[ require "neotest-plenary", ]]
	--[[ require "neotest-vitest", ]]
	--[[ 		}, ]]
	--[[ 	} ]]
	--[[ end, ]]
	--[[ init = function() ]]
	--[[ 	vim.cmd [[ ]]
	--[[               command! NeotestSummary lua require("neotest").summary.toggle() ]]
	--[[               command! NeotestFile lua require("neotest").run.run(vim.fn.expand("%")) ]]
	--[[               command! Neotest lua require("neotest").run.run(vim.fn.getcwd()) ]]
	--[[               command! NeotestNearest lua require("neotest").run.run() ]]
	--[[               command! NeotestDebug lua require("neotest").run.run({ strategy = "dap" }) ]]
	--[[               command! NeotestAttach lua require("neotest").run.attach() ]]
	--[[           ]]
	--[[ end, ]]
	--[[ }, ]]

	--------------
	-- Git related
	--------------

	{
		-- https://github.com/akinsho/git-conflict.nvim
		"akinsho/git-conflict.nvim",
		lazy = false,
		--[[ tag = "*", ]]
		config = function()
			require("git-conflict").setup()
		end,
	},

	{
		-- https://github.com/vuki656/package-info.nvim
		"vuki656/package-info.nvim",
		event = "BufEnter package.json",
		config = function()
			require "custom.plugins.configs.package-info"
		end,
		dependencies = {
			{
				-- https://github.com/MunifTanjim/nui.nvim
				"MunifTanjim/nui.nvim",
				lazy = false,
			},
		},
	},

	{
		-- https://github.com/Rawnly/gist.nvim
		"Rawnly/gist.nvim",
	},

	---------
	-- Remote
	---------

	--[[ { ]]
	--[[ 	-- https://github.com/chipsenkbeil/distant.nvim ]]
	--[[ 	"chipsenkbeil/distant.nvim", ]]
	--[[ 	cmd = { "DistantLaunch", "DistantInstall" }, ]]
	--[[ 	config = function() ]]
	--[[ 		require("distant").setup { ]]
	--[[ 			["*"] = require("distant.settings").chip_default(), ]]
	--[[ 		} ]]
	--[[ 	end, ]]
	--[[ }, ]]
}

return plugins
