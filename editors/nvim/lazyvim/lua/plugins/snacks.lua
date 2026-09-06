return {
	"folke/snacks.nvim",
	opts = {
		explorer = {
			replace_netrw = true,
		},
		picker = {
			sources = {
				explorer = {
					auto_open = false,
				},
				notifications = {
				actions = {
					copy_notification = function(picker, item)
						if item and item.item then
							vim.fn.setreg("+", item.item.msg)
							vim.notify("Copied notification content")
						end
					end,
				},
				win = {
					input = {
						keys = {
							["<C-y>"] = {
								"copy_notification",
								mode = { "n", "i" },
								desc = "Copy notification",
							},
						},
					},
				},
			},
			},
		},
	},
}
