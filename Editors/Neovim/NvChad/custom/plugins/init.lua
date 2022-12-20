return {
	-- NOTE: `MAINTAINED` => any development in the past of 6 months
    
    ------------
    -- OVERRIDES
    ------------
    ["lukas-reineke/indent-blankline.nvim"] = {
        override_options = require "custom/plugins/overrides/indent-blankline",
    },
    ["kyazdani42/nvim-tree.lua"] = {
        override_options = require "custom/plugins/overrides/nvim-tree",
    },
    -- nvim_cmp = require("custom/plugins/cmp"),
    ["numToStr/Comment.nvim"] = {
        override_options = require "custom/plugins/overrides/comment",
    },
    -- ["nvim-treesitter/nvim-treesitter"] = require "custom/plugins/overrides/treesitter",

	-------------
	-- ESSENTIALS
	-------------

	-- https://github.com/gpanders/editorconfig.nvim
	-- MAINTAINED: Yes
	-- LAST_COMMIT: 17 Feb 2022
	["gpanders/editorconfig.nvim"] = {},

	-- https://github.com/nathom/filetype.nvim
	-- MAINTAINED: Yes
	-- LAST_COMMIT: 22 Apr 2022
	["nathom/filetype.nvim"] = {
        config = function()
            require("custom/plugins/filetype")
        end,
    },

	-- https://github.com/echasnovski/mini.nvim
	-- MAINTAINED: Yes
	-- LAST_COMMIT: 1 May 2022
	["echasnovski/mini.nvim"] = {
		branch = "stable",
		config = function()
			require "custom/plugins/mini"
		end,
	},

	-- https://github.com/Pocco81/AutoSave.nvim
	-- MAINTAINED: Yes
	-- LAST_COMMIT: 14 Dec 2021
	["Pocco81/auto-save.nvim"] = {
		config = function()
			require "custom/plugins/auto-save"
		end,
	},

	-- https://github.com/luukvbaal/stabilize.nvim
	-- MAINTAINED: Yes
	-- LAST_COMMIT: 11 Mar 2022
	["luukvbaal/stabilize.nvim"] = {
		config = function()
			require("stabilize").setup()
		end,
	},

	-- https://github.com/ahmedkhalf/project.nvim
	-- MAINTAINED: Yes
	-- LAST_COMMIT: 25 Apr 2022
	["ahmedkhalf/project.nvim"] = {
		config = function()
			require "custom/plugins/project"
		end,
	},

	---------------------------------
	-- LSP (Language Server Protocol)
	---------------------------------
	["neovim/nvim-lspconfig"] = {
		config = function()
			require "plugins/configs/lspconfig"
			require "custom/plugins/lspconfig"
		end,
	},

	-- https://github.com/jose-elias-alvarez/null-ls.nvim
	-- MAINTAINED: yes
	-- LAST_COMMIT: 1 May 2022
	["jose-elias-alvarez/null-ls.nvim"] = {
		after = "nvim-lspconfig",
		config = function()
			require("custom/plugins/null-ls").setup()
		end,
		requires = {
			-- https://github.com/jose-elias-alvarez/nvim-lsp-ts-utils
			-- MAINTAINED: Yes
			"jose-elias-alvarez/typescript.nvim",

			-- https://github.com/folke/neodev.nvim
			-- MAINTAINED: Yes
			"folke/neodev.nvim",
		},
	},

	-- https://github.com/folke/lsp-trouble.nvim
	-- MAINTAINED: Yes
	-- LAST_COMMIT: 18 Mar 2022
	["folke/lsp-trouble.nvim"] = {
		config = function()
			require "custom/plugins/lsp-trouble"
		end,
	},

	-- {
	-- 	-- https://github.com/ray-x/navigator.lua
	-- 	-- MAINTAINED: Yes
	-- 	"ray-x/navigator.lua",
	-- 	requires = {
	-- 		"ray-x/guihua.lua",
	-- 		run = "cd lua/fzy && make",
	-- 	},
	-- },

	----------
	--  MOTION
	----------

	-- https://github.com/mg979/vim-visual-multi
	-- MAINTAINED: Yes
	-- LAST_COMMIT: 8 Apr 2022
	["mg979/vim-visual-multi"] = {},

	-- https://github.com/chaoren/vim-wordmotion
	-- MAINTAINED: Yes
	-- LAST_COMMIT: 23 Apr 2022
	["chaoren/vim-wordmotion"] = {},

	-- https://github.com/ggandor/lightspeed.nvim
	-- MAINTAINED: Yes
	-- LAST_COMMIT: 4 Apr 2022
	["ggandor/lightspeed.nvim"] = {
		config = function()
			require "custom/plugins/lightspeed"
		end,
	},

	-- https://github.com/monaqa/dial.nvim
	-- MAINTAINED: YES
	-- LAST_COMMIT: 5 Apr 2022
	["monaqa/dial.nvim"] = {
		config = function()
			require "custom/plugins/dial"
		end,
	},

	-- https://github.com/AckslD/nvim-revJ.lua
	-- MAINTAINED: yes
	-- LAST_COMMIT: 11 Apr 2022
	["AckslD/nvim-revJ.lua"] = {
		config = function()
			require "custom/plugins/revj"
		end,
	},

	-- https://github.com/booperlv/nvim-gomove
	-- MAINTAINED: yes
	-- LAST_COMMIT: 2 Apr 2022
	["booperlv/nvim-gomove"] = {
		keys = { "<A-h>", "<A-j>", "<A-k>", "<A-l>" },
		config = function()
			require "custom/plugins/gomove"
		end,
	},

	----------------------
	-- UI (User Interface)
	----------------------

	-- https://github.com/karb94/neoscroll.nvim
	-- MAINTAINED: Yes
	-- LAST_COMMIT: 13 Jan 2022
	["karb94/neoscroll.nvim"] = {
		config = function()
			require("neoscroll").setup()
		end,
	},

	-- https://github.com/folke/zen-mode.nvim
	-- MAINTAINED: Yes
	-- LAST_COMMIT: 17 Nov 2021
	["folke/zen-mode.nvim"] = {
		cmd = { "ZenMode" },
		config = function()
			require "custom/plugins/zen-mode"
		end,
		requires = {
			-- https://github.com/folke/twilight.nvim
			-- MAINTAINED: No
			-- LAST_COMMIT: 6 Apr 2021
			"folke/twilight.nvim",
			cmd = { "Twilight" },
			config = function()
				require "custom/plugins/twilight"
			end,
		},
	},

	---------
	-- SYNTAX
	---------

	-- https://github.com/folke/todo-comments.nvim
	-- MAINTAINED: Yes
	-- LAST_COMMIT: 19 Jan 2022
	["folke/todo-comments.nvim"] = {
		config = function()
			require "custom/plugins/todo-comments"
		end,
	},

	--------
	-- OTHER
	--------

	-- https://github.com/folke/which-key.nvim
	-- MAINTAINED: Yes
	-- LAST_COMMIT: 18 Mar 2022
	["folke/which-key.nvim"] = {
		disable = false,
		-- cmd = { "WhichKey" },
		-- config = function()
		-- 	require("custom/plugins/which-key")
		-- end,
	},

	-- https://github.com/ellisonleao/glow.nvim
	-- MAINTAINED: Yes
	-- LAST_COMMIT: 13 Apr 2022
	["ellisonleao/glow.nvim"] = {
		config = function()
			require "custom/plugins/glow"
		end,
	},

	-- https://github.com/axieax/urlview.nvim
	-- MAINTAINED: Yes
	-- LAST_COMMIT: 25 Apr 2022
	["axieax/urlview.nvim"] = {
		config = function()
			require "custom/plugins/urlview"
		end,
	},

	--------------
	-- COMPLETIONS
	--------------

	-- https://github.com/ray-x/cmp-treesitter
	-- MAINTAINED: Yes
	-- LAST_COMMIT: 25 Apr 2022
	["ray-x/cmp-treesitter"] = {
		after = "nvim-cmp",
	},

	-- https://github.com/hrsh7th/cmp-emoji
	-- MAINTAINED: No
	-- LAST_COMMIT: 28 Sep 2021
	["hrsh7th/cmp-emoji"] = {
		after = "nvim-cmp",
	},

	-- https://github.com/David-Kunz/cmp-npm
	-- MAINTAINED: No
	-- LAST_COMMIT: 27 Oct 2021
	["David-Kunz/cmp-npm"] = {
		after = "nvim-cmp",
	},

	------------------------------
	-- DE (Developer's Experience)
	------------------------------

	-- https://github.com/beauwilliams/focus.nvim
	-- MAINTAINED: Yes
	-- LAST_COMMIT: 9 Mar 2022
	["beauwilliams/focus.nvim"] = {
		cmd = { "FocusSplitNicely", "FocusSplitCycle" },
		module = "focus",
		config = function()
			require "custom/plugins/focus"
		end,
	},

	-- https://github.com/vuki656/package-info.nvim
	-- MAINTAINED: Yes
	-- LAST_COMMIT: 18 Feb 2022
	["vuki656/package-info.nvim"] = {
		config = function()
			require "custom/plugins/package-info"
		end,
		requires = {
			-- https://github.com/MunifTanjim/nui.nvim
			"MunifTanjim/nui.nvim",
		},
	},

	-- https://github.com/danymat/neogen
	-- MAINTAINED: Yes
	-- LAST_COMMIT: 27 Apr 2022
	["danymat/neogen"] = {
		after = "nvim-treesitter",
		config = function()
			require "custom/plugins/neogen"
		end,
	},

	-- https://github.com/RRethy/vim-illuminate
	-- MAINTAINED: Yes
	-- LAST_COMMIT: 10 Apr 2022
	["RRethy/vim-illuminate"] = {
		event = "CursorHold",
		module = "illuminate",
		config = function()
			require "custom/plugins/illuminate"
		end,
	},

	-- https://github.com/nvim-neorg/neorg
	-- MAINTAINED: Yes
	-- LAST_COMMIT: 1 May 2022
	["nvim-neorg/neorg"] = {
		setup = vim.cmd "autocmd BufRead,BufNewFile *.norg setlocal filetype=norg",
		after = { "nvim-treesitter" },
		ft = "norg",
		config = function()
			require "custom/plugins/neorg"
		end,
		requires = {
			"nvim-lua/plenary.nvim",
			-- https://github.com/nvim-neorg/neorg-telescope
			-- "nvim-neorg/neorg-telescope",
		},
	},

    -- https://github.com/cbochs/grapple.nvim
    -- MAINTAINED: YES
    -- LAST_COMMIT: 25 Oct 2022
    ["cbochs/grapple.nvim"] = {
        config = function()
            require("custom/plugins/grapple")
        end,
    },

	-----------------
	-- (T)ree(S)itter
	-----------------

	-- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
	-- MAINTAINED: Yes
	-- LAST_COMMIT: 7 Apr 2022
	["JoosepAlviste/nvim-ts-context-commentstring"] = {
		after = "nvim-treesitter",
	},

	-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
	-- MAINTAINED: Yes
	-- LAST_COMMIT: 21 Apr 2022
	["nvim-treesitter/nvim-treesitter-textobjects"] = {
		after = "nvim-treesitter",
	},

	-- https://github.com/RRethy/nvim-treesitter-textsubjects
	-- MAINTAINED: Yes
	-- LAST_COMMIT: 5 Apr 2022
	["RRethy/nvim-treesitter-textsubjects"] = {
		after = "nvim-treesitter",
	},

	-- https://github.com/haringsrob/nvim_context_vt
	-- MAINTAINED: Yes
	-- LAST_COMMIT: 19 Apr 2022
	["haringsrob/nvim_context_vt"] = {
		after = "nvim-treesitter",
	},

	-- https://github.com/nvim-treesitter/playground
	-- MAINTAINED: Yes
	-- LAST_COMMIT: 1 May 2022
	["nvim-treesitter/playground"] = {
		after = "nvim-treesitter",
		cmd = "TSHighlightCapturesUnderCursor",
	},

	-- https://github.com/p00f/nvim-ts-rainbow
	-- MAINTAINED: Yes
	-- LAST_COMMIT: 3 May 2022
	["p00f/nvim-ts-rainbow"] = {
		after = "nvim-treesitter",
	},

	-- https://github.com/windwp/nvim-ts-autotag
	-- MAINTAINED: Yes
	-- LAST_COMMIT: 22 Apr 2022
	["windwp/nvim-ts-autotag"] = {
		after = "nvim-treesitter",
	},
}
