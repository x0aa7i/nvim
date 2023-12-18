return {
	{
		"akinsho/toggleterm.nvim",
		lazy = true,
		event = "UIEnter",
		-- cmd = "ToggleTerm",
		keys = {
			{ "<C-\\>", "<cmd>ToggleTerm<cr>", desc = "ToggleTerm" },
		},
		config = function()
			require("toggleterm").setup({
				direction = "float",
				size = 20,
				shell = "fish",
				open_mapping = [[<C-\>]],
				start_in_insert = true,
				close_on_exit = false,
				shade_terminals = true,
				shading_factor = 2,
				float_opts = {
					border = "curved",
					winblend = 0,
				},
				highlights = {
					FloatBorder = {
						guifg = "#9381ff",
					},
				},
			})

			local Terminal = require("toggleterm.terminal").Terminal
			local lazygit = Terminal:new({
				cmd = "lazygit",
				hidden = true,
				close_on_exit = true,
				on_open = function(term)
					vim.cmd("startinsert!")
					vim.api.nvim_buf_set_keymap(
						term.bufnr,
						"n",
						"q",
						"<cmd>close<CR>",
						{ noremap = true, silent = true }
					)
				end,
				on_close = function(term)
					vim.cmd("startinsert!")
				end,
			})

			function _lazygit_toggle()
				lazygit:toggle()
			end

			vim.api.nvim_set_keymap("n", "<C-l>", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })
		end,
	},
}
