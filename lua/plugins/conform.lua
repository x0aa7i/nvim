return {
  "stevearc/conform.nvim",
  opts = {
    formatters = {
      dprint = {
        prepend_args = function(self, ctx)
          local has_dprint = self.cwd(self, ctx)
          if not has_dprint then
            return { "-c", vim.fn.stdpath("config") .. "/rules/dprint.json" }
          end
          return {}
        end,
      },
      prettierd = {
        require_cwd = false,
        env = {
          PRETTIERD_DEFAULT_CONFIG = vim.fn.stdpath("config") .. "/rules/.prettierrc.json",
        },
      },
    },
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

      ["yaml"] = { "prettierd" },
    },
  },
}
