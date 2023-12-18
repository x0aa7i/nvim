-- local M = {
--   "jose-elias-alvarez/null-ls.nvim",
--   event = "BufReadPre",
--   dependencies = {
--     "nvim-lua/plenary.nvim",
--   },
-- }

-- function M.config()
--   local null_ls = require "null-ls"
--   -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
--   local formatting = null_ls.builtins.formatting
--   -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
--   local diagnostics = null_ls.builtins.diagnostics

--   -- https://github.com/prettier-solidity/prettier-plugin-solidity
--   null_ls.setup {
--     debug = false,
--     sources = {
--       formatting.prettierd.with {
--         extra_filetypes = { "svelte", "toml" },
--         extra_args = { "--no-semi" },
--       },
--       formatting.black.with { extra_args = { "--fast" } },
--       formatting.stylua,
--       diagnostics.flake8,
--     },
--   }
-- end

local M = {
	"stevearc/conform.nvim",
	opts = {},
}

M.config = function()
	local conform = require("conform")
	local prettier = "prettierd"

	conform.setup({
		format_on_save = {
			timeout_ms = 3000,
			lsp_fallback = true,
		},
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
	})

	vim.keymap.set({ "n", "v", "x", "i" }, "<F3>", function()
		conform.format({
			lsp_fallback = true,
			-- timeout_ms = 1000,
		})
	end, { desc = "Format file or range (in visual mode)" })
end

return M
