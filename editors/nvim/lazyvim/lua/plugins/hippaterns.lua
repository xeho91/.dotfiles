return {
	{
		-- https://github.com/echasnovski/mini.hipatterns
		"echasnovski/mini.hipatterns",
		opts = function()
			local hi = require("mini.hipatterns")
			return {
				-- custom LazyVim option to enable the tailwind integration
				tailwind = {
					enabled = true,
					ft = { "typescriptreact", "javascriptreact", "css", "javascript", "typescript", "html" },
					-- full: the whole css class will be highlighted
					-- compact: only the color will be highlighted
					style = "full",
				},
				highlighters = {
					hex_color = hi.gen_highlighter.hex_color({ priority = 2000 }),
				},
			}
		end,
	},
}
