return {
	{
		"akinsho/bufferline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		keys = {
			{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
			{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
			{ "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete other buffers" },
			{ "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete buffers to the right" },
			{ "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete buffers to the left" },
			{ "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
			{ "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
		},
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			options = {
				--     -- stylua: ignore
				always_show_bufferline = false,
				--     close_command = function(n) require("mini.bufremove").delete(n, false) end,
				--     -- stylua: ignore
				--     right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
				--     diagnostics = "nvim_lsp",
				--     diagnostics_indicator = function(_, _, diag)
				--       local icons = require("lazyvim.config").icons.diagnostics
				--       local ret = (diag.error and icons.Error .. diag.error .. " " or "")
				--           .. (diag.warning and icons.Warn .. diag.warning or "")
				--       return vim.trim(ret)
				--     end,
				offsets = {
					{
						filetype = "neo-tree",
						text = "Neo-tree",
						highlight = "Directory",
						text_align = "left",
					},
				},
			},
		},
	},
}
