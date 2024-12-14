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
      -- { "artemave/workspace-diagnostics.nvim", opts = {} },
      -- {
      --   "dmmulroy/ts-error-translator.nvim",
      --   config = true,
      --   ft = ts_filetypes,
      -- },
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
      -- opts.servers = opts.servers or {}

      -- Inlay hints
      opts.inlay_hints = opts.inlay_hints or {}
      opts.inlay_hints.enabled = false

      -- Diagnostics
      -- opts.diagnostics = opts.diagnostics or {}
      -- opts.diagnostics.virtual_text = opts.diagnostics.virtual_text or {}
      -- opts.diagnostics.virtual_text.prefix = "icons"

      -- Code lens
      -- opts.codelens = opts.codelens or {}
      -- opts.codelens.enabled = false

      -- Workspace diagnostics
      -- LazyVim.lsp.on_attach(function(client, buffer)
      --   require("workspace-diagnostics").populate_workspace_diagnostics(client, buffer)
      -- end)
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
