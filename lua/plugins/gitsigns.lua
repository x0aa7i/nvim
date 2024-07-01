return {
  {
    "lewis6991/gitsigns.nvim",
    enabled = true, -- disabled by mini.diff
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      defaults = {
        ["<leader>g"] = {
          h = { name = "Hunks", ["🚫"] = "which_key_ignore" },
        },
      },
    },
  },
}
