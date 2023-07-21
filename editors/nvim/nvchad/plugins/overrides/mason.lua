-- https://github.com/williamboman/mason.nvim

return {
	ensure_installed = {
		-- lua stuff
		"lua-language-server",
		"stylua",

		-- web dev stuff
		"css-lsp",
		"html-lsp",
		"typescript-language-server",
		"deno",

        -- rust
        "rust_analyzer",
	},
}
