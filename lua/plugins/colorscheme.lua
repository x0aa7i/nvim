return {
  "folke/tokyonight.nvim",
  lazy = true,
  opts = function(_, opts)
    opts.style = "night"
    opts.on_colors = function(colors)
      -- colors.bg_dark = "#101317"
      -- colors.bg = "#16161e"
      -- colors.bg_highlight = "#212231"
      colors.bg_light = "#2a2d3f"
      -- colors.terminal_black = "#414868"
      -- colors.bg_visual = "#2a2d3f"
      colors.fg = "#a9b1d6"
      colors.red = "#f7768e"
      colors.red1 = "#db4b4b"
      colors.green = "#22d0a2"
      -- colors.green1 = "#73daca"
      -- colors.green2 = "#41a6b5"
      -- colors.teal = "#1abc9c"
      colors.magenta = "#9381ff"
      colors.border_highlight = colors.magenta
    end
    opts.on_highlights = function(H, C)
      H.NeoTreeTitleBar = { fg = C.bg_dark, bg = C.magenta }
      H.NeoTreeFloatBorder = { fg = C.magenta, bg = C.bg_dark }
      H.NeoTreeGitUntracked = { fg = C.green, bold = true }

      H.IlluminatedWordRead = { bg = C.bg_light }
      H.IlluminatedWordText = { bg = C.bg_light }
      H.IlluminatedWordWrite = { bg = C.bg_light }
      H.illuminatedCurWord = { bg = C.bg_light }
      H.illuminatedWord = { bg = C.bg_light }

      H.LspReferenceText = { bg = C.bg_light }
      H.LspReferenceRead = { bg = C.bg_light }
      H.LspReferenceWrite = { bg = C.bg_light }

      H.CursorLine = { bg = "#212231" }
      H.CursorLineNr = { fg = C.magenta }
      H.SatelliteBar = { bg = C.terminal_black } -- scrollbar
    end
  end,
}
