-- https://github.com/TimUntersberger/neogit

require("neogit").setup {
	disable_signs = false,
	disable_context_highlighting = false,
	-- customize displayed signs
	signs = {
		-- { CLOSED, OPENED }
		section = {">", "v"},
		item = {">", "v"},
		hunk = {"", ""}
	},
	-- override/add mappings
	mappings = {
		-- modify status buffer mappings
		status = {}
	}
}
