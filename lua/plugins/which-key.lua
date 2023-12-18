return {
	"folke/which-key.nvim",
	-- lazy = true,
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 1000
	end,
	keys = { "<leader>" },
	config = function()
		local which_key = require("which-key")

		which_key.setup({
			plugins = {
				spelling = {
					enabled = true,
					suggestions = 20,
				},
			},
			window = {
				border = "shadow",
				position = "bottom",
				margin = { 0, 0, 0, 0 },
				padding = { 2, 2, 2, 2 },
			},
		})

		local opts = {
			prefix = "<leader>",
		}

		local groups = {
			-- ["g"] = { name = "+goto" },
			["]"] = { name = "+next" },
			["["] = { name = "+prev" },
			["f"] = { name = "+file/find" },
			b = { name = "+buffer" },
			x = { name = "+diagnostics/quickfix" },
			t = { name = "+tabs" },
			d = { name = "+todo" },
			q = { name = "+session" },
			s = { name = "+surround" },
			g = { name = "+git" },
			-- ["g"] = { name = "+git" },
			["gh"] = { name = "+hunks" },
			["n"] = { name = "+swap next" },
			["p"] = { name = "+swap prev" },
			-- ["<leader><tab>"] = { name = "+tabs" },
			-- ["<leader>b"] = { name = "+buffer" },
			-- ["<leader>q"] = { name = "+quit/session" },
			-- ["<leader>s"] = { name = "+search" },
			-- ["<leader>w"] = { name = "+windows" },
			-- ["<leader>x"] = { name = "+diagnostics/quickfix" },
			-- r = { name = "refactor" },
			-- l = { name = "lsp" },
			-- d = { name = "debug" },
			-- m = { name = "macro/markdown" },
			-- n = { name = "notifications" },
			-- ["<tab>"] = { name = "tabs" },
			-- [";"] = { name = "test" },
			-- ["'"] = { name = "marks" },
			-- ["/"] = { name = "search" },
			-- ["/g"] = { name = "git" },
			-- ["/gd"] = { name = "diff" },
			-- ["["] = { name = "previous" },
			-- ["]"] = { name = "next" },
		}

		which_key.register(groups, opts)
	end,
}
