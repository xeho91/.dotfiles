return {
	{
		-- https://github.com/monaqa/dial.nvim
		"monaqa/dial.nvim",
		-- stylua: ignore
		keys = {
			{ mode = "n", "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
			{ mode = "n", "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
			{ mode = "v" ,"<C-a>", function() return require("dial.map").inc_visual() end, expr = true, desc = "Increment" },
			{ mode = "v" ,"<C-x>", function() return require("dial.map").dec_visual() end, expr = true, desc = "Decrement" },
		},
		config = function()
			local augend = require("dial.augend")
			require("dial.config").augends:register_group({
				default = {
					augend.integer.alias.decimal,
					augend.integer.alias.decimal_int,
					augend.integer.alias.hex,
					augend.integer.alias.octal,
					augend.integer.alias.binary,
					augend.date.alias["%Y/%m/%d"],
					augend.date.alias["%m/%d/%Y"],
					augend.date.alias["%d/%m/%Y"],
					augend.date.alias["%m/%d/%y"],
					augend.date.alias["%d/%m/%y"],
					augend.date.alias["%m/%d"],
					augend.date.alias["%-m/%-d"],
					augend.date.alias["%Y-%m-%d"],
					augend.date.alias["%Y年%-m月%-d日"],
					augend.date.alias["%Y年%-m月%-d日(%ja)"],
					augend.date.alias["%H:%M:%S"],
					augend.date.alias["%H:%M"],
					augend.constant.alias.ja_weekday,
					augend.constant.alias.ja_weekday_full,
					augend.constant.alias.bool,
					augend.constant.alias.alpha,
					augend.constant.alias.Alpha,
					augend.constant.new({
						elements = { "and", "or" },
						word = true,
						cyclic = true,
					}),
					augend.constant.new({
						elements = { "AND", "OR" },
						word = true,
						cyclic = true,
					}),
					augend.constant.new({
						elements = { "enable", "disable" },
						word = true,
						cyclic = true,
					}),
					augend.constant.new({
						elements = { "Enable", "Disable" },
						word = true,
						cyclic = true,
					}),
					augend.constant.new({
						elements = { "ENABLE", "DISABLE" },
						word = true,
						cyclic = true,
					}),
					augend.constant.new({
						elements = { "on", "off" },
						word = true,
						cyclic = true,
					}),
					augend.constant.new({
						elements = { "On", "Off" },
						word = true,
						cyclic = true,
					}),
					augend.constant.new({
						elements = { "ON", "OFF" },
						word = true,
						cyclic = true,
					}),
					augend.constant.new({
						elements = { "info", "warning", "error" },
						word = true,
						cyclic = true,
					}),
					augend.constant.new({
						elements = { "INFO", "WARN", "ERROR" },
						word = true,
						cyclic = true,
					}),
					augend.constant.new({
						elements = { "Info", "Warn", "Error" },
						word = true,
						cyclic = true,
					}),
					augend.constant.new({
						elements = { "TODO", "FIXME" },
						word = true,
						cyclic = true,
					}),
					augend.constant.new({
						elements = { "&&", "||" },
						word = false,
						cyclic = true,
					}),
					augend.constant.new({
						elements = { "up", "down" },
						word = true,
						cyclic = true,
					}),
					augend.constant.new({
						elements = { "Up", "Down" },
						word = true,
						cyclic = true,
					}),
					augend.constant.new({
						elements = { "UP", "DOWN" },
						word = true,
						cyclic = true,
					}),
					augend.constant.new({
						elements = { "top", "left", "right", "bottom" },
						word = true,
						cyclic = true,
					}),
					augend.constant.neW({
						ELEMENTS = { "Top", "Left", "Right", "Bottom" },
						word = true,
						cyclic = true,
					}),
					augend.constant.new({
						elements = { "TOP", "LEFT", "RIGHT", "BOTTOM" },
						word = true,
						cyclic = true,
					}),
					augend.constant.new({
						elements = { "north", "east", "south", "west" },
						word = true,
						cyclic = true,
					}),
					augend.constant.new({
						elements = { "North", "East", "South", "West" },
						word = true,
						cyclic = true,
					}),
					augend.constant.new({
						elements = { "NORTH", "EAST", "SOUTH", "WEST" },
						word = true,
						cyclic = true,
					}),
					augend.constant.new({
						elements = { "min", "max" },
						word = true,
						cyclic = true,
					}),
					augend.constant.new({
						elements = { "Min", "Max" },
						word = true,
						cyclic = true,
					}),
					augend.constant.new({
						elements = { "MIN", "MAX" },
						word = true,
						cyclic = true,
					}),
					augend.semver.alias.semver,
				},

				typescript = {
					augend.integer.alias.decimal,
					augend.integer.alias.hex,
					augend.constant.new({ elements = { "let", "const" } }),
				},

				visual = {
					augend.integer.alias.decimal,
					augend.integer.alias.hex,
					augend.date.alias["%Y/%m/%d"],
					augend.constant.alias.alpha,
					augend.constant.alias.Alpha,
				},
			})
		end,
	},
}
