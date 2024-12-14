return {
  "yetone/avante.nvim",
  build = LazyVim.is_win() and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" or "make",
  event = "VeryLazy",
  dependencies = {
    {
      "MeanderingProgrammer/render-markdown.nvim",
      optional = true,
      opts = function(_, opts)
        opts.file_types = vim.list_extend(opts.file_types or {}, { "Avante" })
      end,
      ft = function(_, ft)
        vim.list_extend(ft, { "Avante" })
      end,
    },
    {
      "folke/which-key.nvim",
      optional = true,
      opts = {
        spec = {
          { "<leader>a", group = "+ai" },
        },
      },
    },
  },
  opts = {
    windows = { width = 45 },
    provider = "groq",
    vendors = {
      groq = {
        __inherited_from = "openai",
        api_key_name = "GROQ_API_KEY",
        endpoint = "https://api.groq.com/openai/v1/",
        model = "llama-3.3-70b-versatile",
      },
    },
  },
}
