return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader><space>",
        function()
          require("telescope").extensions.smart_open.smart_open({ match_algorithm = "fzf" })
        end,
        desc = "Find Frequent Files (Root Dir)",
      },
    },
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
        file_ignore_patterns = {
          ".git/",
          ".vscode/",
          ".obsidian/",
          "node_modules/",
          "build/",
          "package-lock.json",
          "pnpm-lock.yaml",
          "%.sqlite3",
          "%.jpg",
          "%.jpeg",
          "%.png",
          "%.svg",
          "%.otf",
          "%.ttf",
          "%.webp",
          "%.gif",
          "%.mp4",
          "%.webm",
          "%.mkv",
          "%.webm",
          "%.exe",
          "%.zip",
          "%.7z",
          "%.rar",
          "%.tar",
          "%.pdf",
          "%.epub",
        },
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
  },
  {
    "danielfalk/smart-open.nvim",
    event = "LazyFile",
    branch = "0.2.x",
    dependencies = {
      "kkharji/sqlite.lua",
    },
    config = function()
      local telescope = require("telescope")
      telescope.load_extension("smart_open")

      telescope.setup({
        extensions = {
          smart_open = {
            cwd_only = true,
            match_algorithm = "fzf",
          },
        },
      })
    end,
  },
  {
    "debugloop/telescope-undo.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = {
      { "<leader>su", "<cmd>Telescope undo<cr>", desc = "Undos" },
    },
    config = function()
      LazyVim.on_load("telescope.nvim", function()
        require("telescope").setup({
          extensions = {
            undo = {
              side_by_side = true,
              layout_strategy = "vertical",
              layout_config = {
                preview_height = 0.6,
              },
            },
          },
        })
        require("telescope").load_extension("undo")
      end)
    end,
  },
}
