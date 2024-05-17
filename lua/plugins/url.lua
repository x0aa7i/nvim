return {
  "sontungexpt/url-open",
  event = "VeryLazy",
  cmd = "URLOpenUnderCursor",
  keys = {
    {
      "gx",
      function()
        vim.cmd("URLOpenUnderCursor")
      end,
      desc = "Open URL",
    },
  },
  config = function()
    require("url-open").setup({})
  end,
}
