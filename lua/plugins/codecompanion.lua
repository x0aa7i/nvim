return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>a", group = "ai" },
      },
    },
  },
  {
    "saghen/blink.cmp",
    lazy = false,
    opts = {
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "codecompanion" },
        providers = {
          codecompanion = {
            name = "CodeCompanion",
            module = "codecompanion.providers.completion.blink",
            enabled = true,
          },
        },
        cmdline = {}, -- Disable sources for command-line mode
      },
    },
    opts_extend = {
      "sources.default",
    },
  },
  {
    "olimorris/codecompanion.nvim",
    enabled = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", mode = "n", desc = "Companion Toggle Chat" },
      { "<leader>as", "<cmd>CodeCompanionActions<cr>", mode = "n", desc = "Companion Actions" },
      { "<leader>am", "<cmd>CodeCompanionCmd<cr>", mode = "n", desc = "Companion Command" },
      { "<leader>ae", "<cmd>CodeCompanion<cr>", mode = { "n", "v" }, desc = "Companion Edit Code" },
    },
    opts = {
      adapters = {
        groq = function()
          return require("codecompanion.adapters").extend("openai", {
            name = "groq",
            schema = {
              model = {
                default = "llama-3.3-70b-versatile",
              },
              num_ctx = {
                default = 131072,
              },
            },
            url = "https://api.groq.com/openai/v1/chat/completions",
            env = {
              api_key = "GROQ_API_KEY",
            },
          })
        end,
      },
      strategies = {
        chat = {
          adapter = "groq",
          slash_commands = {
            ["file"] = {
              callback = "strategies.chat.slash_commands.file",
              description = "Select a file with Snacks",
              opts = {
                provider = "snacks",
              },
            },
            ["buffer"] = {
              opts = {
                provider = "snacks",
              },
            },
            ["help"] = {
              opts = {
                provider = "snacks",
              },
            },
            ["symbols"] = {
              opts = {
                provider = "snacks",
              },
            },
          },
        },
        inline = {
          adapter = "groq",
        },
        agent = {
          adapter = "groq",
        },
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local Spinner = require("lualine.component"):extend()
      local spinner_symbols = {
        "⠋",
        "⠙",
        "⠹",
        "⠸",
        "⠼",
        "⠴",
        "⠦",
        "⠧",
        "⠇",
        "⠏",
      }

      -- Initializer
      function Spinner:init(options)
        Spinner.super.init(self, options)
        self.spinner_index = 1

        local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})

        vim.api.nvim_create_autocmd({ "User" }, {
          pattern = "CodeCompanionRequest*",
          group = group,
          callback = function(request)
            if request.match == "CodeCompanionRequestStarted" then
              self.processing = true
            elseif request.match == "CodeCompanionRequestFinished" then
              self.processing = false
            end
          end,
        })
      end

      -- Function that runs every time statusline is updated
      function Spinner:update_status()
        if self.processing then
          self.spinner_index = (self.spinner_index % #spinner_symbols) + 1
          return "󰚩 " .. spinner_symbols[self.spinner_index]
        else
          return nil
        end
      end

      opts.sections = opts.sections or {}
      opts.sections.lualine_y = vim.list_extend(opts.sections.lualine_y or {}, {
        { Spinner },
      })

      return opts
    end,
  },
}
