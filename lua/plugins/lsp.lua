return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- diagnostics = {
      --   signs = false,
      -- },
      flags = {
        debounce_text_changes = 200,
        allow_incremental_sync = true,
      },
      servers = {
        ----@type lspconfig.options.svelte
        svelte = {
          capabilities = {
            workspace = {
              didChangeWatchedFiles = {
                dynamicRegistration = true,
              },
            },
          },
        },
        ----@type lspconfig.options.tailwindcss
        tailwindcss = {
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
        },
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
    },
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
        "marksman", -- markdown lsp
        "stylelint-lsp",
        "taplo", -- toml lsp
        "typescript-language-server",
        "typos-lsp", -- spellchecker for code
      },
    },
  },
}
