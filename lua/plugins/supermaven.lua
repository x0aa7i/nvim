return {
  {
    "supermaven-inc/supermaven-nvim",
    event = "BufRead",
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_word = "<C-]>",
          clear_suggestion = "<C-[>",
        },
        color = {
          suggestion_color = "#414868",
          cterm = 244,
        },
        disable_inline_completion = false, -- disables inline completion for use with cmp
        disable_keymaps = false, -- disables built in keymaps for more manual control
      })
    end,
  },
  {
    "folke/noice.nvim",
    optional = true,
    opts = function(_, opts)
      vim.list_extend(opts.routes, {
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
    end,
  },
}
