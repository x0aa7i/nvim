local eslint = require("lint").get_namespace("eslint_d")
vim.diagnostic.config({
  underline = true,
  virtual_text = false,
  signs = true,
  severity_sort = true,
}, eslint)

return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      svelte = { "eslint_d" },
      markdown = { "markdownlint" },
    },
    linters = {
      markdownlint = {
        args = { "--disable", "MD013", "--" },
      },
    },
  },
}
