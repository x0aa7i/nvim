return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      preset = {
        header = require("utils.logos").sharp,
      },
    },
    indent = {
      enabled = true,
      indent = {
        char = "┊",
        only_current = true,
      },
      scope = {
        only_current = true,
      },
      animate = {
        enabled = false,
        easing = "linear",
        duration = {
          step = 15, -- ms per step
          total = 150, -- maximum duration
        },
      },
    },
    statuscolumn = {
      enabled = true,
      left = { "mark", "sign" }, -- priority of signs on the left (high to low)
      right = { "fold", "git" }, -- priority of signs on the right (high to low)
      folds = {
        open = true, -- show open fold icons
        git_hl = true, -- use Git Signs hl for fold icons
      },
      git = {
        -- patterns to match Git signs
        patterns = { "GitSign", "MiniDiffSign" },
      },
      refresh = 50, -- refresh at most every 50ms
    },
  },
}
