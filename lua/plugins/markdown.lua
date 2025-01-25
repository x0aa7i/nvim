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
    checkbox = {
      unchecked = { icon = "󰄱 " },
      checked = { icon = " " },
      custom = {
        incomplete = { raw = "[/]", rendered = "󰦖 ", highlight = "RenderMarkdownIncomplete", scope_highlight = nil },
        canceled = { raw = "[-]", rendered = "󰜺 ", highlight = "RenderMarkdownCanceled", scope_highlight = nil },
        forwarded = { raw = "[>]", rendered = " ", highlight = "RenderMarkdownForwarded", scope_highlight = nil },
        schedule = { raw = "[<]", rendered = " ", highlight = "RenderMarkdownSchedule", scope_highlight = nil },

        info = { raw = "[i]", rendered = " ", highlight = "RenderMarkdownInfo", scope_highlight = nil },
        idea = { raw = "[I]", rendered = " ", highlight = "RenderMarkdownIdea", scope_highlight = nil },
        important = { raw = "[!]", rendered = " ", highlight = "RenderMarkdownImportant", scope_highlight = nil },
        question = { raw = "[?]", rendered = " ", highlight = "RenderMarkdownQuestion", scope_highlight = nil },
        pros = { raw = "[p]", rendered = " ", highlight = "RenderMarkdownPros", scope_highlight = nil },
        cons = { raw = "[c]", rendered = " ", highlight = "RenderMarkdownCons", scope_highlight = nil },

        fire = { raw = "[f]", rendered = " ", highlight = "RenderMarkdownFire", scope_highlight = nil },
        star = { raw = "[*]", rendered = " ", highlight = "RenderMarkdownStar", scope_highlight = nil },
        bookmark = { raw = "[b]", rendered = " ", highlight = "RenderMarkdownBookmark", scope_highlight = nil },
        trend_up = { raw = "[u]", rendered = " ", highlight = "RenderMarkdownTrendUp", scope_highlight = nil },
        trend_down = { raw = "[d]", rendered = " ", highlight = "RenderMarkdownTrendDown", scope_highlight = nil },
        win = { raw = "[w]", rendered = " ", highlight = "RenderMarkdownWin", scope_highlight = nil },

        key = { raw = "[k]", rendered = " ", highlight = "RenderMarkdownKey", scope_highlight = nil },
        quote = { raw = '["]', rendered = " ", highlight = "RenderMarkdownQuote", scope_highlight = nil },
        money = { raw = "[S]", rendered = " ", highlight = "RenderMarkdownMoney", scope_highlight = nil },
        location = { raw = "[l]", rendered = " ", highlight = "RenderMarkdownLocation", scope_highlight = nil },
        new = { raw = "[n]", rendered = " ", highlight = "RenderMarkdownNew", scope_highlight = nil },
        progress0 = { raw = "[0]", rendered = " ", highlight = "RenderMarkdownProgress", scope_highlight = nil },
        progress1 = { raw = "[1]", rendered = " ", highlight = "RenderMarkdownProgress", scope_highlight = nil },
        progress2 = { raw = "[2]", rendered = " ", highlight = "RenderMarkdownProgress", scope_highlight = nil },
        progress3 = { raw = "[3]", rendered = " ", highlight = "RenderMarkdownProgress", scope_highlight = nil },
        progress4 = { raw = "[4]", rendered = " ", highlight = "RenderMarkdownProgress", scope_highlight = nil },
      },
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
