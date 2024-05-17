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
      { "<leader>aa", ":Gen<cr>", mode = { "n", "v" }, desc = "Gen" },
      { "<leader>ac", ":Gen Chat<cr>", mode = { "n", "v" }, desc = "Chat" },
      { "<leader>ae", ":Gen Enhance_Grammar_Spelling<cr>", mode = "v", desc = "Enhance Grammar and Spelling" },
    },
    config = function()
      if use_local then
        require("gen").setup(vim.tbl_deep_extend("force", ollama_configs, base_configs))
      else
        require("gen").setup(vim.tbl_deep_extend("force", groq_configs, base_configs))
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
