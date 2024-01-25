return {
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			ignore = "^$",
			---LHS of toggle mappings in NORMAL mode
			toggler = {
				---Line-comment toggle keymap
				line = "<leader>c",
				---Block-comment toggle keymap
				block = "<leader>C",
			},
			---LHS of operator-pending mappings in NORMAL and VISUAL mode
			opleader = {
				---Line-comment keymap
				line = "<leader>c",
				---Block-comment keymap
				block = "<leader>C",
			},
		},
	},
}
