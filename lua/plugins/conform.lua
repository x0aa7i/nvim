return {
  "stevearc/conform.nvim",
  opts = {
    formatters = {
      ["markdown-toc"] = {
        condition = function(_, ctx)
          for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
            if line:find("<!%-%- toc %-%->") then
              return true
            end
          end
        end,
      },
      ["markdownlint-cli2"] = {
        condition = function(_, ctx)
          local diag = vim.tbl_filter(function(d)
            return d.source == "markdownlint"
          end, vim.diagnostic.get(ctx.buf))
          return #diag > 0
        end,
      },
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

      ["markdown"] = { "dprint", "markdownlint-cli2", "markdown-toc" },
      ["markdown.mdx"] = { "prettierd", "markdownlint-cli2", "markdown-toc" },

      ["yaml"] = { "prettierd" },
    },
  },
}
