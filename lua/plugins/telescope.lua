return {
  "nvim-telescope/telescope.nvim",
  keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
  },
  -- add telescope-fzf-native
  dependencies = {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
  -- change some options
  opts = {
    defaults = {
      layout_strategy = "flex", -- Flex layout swaps between `horizontal` and `vertical` strategies based on the window width
      layout_config = {
        prompt_position = "bottom",
        vertical = {
          preview_height = 0.5,
        },
      },
      sorting_strategy = "ascending",
      cycle_layout_list = { "horizontal", "vertical" },
      prompt_prefix = "   ",
      selection_caret = " ",
      winblend = 0,
      file_ignore_patterns = { "^.git/", "^node_modules*", "^package-lock.json*", "^pnpm-lock.yaml" },
      mappings = {
        i = { -- Insert Mode mapping
          ["<C-Right>"] = require("telescope.actions.layout").cycle_layout_next, -- Cycle history next: CTRL + Right
          ["<C-Left>"] = require("telescope.actions.layout").cycle_layout_prev, -- Cycle history previous: CTRL + Left
          ["<C-j>"] = require("telescope.actions").move_selection_next, -- scroll the list with <c-j>
          ["<C-k>"] = require("telescope.actions").move_selection_previous, -- scroll the list with <c-k>
          ["<C-u>"] = require("telescope.actions").preview_scrolling_up,
          ["<C-d>"] = require("telescope.actions").preview_scrolling_down,
        },
      },
    },
  },
}
