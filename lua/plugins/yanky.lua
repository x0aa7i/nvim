return {
  "gbprod/yanky.nvim",
  keys = {
    { "<leader>p", false },
    {
      "<leader>sp",
      function()
        require("telescope").extensions.yank_history.yank_history({})
      end,
      desc = "Open Yank History",
    },
  },
}
