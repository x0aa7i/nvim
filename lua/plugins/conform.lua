return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      ["css"] = { "prettierd" },
      ["html"] = { "prettierd" },

      ["svelte"] = { "prettierd" },
      ["javascript"] = { "prettierd" },
      ["javascriptreact"] = { "prettierd" },
      ["typescript"] = { "prettierd" },
      ["typescriptreact"] = { "prettierd" },

      ["less"] = { "prettierd" },
      ["scss"] = { "prettierd" },

      ["json"] = { "prettierd" },
      ["jsonc"] = { "prettierd" },

      ["markdown"] = { "prettierd", "markdownlint" },
      ["markdown.mdx"] = { "prettierd", "markdownlint" },

      ["yaml"] = { "prettierd" },
    },
  },
}
