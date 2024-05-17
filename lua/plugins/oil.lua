return {
  "stevearc/oil.nvim",
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>-", "<CMD>Oil --float<CR>", desc = "Open file explorer (Oil)" },
  },
  opts = {
    columns = {
      "icon",
      -- "permissions",
      -- "size",
      -- "mtime",
    },
    delete_to_trash = true,
    keymaps = {
      ["q"] = "actions.close",
      ["<C-s>"] = "actions.save",
      ["<C-v>"] = "actions.select_vsplit",
      ["<C-x>"] = "actions.select_split",
      ["<C-y>"] = "actions.copy_entry_path",
    },
    view_options = {
      show_hidden = true,
    },
    float = {
      padding = 2,
      max_width = 100,
      max_height = 40,
    },
  },
}
