return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      svelte = { "eslint_d" },
      css = { "stylelint" },
      -- Use the "*" filetype to run linters on all filetypes.
      -- ['*'] = { 'global linter' },
      -- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
      -- ['_'] = { 'fallback linter' },
      -- ["*"] = { "typos" },
    },
  },
}
