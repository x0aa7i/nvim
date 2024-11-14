return {
  "MeanderingProgrammer/render-markdown.nvim",
  opts = {
    file_types = { "markdown", "norg", "rmd", "org" },
    latex = { enabled = false },
    code = {
      sign = false,
      width = "block",
      right_pad = 2,
      left_pad = 2,
      position = "right",
    },
    heading = {
      sign = false,
      icons = {},
    },
  },
  ft = { "markdown", "norg", "rmd", "org" },
  config = function(_, opts)
    require("render-markdown").setup(opts)
    Snacks.toggle({
      name = "Render Markdown",
      get = function()
        return require("render-markdown.state").enabled
      end,
      set = function(enabled)
        local m = require("render-markdown")
        if enabled then
          m.enable()
        else
          m.disable()
        end
      end,
    }):map("<leader>um")
  end,
}
