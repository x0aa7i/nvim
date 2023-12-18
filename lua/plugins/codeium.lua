return {
	{
		"Exafunction/codeium.vim",
		-- event = "InsertEnter",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			-- change suggestion color
			vim.cmd([[highlight CodeiumSuggestion guifg=#787c99 ctermfg=8]])
			-- Change '<C-g>' here to any keycode you like.
			vim.keymap.set("i", "<c-g>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true, silent = true })
			vim.keymap.set("i", "<Tab>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true, silent = true })
			vim.keymap.set("i", "<c-;>", function()
				return vim.fn["codeium#CycleCompletions"](1)
			end, { expr = true, silent = true })
			vim.keymap.set("i", "<c-,>", function()
				return vim.fn["codeium#CycleCompletions"](-1)
			end, { expr = true, silent = true })
			vim.keymap.set("i", "<c-x>", function()
				return vim.fn["codeium#Clear"]()
			end, { expr = true, silent = true })
		end,
	},
}
