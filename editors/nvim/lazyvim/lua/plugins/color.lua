return {
	{
		-- https://github.com/uga-rosa/ccc.nvim
		"uga-rosa/ccc.nvim",
		event = "BufRead",
		config = function()
			local ccc = require("ccc")
			ccc.setup({
				alpha_show = "show",
				highlighter = {
					auto_enable = true,
					lsp = true,
				},
				convert = {
					{ ccc.picker.hex, ccc.output.css_oklch },
					{ ccc.picker.css_rgb, ccc.output.css_oklch },
					{ ccc.picker.css_hsl, ccc.output.css_oklch },
				},
				inputs = {
					ccc.input.rgb,
					ccc.input.hsl,
					ccc.input.hwb,
					ccc.input.lab,
					ccc.input.lch,
					ccc.input.oklab,
					ccc.input.oklch,
					ccc.input.cmyk,
					ccc.input.hsluv,
					ccc.input.okhsl,
					ccc.input.hsv,
					ccc.input.okhsv,
					ccc.input.xyz,
				},
				--[[ recognize = { ]]
				--[[ 	input = true, ]]
				--[[ }, ]]
			})
		end,
	},
}
