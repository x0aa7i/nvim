return {
  "folke/noice.nvim",
  opts = function(_, opts)
    opts.presets = vim.tbl_extend("force", opts.presets, {
      lsp_doc_border = true, -- add a border to hover docs and signature help
    })

    opts.routes = vim.tbl_extend("force", opts.routes, {
      -- write/deletion messages
      { filter = { event = "msg_show", find = "%d+B written$" }, view = "mini" },
      { filter = { event = "msg_show", find = "%d+L, %d+B$" }, view = "mini" },
      { filter = { event = "msg_show", find = "%-%-No lines in buffer%-%-" }, view = "mini" },
      -- Diagnostics
      { filter = { event = "msg_show", find = "No more valid diagnostics to move to" }, view = "mini" },
      -- nvim-treesitter
      { filter = { event = "msg_show", find = "^%[nvim%-treesitter%]" }, view = "mini" },
      { filter = { event = "notify", find = "All parsers are up%-to%-date" }, view = "mini" },
      -- LSP
      {
        filter = { event = "notify", find = "No information available" },
        view = "mini",
        opts = { lang = "svelte", skip = true },
      },
      -- Supermaven
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "Starting Supermaven" },
            { find = "Supermaven Free Tier" },
          },
        },
        skip = true,
      },
    })

    opts.views = {
      cmdline_popup = {
        position = { row = 10, col = "50%" },
      },
      popupmenu = {
        position = { row = 13, col = "50%" },
        size = {
          width = 60,
          max_height = 10,
        },
        border = {
          style = "rounded",
          padding = { 0, 1 },
        },
        win_options = {
          winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
        },
      },
    }
  end,
}
