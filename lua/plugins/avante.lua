return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  build = LazyVim.is_win() and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" or "make",
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
  },
  init = function()
    require("avante_lib").load()
  end,
  opts = {
    windows = { width = 45 },
    provider = "groq",
    vendors = {
      groq = {
        endpoint = "https://api.groq.com/openai/v1/chat/completions",
        model = "llama-3.1-70b-versatile",
        api_key_name = "GROQ_API_KEY",
        --- this function below will be used to parse in cURL arguments.
        parse_curl_args = function(opts, code_opts)
          return {
            url = opts.endpoint,
            headers = {
              ["Accept"] = "application/json",
              ["Content-Type"] = "application/json",
              ["Authorization"] = "Bearer " .. os.getenv(opts.api_key_name),
            },
            body = {
              model = opts.model,
              messages = require("avante.providers").openai.parse_message(code_opts), -- you can make your own message, but this is very advanced
              temperature = 0,
              max_tokens = 4096,
              stream = true, -- this will be set by default.
            },
          }
        end,
        -- The below function is used if the vendors has specific SSE spec that is not claude or openai.
        parse_response_data = function(data_stream, event_state, opts)
          require("avante.providers").openai.parse_response(data_stream, event_state, opts)
        end,
      },
    },
  },
}
