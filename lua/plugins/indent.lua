return {
	{
		-- indent guides for Neovim
		-- Add indentation guides even on blank lines
		"lukas-reineke/indent-blankline.nvim",
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help indent_blankline.txt`
		event = { "BufReadPost", "BufNewFile" },
		-- version = "2.20.8",
		config = function()
			require("ibl").setup({
				indent = { char = "┊" },
				scope = { enabled = false },
			})
		end,
	},
	{
		"nmac427/guess-indent.nvim",
		event = "InsertEnter",
		config = function()
			require("guess-indent").setup({})
		end,
	},
	-- Active indent guide and indent text objects. When you're browsing
	-- code, this highlights the current level of indentation, and animates
	-- the highlighting.
	{
		"echasnovski/mini.indentscope",
		version = false, -- wait till new 0.7.0 release to put it back on semver
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local indentscope = require("mini.indentscope")
			indentscope.setup({
				symbol = "│",
				options = { try_as_border = true },
				draw = {
					delay = 20,
					animation = indentscope.gen_animation.quadratic({
						easing = "out",
						duration = 10,
						unit = "step",
					}),
				},
			})
		end,
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},
}
