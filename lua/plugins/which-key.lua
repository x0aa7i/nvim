return {
	"folke/which-key.nvim",
	-- lazy = true,
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 1000
	end,
	-- keys = { "<leader>" },
	opts = {
		plugins = { spelling = true },
		window = {
			border = "shadow",
			position = "bottom",
			margin = { 0, 0, 0, 0 },
			padding = { 2, 2, 2, 2 },
		},
		-- 	prefix = "<leader>",
		defaults = {
			mode = { "n", "v" },
			["g"] = { name = "+goto" },
			["gs"] = { name = "+surround" },
			["]"] = { name = "+next" },
			["["] = { name = "+prev" },
			["<leader><tab>"] = { name = "+tabs" },
			["<leader>b"] = { name = "+buffer" },
			["<leader>f"] = { name = "+file/find" },
			["<leader>g"] = { name = "+git" },
			["<leader>gh"] = { name = "+hunks" },
			["<leader>q"] = { name = "+quit/session" },
			["<leader>s"] = { name = "+search" },
			["<leader>u"] = { name = "+ui" },
			["<leader>w"] = { name = "+windows" },
			["<leader>x"] = { name = "+diagnostics/quickfix" },
		},
	},
	config = function(_, opts)
		local which_key = require("which-key")
		which_key.setup(opts)
		which_key.register(opts.defaults)
	end,
}
