return {
  "folke/tokyonight.nvim",
  lazy = true,
  config = function()
    require("tokyonight").setup({
      style = "night",
      ---@class colors
      on_colors = function(colors)
        -- colors.bg_dark = "#101317"
        -- colors.bg = "#1a1b26"
        -- colors.bg = "#16161e"
        -- colors.bg_highlight = "#212231"
        colors.bg_light = "#2a2d3f"
        -- colors.terminal_black = "#414868"
        -- colors.fg = "#c0caf5"
        colors.fg = "#a9b1d6"
        -- colors.fg_dark = "#a9b1d6"
        -- colors.fg_gutter = "#3b4261"
        -- colors.dark3 = "#545c7e"
        -- colors.comment = "#565f89"
        -- colors.dark5 = "#737aa2"
        -- colors.blue0 = "#3d59a1"
        -- colors.blue = "#7aa2f7"
        -- colors.cyan = "#7dcfff"
        -- colors.blue1 = "#2ac3de"
        -- colors.blue2 = "#0db9d7"
        -- colors.blue5 = "#89ddff"
        -- colors.blue6 = "#b4f9f8"
        -- colors.blue7 = "#394b70"
        -- colors.magenta = "#bb9af7"
        -- colors.magenta2 = "#ff007c"
        -- colors.purple = "#9d7cd8"
        -- colors.orange = "#ff9e64"
        -- colors.yellow = "#e0af68"
        -- colors.yellow2 = "#7E6039"
        -- colors.green = "#9ece6a"
        -- colors.green1 = "#73daca"
        -- colors.green2 = "#41a6b5"
        -- colors.teal = "#1abc9c"
        -- colors.red = "#f7768e"
        -- colors.red1 = "#db4b4b"
        -- colors.green = "#86E996"
        colors.green = "#22d0a2"
        -- colors.purple = "#ef7a85"
        colors.magenta = "#9381ff"
      end,
      on_highlights = function(H, C)
        H.NvimTreeNormal = { bg = C.bg }
        H.NvimTreeNormalNC = { bg = C.bg }
        H.NvimTreeWinSeparator = { fg = C.bg_dark, bg = C.bg }
        H.DashboardMruTitle = { fg = C.orange, bold = true }
        H.DashboardProjectTitle = { fg = C.orange, bold = true }
        H.DashboardProjectIcon = { fg = C.magenta, bold = true }
        H.SagaNormal = { bg = C.bg }
        H.SagaBorder = { bg = C.bg, fg = C.orange }
        H.SpecialCmpBorder = { bg = C.bg }
        H.Pmenu = { bg = C.bg }
        H.LeapBackdrop = {}
        H.LeapLabelPrimary = { bg = C.bg_dark, fg = C.red1 }
        H.LeapLabelSecondary = { bg = C.bg_dark, fg = C.red1 }
        H.IndentBlanklineContextChar = { fg = C.fg_gutter }
        H.TelescopePromptNormal = { bg = C.bg_dark }
        -- H.TelescopePromptTitle = { fg = C.bg_dark, bg = C.magenta }
        -- H.TelescopePromptBorder = { fg = C.bg_dark, bg = C.bg_dark }
        -- H.TelescopePreviewTitle = { fg = C.bg_dark, bg = C.magenta }
        H.TelescopeSelection = { bg = C.fg_gutter }
        H.TelescopeBorder = { fg = C.magenta, bg = C.bg_dark }
        H.NeoTreeTitleBar = { fg = C.bg_dark, bg = C.magenta }
        H.NeoTreeFloatBorder = { fg = C.magenta, bg = C.bg_dark }
        -- H.NeoTreeGitModified = { fg = C.yellow, bold = true }
        H.NeoTreeGitUntracked = { fg = C.green, bold = true }
        -- H.GitSignsAdd = { fg = C.green }
        -- H.GitSignsChange = { fg = C.yellow2 }
        -- H.GitSignsDelete = { fg = C.red }
        H.CursorLineNr = { fg = C.magenta, style = "bold" }
        H.CursorLine = { bg = C.bg_highlight }
        H.SatelliteBar = { bg = C.terminal_black } -- scrollbar
        H.ActionText = { fg = C.yellow }
      end,
    })
  end,
}
