return {
  {
    -- indent guides for Neovim
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      indent = { char = "┊" },
      scope = { enabled = false },
    },
  },
  {
    "echasnovski/mini.indentscope",
    opts = function()
      local indentscope = require("mini.indentscope")

      return {
        -- symbol = "▏",
        symbol = "│",
        options = { try_as_border = true },
        draw = {
          delay = 20,
          animation = indentscope.gen_animation.quadratic({
            easing = "out",
            duration = 10,
            unit = "step",
          }),
        },
      }
    end,
  },
}
