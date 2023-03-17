
print("Hello")

-- https://github.com/vuki656/package-info.nvim
require("package-info").setup {
	colors = {
		up_to_date = "#3C4048", -- Text color for up to date package virtual text
		outdated = "#d19a66", -- Text color for outdated package virtual text
	},

	icons = {
		enable = true, -- Whether to display icons
		style = {
			up_to_date = "|  ", -- Icon for up to date packages
			outdated = "|  ", -- Icon for outdated packages
		},
	},

	autostart = true, -- Whether to autostart when `package.json` is opened
	hide_up_to_date = true, -- It hides up to date versions when displaying virtual text
	hide_unstable_versions = false, -- It hides unstable versions from version list e.g next-11.1.3-canary3

	-- Can be `npm`, `yarn`, or `pnpm`. Used for `delete`, `install` etc...
	-- The plugin will try to auto-detect the package manager based on
	-- `yarn.lock` or `package-lock.json`. If none are found it will use the
	-- provided one, if nothing is provided it will use `yarn`
	package_manager = "pnpm",
}

-- Show dependency versions
vim.keymap.set(
	{ "n" },
	"<LEADER>ns",
	require("package-info").show,
	{ silent = true, noremap = true }
)

-- Hide dependency versions
vim.keymap.set(
	{ "n" },
	"<LEADER>nc",
	require("package-info").hide,
	{ silent = true, noremap = true }
)

-- Toggle dependency versions
vim.keymap.set(
	{ "n" },
	"<LEADER>nt",
	require("package-info").toggle,
	{ silent = true, noremap = true }
)

-- Update dependency on the line
vim.keymap.set(
	{ "n" },
	"<LEADER>nu",
	require("package-info").update,
	{ silent = true, noremap = true }
)

-- Delete dependency on the line
vim.keymap.set(
	{ "n" },
	"<LEADER>nd",
	require("package-info").delete,
	{ silent = true, noremap = true }
)

-- Install a new dependency
vim.keymap.set(
	{ "n" },
	"<LEADER>ni",
	require("package-info").install,
	{ silent = true, noremap = true }
)


-- Install a different dependency version
vim.keymap.set(
	{ "n" },
	"<LEADER>np",
	require("package-info").change_version,
	{ silent = true, noremap = true }
)
