return {
  "shortcuts/no-neck-pain.nvim",
  version = "*",
  event = "VeryLazy",
  keys = {
    { "<leader>uN", "<cmd>NoNeckPain<cr>", desc = "No Neck Pain" },
  },
  opts = {
    width = 110,
  },
  config = true,
}
