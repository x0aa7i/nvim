return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  init = function()
    -- Show the current document symbols location from Trouble in lualine
    vim.g.trouble_lualine = false
  end,
  opts = function(_, opts)
    local function total_lines()
      return "󰦨 " .. vim.api.nvim_buf_line_count(0)
    end

    opts.options.component_separators = ""

    opts.sections.lualine_a = {
      {
        "mode",
        icon = { "" },
        fmt = function(str)
          return str:sub(1, 3)
        end,
      },
    }

    opts.sections.lualine_b = {}

    table.insert(opts.sections.lualine_c, { "filesize", color = { fg = "#737aa2" } })
    table.insert(opts.sections.lualine_x, { total_lines, color = { fg = "#a9b1d6" } })

    opts.sections.lualine_y = {}
    opts.sections.lualine_z = {
      -- location replaced with scrollbar
      -- { "progress", padding = { left = 1, right = 0 } },
      { "location", padding = { left = 1, right = 1 } },
    }
  end,
}
