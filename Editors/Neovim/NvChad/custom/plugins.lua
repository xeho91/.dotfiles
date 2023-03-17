local overrides = require "custom.overrides"

local plugins = {
	---@type NvPluginSpec[]
	{
		"nvim-treesitter/nvim-treesitter",
		opts = overrides.treesitter,
		dependencies = {
			-- https://github.com/danymat/neogen
			{
				"danymat/neogen",
				config = function()
					require "custom/plugins/configs/neogen"
				end,
			},
			-- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
			{
				"JoosepAlviste/nvim-ts-context-commentstring",
				lazy = false,
			},
			-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				lazy = false,
			},
			-- https://github.com/RRethy/nvim-treesitter-textsubjects
			{
				"RRethy/nvim-treesitter-textsubjects",
				lazy = false,
			},
			-- https://github.com/haringsrob/nvim_context_vt
			{
				"haringsrob/nvim_context_vt",
				lazy = false,
			},
			-- https://github.com/nvim-treesitter/nvim-treesitter-context
			{
				"nvim-treesitter/nvim-treesitter-context",
				lazy = false,
			},
			-- https://github.com/nvim-treesitter/playground
			{
				"nvim-treesitter/playground",
				cmd = "TSHighlightCapturesUnderCursor",
			},
			-- https://github.com/p00f/nvim-ts-rainbow
			-- TODO: No longer maintained, needs to find replacement
			{
				lazy = false,
				"p00f/nvim-ts-rainbow",
			},
			-- https://github.com/windwp/nvim-ts-autotag
			{
				lazy = false,
				"windwp/nvim-ts-autotag",
			},
			-- https://github.com/CKolkey/ts-node-action
			-- TODO: Doesn't work on anything other than Lua
			{
				"CKolkey/ts-node-action",
				lazy = false,
				config = function()
					require "custom/plugins/configs/ts-node-action"
				end,
			},
			-- https://github.com/nvim-neorg/neorg
			{
				"nvim-neorg/neorg",
				setup = vim.cmd "autocmd BufRead,BufNewFile *.norg setlocal filetype=norg",
				ft = "norg",
				config = function()
					require "custom/plugins/configs/neorg"
				end,
				dependencies = {
					"nvim-lua/plenary.nvim",
					-- https://github.com/nvim-neorg/neorg-telescope
					"nvim-neorg/neorg-telescope",
				},
			},
		},
	},

	-- https://github.com/williamboman/mason.nvim
	{
		"williamboman/mason.nvim",
		opts = overrides.mason,
	},

	-- https://github.com/kyazdani42/nvim-tree.lua
	{
		"nvim-tree/nvim-tree.lua",
		opts = overrides.tree,
	},

	{
		"max397574/better-escape.nvim",
		config = function()
			require("better_escape").setup()
		end,
		event = "InsertEnter",
	},

	-- https://github.com/lukas-reineke/indent-blankline.nvim
	{
		"lukas-reineke/indent-blankline.nvim",
		opts = overrides.indent,
	},

	-------------
	-- ESSENTIALS
	------------

	-- https://github.com/nvim-telescope/telescope.nvim
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			-- https://github.com/ahmedkhalf/project.nvim
			-- FIXME: Doesn't work with Telescope
			{
				"ahmedkhalf/project.nvim",
				lazy = false,
				config = function()
					require "custom/plugins/configs/project"
				end,
			},
		},
		opts = overrides.telescope,
	},

	-- https://github.com/roobert/search-replace.nvim
	{
		"roobert/search-replace.nvim",
		keys = { "gcI", "egcI" },
		config = function()
			require("search-replace").setup {
				-- optionally override defaults
				default_replace_single_buffer_options = "gcI",
				default_replace_multi_buffer_options = "egcI",
			}
		end,
	},

	-- https://github.com/nvim-pack/nvim-spectre
	{
		"nvim-pack/nvim-spectre",
		cmd = { "Spectre" },
		config = function()
			require("spectre").setup()
		end,
	},

	-- https://github.com/kevinhwang91/nvim-bqf
	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
	},

	-- https://github.com/gpanders/editorconfig.nvim
	-- TODO: REMOVE IN v0.9
	{
		"gpanders/editorconfig.nvim",
	},

	-- https://github.com/nathom/filetype.nvim
	{
		"nathom/filetype.nvim",
		lazy = false,
		config = function()
			require "custom/plugins/configs/filetype"
		end,
	},

	-- https://github.com/echasnovski/mini.nvim
	{
		"echasnovski/mini.nvim",
		lazy = false,
		branch = "main",
		config = function()
			require "custom/plugins/configs/mini"
		end,
	},

	-- https://github.com/Pocco81/auto-save.nvim
	{
		"Pocco81/auto-save.nvim",
		lazy = false,
		config = function()
			require "custom/plugins/configs/auto-save"
		end,
	},

	-- https://github.com/luukvbaal/stabilize.nvim
	-- TODO: REMOVE IN v0.9
	{
		"luukvbaal/stabilize.nvim",
		config = function()
			require("stabilize").setup()
		end,
	},

	-- https://github.com/folke/which-key.nvim
	{
		"folke/which-key.nvim",
		-- config = function()
		-- 	require "custom/plugins/configs/which-key"
		-- end,
		disable = false,
	},

	---------------------------------
	-- LSP (Language Server Protocol)
	---------------------------------
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- require "plugins.configs.lspconfig"
			-- require "custom.configs.lspconfig"
			require "custom/plugins/configs/lspconfig"
		end,
		dependencies = {
			-- https://github.com/jose-elias-alvarez/null-ls.nvim
			{
				"jose-elias-alvarez/null-ls.nvim",
				config = function()
					require("custom.plugins.configs.null-ls").setup()
					require "custom.plugins.configs.typescript"
				end,
				dependencies = {
					-- https://github.com/folke/neodev.nvim
					"folke/neodev.nvim",
					-- https://github.com/jose-elias-alvarez/typescript.nvim
					{
						"jose-elias-alvarez/typescript.nvim",
					},
				},
			},
		},
	},

	-- https://github.com/folke/lsp-trouble.nvim
	{
		"folke/lsp-trouble.nvim",
		config = function()
			require "custom/plugins/configs/lsp-trouble"
		end,
	},

	----------
	--  MOTION
	----------

	-- https://github.com/mg979/vim-visual-multi
	{
		"mg979/vim-visual-multi",
		lazy = false,
	},

	-- https://github.com/chaoren/vim-wordmotion
	{
		"chaoren/vim-wordmotion",
		lazy = false,
	},

	-- https://github.com/ggandor/lightspeed.nvim
	{
		"ggandor/lightspeed.nvim",
		config = function()
			require "custom/plugins/configs/lightspeed"
		end,
	},

	-- https://github.com/monaqa/dial.nvim
	{
		"monaqa/dial.nvim",
		lazy = false,
		config = function()
			require "custom.plugins.configs.dial"
		end,
	},

	-- https://github.com/cbochs/portal.nvim
	{
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

	-- https://github.com/AckslD/nvim-revJ.lua
	-- {"AckslD/nvim-revJ.lua",
	-- 	config = function()
	-- 		require "custom/plugins/configs/revj"
	-- 	end,
	-- },

	----------------------
	-- UI (User Interface)
	----------------------

	-- https://github.com/karb94/neoscroll.nvim
	{
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

	-- https://github.com/folke/zen-mode.nvim
	{
		"folke/zen-mode.nvim",
		cmd = { "ZenMode" },
		config = function()
			require "custom/plugins/configs/zen-mode"
		end,
		dependencies = {
			-- https://github.com/folke/twilight.nvim
			{
				"folke/twilight.nvim",
				cmd = { "Twilight" },
				config = function()
					require "custom/plugins/configs/twilight"
				end,
			},
		},
	},

	---------
	-- SYNTAX
	---------

	-- https://github.com/folke/todo-comments.nvim
	{
		"folke/todo-comments.nvim",
		config = function()
			require "custom/plugins/configs/todo-comments"
		end,
		lazy = false,
	},

	--------
	-- OTHER
	--------

	-- https://github.com/stevearc/oil.nvim
	{
		"stevearc/oil.nvim",
		-- TODO: https://github.com/stevearc/oil.nvim/issues/75
		lazy = false,
		config = function()
			require("oil").setup()
		end,
	},

	-- https://github.com/ellisonleao/glow.nvim
	{
		"ellisonleao/glow.nvim",
		config = function()
			require "custom/plugins/configs/glow"
		end,
	},

	-- https://github.com/axieax/urlview.nvim
	{
		"axieax/urlview.nvim",
		cmd = { "UrlView" },
		config = function()
			require "custom/plugins/configs/urlview"
		end,
	},

	-- https://github.com/wakatime/vim-wakatime
	{
		"wakatime/vim-wakatime",
		lazy = false,
	},

	-- https://github.com/browserslist/vim-browserslist
	{
		"browserslist/vim-browserslist",
	},

	--------------
	-- COMPLETIONS
	--------------

	-- https://github.com/hrsh7th/nvim-cmp
	{
		"nvim-cmp",
		lazy = false,
		dependencies = {
			-- https://github.com/ray-x/cmp-treesitter
			{
				"ray-x/cmp-treesitter",
				lazy = false,
			},
			-- https://github.com/hrsh7th/cmp-emoji
			{
				"hrsh7th/cmp-emoji",
				lazy = false,
			},
			-- https://github.com/David-Kunz/cmp-npm
			{
				"David-Kunz/cmp-npm",
				event = "BufEnter package.json",
			},
			-- https://github.com/zbirenbaum/copilot.lua
			{
				"zbirenbaum/copilot.lua",
				config = function()
					vim.schedule(function()
						require "custom/plugins/configs/copilot"
					end)
				end,
				dependencies = {
					-- https://github.com/zbirenbaum/copilot-cmp
					{
						"zbirenbaum/copilot-cmp",
						config = function()
							require("copilot_cmp").setup()
						end,
					},
				},
				event = "InsertEnter",
			},
		},
		opts = overrides.cmp,
	},

	------------------------------
	-- DE (Developer's Experience)
	------------------------------

	-- https://github.com/beauwilliams/focus.nvim
	{
		"beauwilliams/focus.nvim",
		cmd = { "FocusSplitNicely", "FocusSplitCycle" },
		config = function()
			require "custom.plugins.configs.focus"
		end,
		-- module = "focus",
	},

	-- https://github.com/vuki656/package-info.nvim
	{
		"vuki656/package-info.nvim",
		event = "BufEnter package.json",
		config = function()
			require "custom.plugins.configs.package-info"
		end,
		dependencies = {
			-- https://github.com/MunifTanjim/nui.nvim
			{
				"MunifTanjim/nui.nvim",
				lazy = false,
			},
		},
	},

	-- https://github.com/Rawnly/gist.nvim
	{
		"Rawnly/gist.nvim",
	},

	-- https://github.com/RRethy/vim-illuminate
	{
		"RRethy/vim-illuminate",
		config = function()
			require "custom/plugins/configs/illuminate"
		end,
		event = "CursorHold",
		-- module = "illuminate",
	},

	-- https://github.com/cbochs/grapple.nvim
	{
		"cbochs/grapple.nvim",
		config = function()
			require "custom/plugins/configs/grapple"
		end,
	},

	-- https://github.com/RaafatTurki/hex.nvim
	{
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

	{
		"jackMort/ChatGPT.nvim",
		cmd = {
			"ChatGPT",
			"ChatGPTActAs",
			"ChatGPTInlineEdit",
			"ChatGPTEditWithInstructions",
		},
		config = function()
			require "custom/plugins/configs/chatgpt"
		end,
	},
}

return plugins
