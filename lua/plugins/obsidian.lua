local vault_path = "/mnt/buckup/documents/obsidian"

return {
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    event = {
      -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
      ("BufReadPre %s/**.md"):format(vault_path),
      ("BufNewFile %s/**.md"):format(vault_path),
    },
    cmd = { "ObsidianToday", "ObsidianYesterday", "ObsidianTomorrow", "ObsidianNew", "ObsidianSearch" },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    keys = {
      { "<leader>nd", "<cmd>ObsidianDailies<CR>", desc = "Daily notes" },
      { "<leader>nn", "<cmd>ObsidianNew<cr>", desc = "New note" },
      { "<leader>nt", "<cmd>ObsidianTemplate<CR>", desc = "Template" },
      { "<leader>nb", "<cmd>ObsidianBacklinks<cr>", desc = "Backlinks" },
      { "<leader>nl", "<cmd>ObsidianLink<cr>", desc = "Link selection" },
      { "<leader>nf", "<cmd>ObsidianFollowLink<cr>", desc = "Follow link" },
      { "<leader>ns", "<cmd>ObsidianSearch<cr>", desc = "Search" },
      { "<leader>nr", "<cmd>ObsidianRename<cr>", desc = "Rename" },
      { "<leader>nf", "<cmd>ObsidianQuickSwitch<cr>", desc = "Find" },
      { "<leader>ng", "<cmd>ObsidianTags<cr>", desc = "Tags" },
      { "<leader>nw", "<cmd>ObsidianWorkspace personal<cr>", desc = "Personal workspace" },
      { "<leader>no", "<cmd>ObsidianOpen<cr>", desc = "Open in app" },
    },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = vault_path,
        },
      },
      completion = {
        nvim_cmp = true,
      },

      disable_frontmatter = true,

      -- see below for full list of options 👇
      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = "Journal/Daily",
        -- Optional, if you want to change the date format for the ID of daily notes.
        date_format = "%Y-%m-%d",
        -- Optional, if you want to change the date format of the default alias of daily notes.
        alias_format = "%B %-d, %Y",
        -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
        template = "Assets/Templates/nvim/daily.md",
      },

      mappings = {
        -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        -- Toggle check-boxes.
        ["<leader>ch"] = {
          action = function()
            return require("obsidian").util.toggle_checkbox()
          end,
          opts = { buffer = true },
        },
      },

      templates = {
        folder = "Assets/Templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        -- A map for custom variables, the key should be the variable and the value a function
        substitutions = {},
      },
    },
  },
  {
    "letieu/jot.lua",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<leader>nj",
        function()
          require("jot").open()
        end,
        desc = "Project note (jot)",
      },
    },
  },
  { -- emphasized headers & code blocks in markdown
    "lukas-reineke/headlines.nvim",
    ft = { "markdown", "norg", "rmd", "org" },
    opts = function()
      local opts = {}
      for _, ft in ipairs({ "markdown", "norg", "rmd", "org" }) do
        opts[ft] = {
          headline_highlights = {},
          -- disable bullets for now. See https://github.com/lukas-reineke/headlines.nvim/issues/66
          bullets = {},
          fat_headlines = false,
          -- dash_string = "─",
        }
        for i = 1, 6 do
          local hl = "Headline" .. i
          vim.api.nvim_set_hl(0, hl, { link = "Headline", default = true })
          table.insert(opts[ft].headline_highlights, hl)
        end
      end
      return opts
    end,
  },
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader>n"] = { name = "obsidian" },
      },
    },
  },
}
