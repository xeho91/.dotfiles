-- https://gthub.com/Th3Whit3Wolf/Dusk-til-Dawn.nv

local g = vim.g

g.dusk_til_dawn_morning = 7
g.dusk_til_dawn_night = 19
g.dusk_til_dawn_light_theme = "tokyonight"
g.dusk_til_dawn_dark_theme = "tokyonight"
g.dusk_til_dawn_debug = true
g.dusk_til_dawn_sway_colord = false

require("Dusk-til-Dawn").timeMan(
	function()
		-- vim.o.background = "light"
		g.tokyonight_style = "storm"
	end,
	function()
		-- vim.o.background = "dark"
		g.tokyonight_style = "night"
	end
)()
