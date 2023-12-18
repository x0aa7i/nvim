local M = {
	"smjonas/inc-rename.nvim",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("inc_rename").setup()
		-- keymap
		vim.keymap.set("n", "<leader>r", function()
			return ":IncRename " .. vim.fn.expand("<cword>")
		end, { expr = true, desc = "Rename" })
	end,
}

return M
