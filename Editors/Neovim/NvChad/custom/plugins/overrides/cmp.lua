-- local cmp = require "cmp"

-- vim.opt.completeopt = "menuone,noselect"
--
-- require("cmp-npm").setup {
-- 	ignore = {},
-- 	only_semantic_versions = true,
-- }
--
-- print "CMP LOADING"
-- return {
-- 	snippet = {
-- 		expand = function(args)
-- 			require("luasnip").lsp_expand(args.body)
-- 		end,
-- 	},
--
-- 	formatting = {
-- 		format = function(entry, vim_item)
-- 			local icons = require "plugins.configs.lspkind_icons"
-- 			vim_item.kind =
-- 				string.format("%s %s", icons[vim_item.kind], vim_item.kind)
--
-- 			vim_item.menu = ({
-- 				-- copilot = "[Copilot]",
-- 				treesitter = "[TS]",
-- 				emoji = "[Emoji]",
-- 				nvim_lsp = "[LSP]",
-- 				nvim_lua = "[Lua]",
-- 				buffer = "[BUF]",
-- 				npm = "[NPM]",
-- 				snippet = "[Snippet]",
-- 				neorg = "[Neorg]",
-- 			})[entry.source.name]
--
-- 			return vim_item
-- 		end,
-- 	},
--
-- 	mapping = {
-- 		["<C-p>"] = cmp.mapping.select_prev_item(),
-- 		["<C-n>"] = cmp.mapping.select_next_item(),
-- 		["<C-d>"] = cmp.mapping.scroll_docs(-4),
-- 		["<C-f>"] = cmp.mapping.scroll_docs(4),
-- 		["<C-Space>"] = cmp.mapping.complete(),
-- 		["<C-e>"] = cmp.mapping.close(),
-- 		["<CR>"] = cmp.mapping.confirm {
-- 			behavior = cmp.ConfirmBehavior.Replace,
-- 			select = true,
-- 		},
-- 		-- ["<Tab>"] = vim.schedule_wrap(function(fallback)
-- 		-- 	if cmp.visible() and has_words_before() then
-- 		-- 		cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
-- 		-- 	else
-- 		-- 		fallback()
-- 		-- 	end
-- 		-- end),
-- 		["<Tab>"] = function(fallback)
-- 			if cmp.visible() then
-- 				cmp.select_next_item()
-- 			elseif require("luasnip").expand_or_jumpable() then
-- 				vim.fn.feedkeys(
-- 					vim.api.nvim_replace_termcodes(
-- 						"<Plug>luasnip-expand-or-jump",
-- 						true,
-- 						true,
-- 						true
-- 					),
-- 					""
-- 				)
-- 			else
-- 				fallback()
-- 			end
-- 		end,
-- 		["<S-Tab>"] = function(fallback)
-- 			if cmp.visible() then
-- 				cmp.select_prev_item()
-- 			elseif require("luasnip").jumpable(-1) then
-- 				vim.fn.feedkeys(
-- 					vim.api.nvim_replace_termcodes(
-- 						"<Plug>luasnip-jump-prev",
-- 						true,
-- 						true,
-- 						true
-- 					),
-- 					""
-- 				)
-- 			else
-- 				fallback()
-- 			end
-- 		end,
-- 	},
return {
	sources = {
		{ name = "copilot", group_index = 2, keyword_length = 2 },
		{ name = "treesitter" },
		{ name = "emoji" },
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "nvim_lua" },
		{ name = "path" },
		{ name = "calc" },
		{ name = "npm", keyword_length = 3 },
		-- { name = "neorg" },
	},
}
--
-- -- Get the current Neorg state
-- -- local neorg = require "neorg"
-- --- Loads the Neorg completion module
-- -- local function load_completion()
-- -- 	neorg.modules.load_module("core.norg.completion", nil, {
-- -- 		engine = "nvim-cmp", -- Choose your completion engine here
-- -- 	})
-- -- end
-- --
-- -- -- If Neorg is loaded already then don't hesitate and load the completion
-- -- if neorg.is_loaded() then
-- -- 	load_completion()
-- -- else -- Otherwise wait until Neorg gets started and load the completion module then
-- -- 	neorg.callbacks.on_event("core.started", load_completion)
-- -- end
