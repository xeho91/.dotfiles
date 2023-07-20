local M = {}

local bun_servers = {
	"eslint",
	"eslint_d",
	"markdownlint",
	"prettierd",
	"svelteserver",
	"tailwindcss",
	"tsserver",
	"unocss-language-server",
	"vscode-css-language-server",
	"vscode-html-language-server",
	"vscode-json-language-server",
	"vue-language-server",
}

local function is_bun_server(name)
	for _, server in ipairs(bun_servers) do
		if server == name then
			return true
		end
	end
	return false
end

local function is_bun_available()
	local bun = vim.fn.executable "bun"
	if bun == 0 then
		return false
	end
	return true
end

M.add_bun_prefix = function(config, _)
	if config.cmd and is_bun_available() and is_bun_server(config.name) then
		config.cmd = vim.list_extend({
			"bun",
			"run",
			--[[ "--bun", ]]
		}, config.cmd)
	end
end

return M
