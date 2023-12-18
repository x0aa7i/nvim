return {
  -- UI for nvim-lsp progress
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		event = "LspAttach",
		opts = {
			-- options
		},
	},
	-- show your current code context in winbar
  -- {
  --   "SmiteshP/nvim-navic",
  --   event = { "BufReadPre", "BufAdd", "BufNew" },
  -- }
}
