local use_local = false

local get_api_key = function(path)
  local expanded_path = vim.fn.expand(path)
  local file = io.open(expanded_path, "r")
  if file then
    local content = file:read("*all"):gsub("\n", "")
    file:close()
    return content
  else
    error("Could not open file!")
  end
end

local base_configs = {
  quit_map = "q", -- set keymap for close the response window
  retry_map = "<c-r>", -- set keymap to re-send the current prompt
  -- list_models = '<omitted lua function>', -- Retrieves a list of model names
  display_mode = "float", -- The display mode. Can be "float" or "split".
  show_prompt = false, -- Shows the prompt submitted to Ollama.
  show_model = false, -- Displays which model you are using at the beginning of your chat session.
  no_auto_close = false, -- Never closes the window automatically.
  debug = false, -- Prints errors and the command which is run.
}

local groq_configs = {
  model = "llama3-70b-8192",
  -- model = "mixtral-8x7b-32768",
  body = { max_tokens = nil, temperature = 1, top_p = 1, stop = nil },
  command = function(options)
    local api_url = "https://api.groq.com"
    local api_endpoint = api_url .. "/openai/v1/chat/completions"
    local api_key_path = "~/.groq/creds"
    local api_key = get_api_key(api_key_path)
    local curl_cmd = "curl --silent --no-buffer -X POST"
    local header_options = "-H 'Authorization: Bearer " .. api_key .. "'"
    return curl_cmd .. " " .. header_options .. " " .. api_endpoint .. " -d $body"
  end,
  init = nil,
}

local ollama_configs = {
  model = "llama3",
  host = "localhost", -- The host running the Ollama service.
  port = "11434", -- The port on which the Ollama service is listening.
  command = function(options)
    return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/chat -d $body"
  end,
  -- Function to initialize Ollama
  -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
  -- This can also be a command string.
  -- The executed command must return a JSON object with { response, context }
  -- (context property is optional).
  init = function(options)
    pcall(io.popen, "ollama serve > /dev/null 2>&1 &")
  end,
}

return {
  {
    "David-Kunz/gen.nvim",
    keys = {
      { "<leader>aa", ":Gen<cr>", mode = "n", desc = "Gen" },
      { "<leader>aa", ":Gen Generate_Selection<cr>", mode = "v", desc = "Generate" },
      { "<leader>am", ":Gen Summarize<cr>", mode = "v", desc = "Summarize" },
      { "<leader>ar", ":Gen Rewrite<cr>", mode = "v", desc = "Rewrite" },
      { "<leader>ac", ":Gen Comment<cr>", mode = "v", desc = "Comment" },
      { "<leader>ae", ":Gen Enhance_Grammar_Spelling<cr>", mode = "v", desc = "Enhance Grammar and Spelling" },
      { "<leader>as", ":Gen Make_Concise<cr>", mode = "v", desc = "Make Concise" },
      { "<leader>ag", ":Gen Generate<cr>", mode = "v", desc = "Generate" },
      { "<leader>af", ":Gen Fix_Code<cr>", mode = "v", desc = "Fix Code" },
      { "<leader>aw", ":Gen Enhance_Wording<cr>", mode = "v", desc = "Enhance Wording" },
    },
    config = function()
      local gen = require("gen")

      gen.prompts = {
        Generate = { prompt = "$input, keep the output short.", replace = true },
        Generate_Selection = { prompt = "$text, keep the output short.", replace = true },
        Summarize = { prompt = "Summarize the following text:\n$text" },
        Ask = { prompt = "Regarding the following text, $input:\n$text" },
        Rewrite = {
          prompt = "Rewrite the following text to improve grammar and readability, just output the final text only without additional quotes around it:\n$text",
          replace = true,
        },
        Comment = {
          prompt = "Explain the following code snippet and write it as a comment, just output the final text without additional quotes around it:\n$text",
        },
        Enhance_Grammar_Spelling = {
          prompt = "Modify the following text to improve grammar and spelling, just output the final text only and without additional quotes around it:\n$text",
          replace = true,
        },
        Enhance_Wording = {
          prompt = "Modify the following text to use better wording, just output the final text without additional quotes around it:\n$text",
          replace = true,
        },
        Make_Concise = {
          prompt = "Modify the following text to make it as simple and concise as possible, just output the final text without additional quotes around it:\n$text",
          replace = true,
        },
        Review_Code = {
          prompt = "Review the following code and make concise suggestions:\n```$filetype\n$text\n```",
        },
        Enhance_Code = {
          prompt = "Enhance the following code, only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
          replace = true,
          extract = "```$filetype\n(.-)```",
        },
        Change_Code = {
          prompt = "Regarding the following code, $input, only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
          replace = true,
          extract = "```$filetype\n(.-)```",
        },
        Fix_Code = {
          prompt = "Fix the following code. Only ouput the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
          replace = true,
          extract = "```$filetype\n(.-)```",
        },
      }

      if use_local then
        gen.setup(vim.tbl_deep_extend("force", ollama_configs, base_configs))
      else
        gen.setup(vim.tbl_deep_extend("force", groq_configs, base_configs))
      end
    end,
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      defaults = {
        ["<leader>a"] = { name = "ai" },
      },
    },
  },
}
