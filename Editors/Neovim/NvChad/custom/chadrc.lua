return {
	mappings = require "custom/mappings",

	options = {
		user = function()
			require "custom/options"
		end,
	},

	plugins = require "custom/plugins",

	ui = {
		theme = "tokyonight",
	},
}
