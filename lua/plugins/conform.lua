local M = {
	"stevearc/conform.nvim",
	event = "LspAttach",
	opts = {},
}

M.config = function()
	local conform = require("conform")
	local prettier = "prettierd"

	conform.setup({
		quiet = true,
		formatters_by_ft = {
			javascript = { prettier },
			typescript = { prettier },
			javascriptreact = { prettier },
			typescriptreact = { prettier },
			svelte = { prettier },
			css = { prettier },
			html = { prettier },
			json = { prettier },
			jsonc = { prettier },
			yaml = { prettier },
			markdown = { prettier },
			graphql = { prettier },
			lua = { "stylua" },

			python = { "isort", "black" },
		},

		-- format_on_save = {
		-- 	timeout_ms = 3000,
		-- 	lsp_fallback = true,
		-- },
		format_on_save = function(bufnr)
			-- Disable autoformat for files in a certain path
			local bufname = vim.api.nvim_buf_get_name(bufnr)
			if bufname:match("/node_modules/") then
				return
			end

			return { timeout_ms = 500, lsp_fallback = true, async = true }
		end,
		format_after_save = {
			lsp_fallback = true,
		},
	})

	vim.keymap.set({ "n", "v", "x", "i" }, "<F3>", function()
		conform.format({
			lsp_fallback = true,
			-- timeout_ms = 1000,
		})
	end, { desc = "Format file or range (in visual mode)" })
end

return M
