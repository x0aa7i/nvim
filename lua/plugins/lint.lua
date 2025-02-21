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
      markdown = { "markdownlint-cli2" },
    },
    linters = {
      ["markdownlint-cli2"] = {
        args = { "--config", vim.fn.stdpath("config") .. "/rules/.markdownlint.json" },
      },
      eslint_d = {
        condition = function(ctx)
          return vim.fs.find({ "eslint.config.js" }, { path = ctx.filename, upward = true })[1]
        end,
      },
    },
  },
}
