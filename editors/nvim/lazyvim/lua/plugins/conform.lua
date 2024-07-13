return {
	-- https://github.com/stevearc/conform.nvim
	"stevearc/conform.nvim",
	optional = true,
	opts = {
		formatters_by_ft = {
			["javascript"] = { "biome" },
			["javascriptreact"] = { "biome" },
			["typescript"] = { "biome" },
			["typescriptreact"] = { "biome" },
			["vue"] = { "prettier" },
			["css"] = { "prettier" },
			["scss"] = { "prettier" },
			["less"] = { "prettier" },
			["html"] = { "prettier" },
			["json"] = { "biome" },
			["jsonc"] = { "biome" },
			["yaml"] = { "prettier" },
			["markdown"] = { "markdownlint" },
			["markdown.mdx"] = { "markdownlint" },
			["graphql"] = { "prettier" },
			["handlebars"] = { "prettier" },
		},
	},
}
