local ts_filetypes = {
  "typescript",
  "typescriptreact",
  "javascript",
  "javascriptreact",
  "vue",
  "svelte",
}

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "dmmulroy/tsc.nvim",
        opts = {
          auto_start_watch_mode = false,
          use_trouble_qflist = true,
          flags = {
            watch = false,
          },
        },
        keys = {
          { "<leader>ct", ft = ts_filetypes, "<cmd>TSC<cr>", desc = "Type Check" },
          { "<leader>xy", ft = ts_filetypes, "<cmd>TSCOpen<cr>", desc = "Type Check Quickfix" },
        },
        ft = ts_filetypes,
        cmd = {
          "TSC",
          "TSCOpen",
          "TSCClose",
          "TSStop",
        },
      },
    },
    opts = function(_, opts)
      -- Inlay hints
      opts.inlay_hints = opts.inlay_hints or {}
      opts.inlay_hints.enabled = false

      -- Servers configs
      opts.servers = opts.servers or {}
      opts.servers.cssls = {
        settings = {
          css = {
            lint = { unknownAtRules = "ignore" },
          },
        },
      }
      opts.servers.tailwindcss = {
        filetypes_exclude = { "markdown" },
        filetypes_include = {},
        settings = {
          tailwindCSS = {
            experimental = {
              classRegex = {
                { "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                { "cn\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                { "tv\\((([^()]*|\\([^()]*\\))*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
              },
            },
          },
        },
      }
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
      },
      ensure_installed = {
        "stylua",
        "eslint_d",
        "prettierd",
        "svelte-language-server",
        "tailwindcss-language-server",
        "css-lsp",
        "json-lsp",
        "stylelint-lsp", -- css linter
        "emmet-language-server", -- css/html completions
        "lua-language-server",
        "taplo", -- toml lsp
      },
    },
  },
}
