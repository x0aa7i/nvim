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
  model = "llama-3.1-70b-versatile",
  body = { max_tokens = nil, temperature = 0.8, top_p = 1, stop = nil },
  command = function()
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
  init = function()
    pcall(io.popen, "ollama serve > /dev/null 2>&1 &")
  end,
}

return {
  {
    "David-Kunz/gen.nvim",
    keys = {
      { "<leader>a", "", mode = { "n", "v" }, desc = "+ai" },
      { "<leader>aa", ":Gen Ask_Code<cr>", mode = "v", desc = "Ask About Code" },
      { "<leader>aA", ":Gen Ask<cr>", mode = "v", desc = "Ask About Text" },

      { "<leader>ag", ":Gen Generate_Input<cr>", mode = "n", desc = "Generate from input" },
      { "<leader>ag", ":Gen Generate_Selection<cr>", mode = "v", desc = "Generate from Selection" },

      { "<leader>ae", ":Gen Enhance_Grammar_Spelling<cr>", mode = "v", desc = "Enhance Grammar and Spelling" },
      { "<leader>ar", ":Gen Rewrite<cr>", mode = "v", desc = "Rewrite Text" },
      { "<leader>as", ":Gen Make_Concise<cr>", mode = "v", desc = "Make Text Concise" },
      { "<leader>az", ":Gen Summarize<cr>", mode = "v", desc = "Summarize Text" },

      { "<leader>ah", ":Gen Enhance_Code<cr>", mode = "v", desc = "Enhance Code" },
      { "<leader>ad", ":Gen JSDoc<cr>", mode = "v", desc = "Write JSDoc" },
      { "<leader>af", ":Gen Fix_Code<cr>", mode = "v", desc = "Fix Code" },
      { "<leader>an", ":Gen Change_Code<cr>", mode = "v", desc = "Change Code" },
      { "<leader>at", ":Gen Write_Tests<cr>", mode = "v", desc = "Write Tests" },
      { "<leader>ac", ":Gen Commit_Message<cr>", mode = "n", desc = "Commit Message" },
    },
    config = function()
      local gen = require("gen")

      gen.prompts = {
        Ask = { prompt = "Regarding the following text, $input:\n$text" },
        Ask_Code = { prompt = "Regarding the following code, $input:\n$text" },
        Generate_Input = { prompt = "$input\nProvide a concise response." },
        Generate_Selection = { prompt = "$text\nProvide a concise response." },
        Summarize = { prompt = "Provide a concise summary of the following text:\n$text" },
        Rewrite = {
          prompt = "Improve the grammar and readability of the following text. Output only the refined text without quotes:\n$text",
          replace = true,
        },
        Enhance_Grammar_Spelling = {
          prompt = "Correct and enhance the grammar and spelling in the following text. Output only the improved text without quotes:\n$text",
          replace = true,
        },
        Make_Concise = {
          prompt = "Condense the following text to its essential points, maintaining clarity. Output only the concise version without quotes:\n$text",
          replace = true,
        },
        Enhance_Code = {
          prompt = "Optimize and improve the following code. Consider performance, readability, and best practices. Output only the enhanced code in the format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
          replace = true,
          extract = "```$filetype\n(.-)```",
        },
        Change_Code = {
          prompt = "Modify the following code according to this instruction: $input. Output only the result in the format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
          replace = true,
          extract = "```$filetype\n(.-)```",
        },
        Fix_Code = {
          prompt = "Identify and fix any issues in the following code. Output only the corrected code in the format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
          replace = true,
          extract = "```$filetype\n(.-)```",
        },
        Review_Code = {
          prompt = "Conduct a code review for the following snippet, focusing on best practices, potential improvements, and any issues:\n```$filetype\n$text\n```",
        },
        Write_Tests = {
          prompt = "Generate unit tests for the following code. Do not include mocks. Output only the tests in the format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
        },
        JSDoc = {
          prompt = "Generate comprehensive JSDoc comments for the following code:\n```$filetype\n$text\n```",
        },
        Commit_Message = {
          prompt = function(content, filetype)
            local git_diff = vim.fn.system({ "git", "diff", "--staged" })

            if not git_diff:match("^diff") then
              error("Git error:\n" .. git_diff)
            end

            return "Compose a concise commit message following the Conventional Commits specification. Aim for under 80 characters. Respond ONLY with the commit message. Staged git diff:\n```"
              .. git_diff
              .. "\n```"
          end,
          replace = false,
        },
      }

      if use_local then
        gen.setup(vim.tbl_deep_extend("force", ollama_configs, base_configs))
      else
        gen.setup(vim.tbl_deep_extend("force", groq_configs, base_configs))
      end
    end,
  },
}
