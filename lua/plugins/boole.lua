return {
	"nat-418/boole.nvim",
	event = { "BufReadPost", "BufNewFile" },
	config = {
		mappings = {
			increment = "<leader>bi",
			decrement = "<leader>bd",
		},
		-- User defined loops
		additions = {
			-- { "Foo", "Bar" },
			-- { "tic", "tac", "toe" },
		},
		allow_caps_additions = {
			{ "enable", "disable" },
			-- enable → disable
			-- Enable → Disable
			-- ENABLE → DISABLE
		},
	},
}
