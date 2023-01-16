return {
	------------
	-- OVERRIDES
	------------

	["numToStr/Comment.nvim"] = {
		override_options = require "custom/plugins/overrides/comment",
	},

	["lukas-reineke/indent-blankline.nvim"] = {
		override_options = require "custom/plugins/overrides/indent-blankline",
	},

	["kyazdani42/nvim-tree.lua"] = {
		override_options = require "custom/plugins/overrides/nvim-tree",
	},

	-- https://github.com/nvim-treesitter/nvim-treesitter
	["nvim-treesitter/nvim-treesitter"] = {
		override_options = require "custom/plugins/overrides/treesitter",
	},

	-- https://github.com/nvim-telescope/telescope.nvim
	["nvim-telescope/telescope.nvim"] = {
		override_options = require "custom/plugins/overrides/telescope",
	},

	-------------
	-- ESSENTIALS
	-------------

	-- https://github.com/roobert/search-replace.nvim
	["roobert/search-replace.nvim"] = {
		config = function()
			require("search-replace").setup {
				-- optionally override defaults
				default_replace_single_buffer_options = "gcI",
				default_replace_multi_buffer_options = "egcI",
			}
		end,
	},

	-- https://github.com/nvim-pack/nvim-spectre
	["nvim-pack/nvim-spectre"] = {
		cmd = { "Spectre" },
		config = function()
			require("spectre").setup()
		end,
	},
	-- https://github.com/kevinhwang91/nvim-bqf
	["kevinhwang91/nvim-bqf"] = { ft = "qf" },

	-- https://github.com/gpanders/editorconfig.nvim
	-- TODO: REMOVE IN v0.9
	["gpanders/editorconfig.nvim"] = {},

	-- https://github.com/nathom/filetype.nvim
	["nathom/filetype.nvim"] = {
		config = function()
			require "custom/plugins/configs/filetype"
		end,
	},

	-- https://github.com/echasnovski/mini.nvim
	["echasnovski/mini.nvim"] = {
		branch = "main",
		config = function()
			require "custom/plugins/configs/mini"
		end,
	},

	-- https://github.com/Pocco81/auto-save.nvim
	["Pocco81/auto-save.nvim"] = {
		config = function()
			require "custom/plugins/configs/auto-save"
		end,
	},

	-- https://github.com/luukvbaal/stabilize.nvim
	-- TODO: REMOVE IN v0.9
	["luukvbaal/stabilize.nvim"] = {
		config = function()
			require("stabilize").setup()
		end,
	},

	-- https://github.com/ahmedkhalf/project.nvim
	-- FIXME: Doesn't work with Telescope
	["ahmedkhalf/project.nvim"] = {
		config = function()
			require "custom/plugins/configs/project"
		end,
		requires = {
			"nvim-telescope/telescope.nvim",
		},
	},

	-- https://github.com/folke/which-key.nvim
	["folke/which-key.nvim"] = {
		-- config = function()
		-- 	require "custom/plugins/configs/which-key"
		-- end,
		disable = false,
	},

	---------------------------------
	-- LSP (Language Server Protocol)
	---------------------------------
	["neovim/nvim-lspconfig"] = {
		config = function()
			require "custom/plugins/configs/lspconfig"
		end,
	},

	-- https://github.com/jose-elias-alvarez/null-ls.nvim
	["jose-elias-alvarez/null-ls.nvim"] = {
		after = "nvim-lspconfig",
		config = function()
			require "custom/plugins/configs/typescript"
			require("custom/plugins/configs/null-ls").setup()
		end,
		requires = {
			-- https://github.com/folke/neodev.nvim
			"folke/neodev.nvim",
			-- https://github.com/jose-elias-alvarez/typescript.nvim
			"jose-elias-alvarez/typescript.nvim",
		},
	},

	-- https://github.com/folke/lsp-trouble.nvim
	["folke/lsp-trouble.nvim"] = {
		config = function()
			require "custom/plugins/configs/lsp-trouble"
		end,
	},

	----------
	--  MOTION
	----------

	-- https://github.com/mg979/vim-visual-multi
	["mg979/vim-visual-multi"] = {},

	-- https://github.com/chaoren/vim-wordmotion
	["chaoren/vim-wordmotion"] = {},

	-- https://github.com/ggandor/lightspeed.nvim
	["ggandor/lightspeed.nvim"] = {
		config = function()
			require "custom/plugins/configs/lightspeed"
		end,
	},

	-- https://github.com/monaqa/dial.nvim
	["monaqa/dial.nvim"] = {
		config = function()
			require "custom/plugins/configs/dial"
		end,
	},

	-- https://github.com/cbochs/portal.nvim
	["cbochs/portal.nvim"] = {
		config = function()
			print "Hello"
			require "custom/plugins/configs/portal"
		end,
		requires = {
			"cbochs/grapple.nvim",
			-- https://github.com/ThePrimeagen/harpoon
			"ThePrimeagen/harpoon",
		},
	},

	-- https://github.com/AckslD/nvim-revJ.lua
	-- ["AckslD/nvim-revJ.lua"] = {
	-- 	config = function()
	-- 		require "custom/plugins/configs/revj"
	-- 	end,
	-- },

	----------------------
	-- UI (User Interface)
	----------------------

	-- https://github.com/karb94/neoscroll.nvim
	["karb94/neoscroll.nvim"] = {
		config = function()
			require("neoscroll").setup()
		end,
	},

	-- https://github.com/folke/zen-mode.nvim
	["folke/zen-mode.nvim"] = {
		cmd = { "ZenMode" },
		config = function()
			require "custom/plugins/configs/zen-mode"
		end,
		requires = {
			-- https://github.com/folke/twilight.nvim
			"folke/twilight.nvim",
			cmd = { "Twilight" },
			config = function()
				require "custom/plugins/configs/twilight"
			end,
		},
	},

	---------
	-- SYNTAX
	---------

	-- https://github.com/folke/todo-comments.nvim
	["folke/todo-comments.nvim"] = {
		config = function()
			require "custom/plugins/configs/todo-comments"
		end,
	},

	--------
	-- OTHER
	--------

	-- https://github.com/stevearc/oil.nvim
	["stevearc/oil.nvim"] = {
		config = function()
			require("oil").setup()
		end,
	},

	-- https://github.com/ellisonleao/glow.nvim
	["ellisonleao/glow.nvim"] = {
		config = function()
			require "custom/plugins/configs/glow"
		end,
	},

	-- https://github.com/axieax/urlview.nvim
	["axieax/urlview.nvim"] = {
		config = function()
			require "custom/plugins/configs/urlview"
		end,
	},

	-- https://github.com/wakatime/vim-wakatime
	["wakatime/vim-wakatime"] = {},

	-- https://github.com/browserslist/vim-browserslist
	["browserslist/vim-browserslist"] = {},

	--------------
	-- COMPLETIONS
	--------------

	-- https://github.com/ray-x/cmp-treesitter
	["ray-x/cmp-treesitter"] = {
		after = "nvim-cmp",
	},

	-- https://github.com/hrsh7th/cmp-emoji
	["hrsh7th/cmp-emoji"] = {
		after = "nvim-cmp",
	},

	-- https://github.com/David-Kunz/cmp-npm
	["David-Kunz/cmp-npm"] = {
		after = "nvim-cmp",
	},

	-- https://github.com/zbirenbaum/copilot-cmp
	["zbirenbaum/copilot-cmp"] = {
		after = { "copilot.lua", "nvim-cmp" },
		config = function()
			require("copilot_cmp").setup()
		end,
	},

	------------------------------
	-- DE (Developer's Experience)
	------------------------------

	-- https://github.com/beauwilliams/focus.nvim
	["beauwilliams/focus.nvim"] = {
		cmd = { "FocusSplitNicely", "FocusSplitCycle" },
		module = "focus",
		config = function()
			require "custom/plugins/configs/focus"
		end,
	},

	-- https://github.com/vuki656/package-info.nvim
	["vuki656/package-info.nvim"] = {
		config = function()
			require "custom/plugins/configs/package-info"
		end,
		requires = {
			-- https://github.com/MunifTanjim/nui.nvim
			"MunifTanjim/nui.nvim",
		},
	},

	-- https://github.com/danymat/neogen
	["danymat/neogen"] = {
		after = "nvim-treesitter",
		config = function()
			require "custom/plugins/configs/neogen"
		end,
	},

	-- https://github.com/RRethy/vim-illuminate
	["RRethy/vim-illuminate"] = {
		event = "CursorHold",
		module = "illuminate",
		config = function()
			require "custom/plugins/configs/illuminate"
		end,
	},

	-- https://github.com/nvim-neorg/neorg
	-- MAINTAINED: Yes
	-- LAST_COMMIT: 1 May 2022
	-- ["nvim-neorg/neorg"] = {
	-- 	setup = vim.cmd "autocmd BufRead,BufNewFile *.norg setlocal filetype=norg",
	-- 	after = { "nvim-treesitter" },
	-- 	ft = "norg",
	-- 	config = function()
	-- 		require "custom/plugins/configs/neorg"
	-- 	end,
	-- 	requires = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		-- https://github.com/nvim-neorg/neorg-telescope
	-- 		-- "nvim-neorg/neorg-telescope",
	-- 	},
	-- },

	-- https://github.com/cbochs/grapple.nvim
	["cbochs/grapple.nvim"] = {
		config = function()
			require "custom/plugins/configs/grapple"
		end,
	},

	-----------------
	-- (T)ree(S)itter
	-----------------

	-- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
	["JoosepAlviste/nvim-ts-context-commentstring"] = {
		after = "nvim-treesitter",
	},

	-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
	["nvim-treesitter/nvim-treesitter-textobjects"] = {
		after = "nvim-treesitter",
	},

	-- https://github.com/RRethy/nvim-treesitter-textsubjects
	["RRethy/nvim-treesitter-textsubjects"] = {
		after = "nvim-treesitter",
	},

	-- https://github.com/haringsrob/nvim_context_vt
	["haringsrob/nvim_context_vt"] = {
		after = "nvim-treesitter",
	},

	-- https://github.com/nvim-treesitter/playground
	["nvim-treesitter/playground"] = {
		after = "nvim-treesitter",
		cmd = "TSHighlightCapturesUnderCursor",
	},

	-- https://github.com/p00f/nvim-ts-rainbow
	-- TODO: No longer maintained, needs to find replacement
	["p00f/nvim-ts-rainbow"] = {
		after = "nvim-treesitter",
	},

	-- https://github.com/windwp/nvim-ts-autotag
	["windwp/nvim-ts-autotag"] = {
		after = "nvim-treesitter",
	},

	-- https://github.com/CKolkey/ts-node-action
	-- TODO: Doesn't work on anything other than Lua
	["CKolkey/ts-node-action"] = {
		config = function()
			require "custom/plugins/configs/ts-node-action"
		end,
		requires = { "nvim-treesitter" },
	},

	-- https://github.com/RaafatTurki/hex.nvim
	["RaafatTurki/hex.nvim"] = {
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

	-- https://github.com/zbirenbaum/copilot.lua
	["zbirenbaum/copilot.lua"] = {
		event = "InsertEnter",
		config = function()
			vim.schedule(function()
				require "custom/plugins/configs/copilot"
			end)
		end,
	},

	["jackMort/ChatGPT.nvim"] = {
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
