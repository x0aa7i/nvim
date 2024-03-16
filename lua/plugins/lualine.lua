return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      icons_enabled = true,
      component_separators = "",
      -- section_separators = "",
    },
    sections = {
      lualine_a = {
        { "mode", icon = { "" } },
      },
      lualine_b = {},
      lualine_y = {},
      lualine_z = {
        { "progress", separator = " ", padding = { left = 1, right = 0 } },
        { "location", padding = { left = 0, right = 1 } },
      },
    },
  },
}
