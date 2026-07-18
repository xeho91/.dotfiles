return {
	"nvim-mini/mini.snippets",
	event = "VeryLazy",
	opts = function()
		local gen_loader = require("mini.snippets").gen_loader
		return {
			snippets = {
				-- Load all friendly-snippets
				gen_loader.from_lang(),
				-- Load your custom snippets
				gen_loader.from_file("~/.config/nvim/snippets/all.json"),
			},
		}
	end,
}
