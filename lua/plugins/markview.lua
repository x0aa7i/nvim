return {
  "OXY2DEV/markview.nvim",
  ft = { "markdown" },
  opts = function()
    local heading = function(level)
      local icons = { "󰲡", "󰲣", "󰲥", "󰲧", "󰲩", "󰲫" }
      return {
        style = "label",
        hl = "col_" .. level,
        padding_left = " ",
        padding_right = " ",
        icon = string.rep(" ", level - 1) .. icons[level] .. "  ",
      }
    end

    return {
      headings = {
        enable = true,
        shift_width = 0,
        heading_1 = heading(1),
        heading_2 = heading(2),
        heading_3 = heading(3),
        heading_4 = heading(4),
        heading_5 = heading(5),
        heading_6 = heading(6),
      },
    }
  end,
}
