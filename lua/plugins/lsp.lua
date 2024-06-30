return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- { "artemave/workspace-diagnostics.nvim", opts = {} },
    },
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      ----@type lspconfig.options.tailwindcss
      opts.servers.tailwindcss = {
        settings = {
          tailwindCSS = {
            experimental = {
              classRegex = {
                -- Custom class name attributes (e.g. buttonClassName)
                { [==[[a-zA-Z]*ClassName=["'`]([^"'`]+)["'`]]==] },
                -- cls, clsx
                -- https://github.com/tailwindlabs/tailwindcss-intellisense/issues/682#issuecomment-1364585313
                {
                  [[cn\(([^)(]*(?:\([^)(]*(?:\([^)(]*(?:\([^)(]*\)[^)(]*)*\)[^)(]*)*\)[^)(]*)*)\)]],
                  '"(.*?)"',
                },
                -- Tailwind Variants
                -- https://www.tailwind-variants.org/docs/getting-started#intellisense-setup-optional
                {
                  [[tv\(([^)(]*(?:\([^)(]*(?:\([^)(]*(?:\([^)(]*\)[^)(]*)*\)[^)(]*)*\)[^)(]*)*)\)]],
                  '"(.*?)"',
                },
                -- `styles` objects
                -- https://github.com/tailwindlabs/tailwindcss-intellisense/issues/682#issuecomment-1364585313
                { [[styles =([^}]*)\}]], [==[["'`]([^"'`]*).*?["'`]]==] },
              },
            },
          },
        },
      }

      -- Capabilities
      opts.capabilities = {
        workspace = {
          -- PERF: didChangeWatchedFiles is too slow.
          -- TODO: Remove this when https://github.com/neovim/neovim/issues/23291#issuecomment-1686709265 is fixed.
          didChangeWatchedFiles = { dynamicRegistration = false },
        },
      }

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
      -- LazyVim.lsp.on_attach(function(client, buffer)
      --   require("workspace-diagnostics").populate_workspace_diagnostics(client, buffer)
      -- end)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      -- add more treesitter parsers
      ensure_installed = {
        "bash",
        "html",
        "css",
        "svelte",
        "javascript",
        "typescript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "yaml",
        "toml",
        "sql",
      },
    },
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
