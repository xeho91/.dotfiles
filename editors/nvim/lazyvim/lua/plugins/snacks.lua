return {
	"folke/snacks.nvim",
	opts = {
		gitbrowse = {
			remote_patterns = {
				{ "^git@github%-[^:]+:(.+)$", "https://github.com/%1" },
				{ "^(https?://.*)%.git$", "%1" },
				{ "^git@(.+):(.+)%.git$", "https://%1/%2" },
				{ "^git@(.+):(.+)$", "https://%1/%2" },
				{ "^git@(.+)/(.+)$", "https://%1/%2" },
				{ "^org%-%d+@(.+):(.+)%.git$", "https://%1/%2" },
				{ "^ssh://git@(.*)$", "https://%1" },
				{ "^ssh://([^:/]+)(:%d+)/(.*)$", "https://%1/%3" },
				{ "^ssh://([^/]+)/(.*)$", "https://%1/%2" },
				{ "ssh%.dev%.azure%.com/v3/(.*)/(.*)$", "dev.azure.com/%1/_git/%2" },
				{ "^https://%w*@(.*)", "https://%1" },
				{ "^git@(.*)", "https://%1" },
				{ ":%d+", "" },
				{ "%.git$", "" },
			},
		},
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
						copy_notification = function(_picker, item)
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
