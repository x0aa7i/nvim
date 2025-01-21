local ts_filetypes = {
  "typescript",
  "typescriptreact",
  "javascript",
  "javascriptreact",
  "vue",
  "svelte",
}

---Retrieves an LSP client by name
---@param name string
---@return vim.lsp.Client | nil
local function getLSPClient(name)
  return vim.lsp.get_clients({ bufnr = 0, name = name })[1]
end

---Toggles an LSP client by name
---@param name string
---@return nil
local function toggleLSPClient(name)
  local client = getLSPClient(name)
  if client then
    client.stop(true)
  else
    vim.cmd("LspStart " .. name)
  end
end

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

      opts.servers.harper_ls = {
        autostart = false,
        settings = {
          ["harper-ls"] = {
            userDictPath = vim.fn.stdpath("config") .. "/spell/en.utf-8.add",
            -- fileDictPath = "~/.config/harper/dictionaries/files/",
            codeActions = { forceStable = true },
          },
        },
      }

      opts.setup = opts.setup or {}
      opts.setup.harper_ls = function()
        Snacks.toggle({
          name = "Grammar Checker",
          get = function()
            return getLSPClient("harper_ls") ~= nil
          end,
          set = function()
            toggleLSPClient("harper_ls")
          end,
        }):map("<leader>clg")
      end

      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "<leader>cli", "<cmd>LspInfo<cr>", desc = "Info" }

      require("which-key").add({
        { "<leader>cl", group = "LSP", icon = LazyVim.config.icons.diagnostics.Info },
      })
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
        "markdownlint-cli2", -- markdown linter
        "markdown-toc", -- markdown table of contents
        "marksman", -- markdown lsp
        "harper-ls", -- grammar check
        "stylelint-lsp", -- css linter
        "emmet-language-server", -- css/html completions
        "lua-language-server",
        "taplo", -- toml lsp
      },
    },
  },
}
