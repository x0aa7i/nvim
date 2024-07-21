return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "artemave/workspace-diagnostics.nvim", opts = {} },
    },
    opts = function(_, opts)
      opts.servers = opts.servers or {}

      -- Inlay hints
      opts.inlay_hints = opts.inlay_hints or {}
      opts.inlay_hints.enabled = false

      -- Diagnostics
      opts.diagnostics = opts.diagnostics or {}
      opts.diagnostics.virtual_text = opts.diagnostics.virtual_text or {}
      opts.diagnostics.virtual_text.prefix = "icons"

      -- Code lens
      opts.codelens = opts.codelens or {}
      opts.codelens.enabled = false

      -- Semantic tokens
      LazyVim.lsp.on_attach(function(client, buffer)
        if
          vim.lsp.semantic_tokens
          and client.supports_method("textDocument/semanticTokens/full")
          and vim.b[buffer].semantic_tokens == nil
        then
          vim.b[buffer].semantic_tokens = true
        end
      end)

      -- Workspace diagnostics
      LazyVim.lsp.on_attach(function(client, buffer)
        require("workspace-diagnostics").populate_workspace_diagnostics(client, buffer)
      end)
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
