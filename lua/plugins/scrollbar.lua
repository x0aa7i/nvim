return {
  "petertriho/nvim-scrollbar",
  event = "VeryLazy",
  config = function()
  local scrollbar = require("scrollbar")
  scrollbar.setup({
    show_in_active_only = true,
    handle = {
      blend = 30,
      color = "#32344a",
      color_nr = 234,
    },
    marks = {
      Search = { color = "#787c99" },
      Error  = { color = "#f7768e" },
      Warn   = { color = "#e0af68" },
      Info   = { color = "#7aa2f7" },
      Hint   = { color = "#7aa2f7" },
      Misc   = { color = "#449dab" },
      Cursor = { color = "#acb0d0", text = " " },
    }
  })
	end,
}
