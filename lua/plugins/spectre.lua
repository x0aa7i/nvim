return {
  -- search/replace in multiple files
  {
   "nvim-pack/nvim-spectre",
    enabled = false,
    lazy = true,
    -- event = "VeryLazy",
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    -- stylua: ignore
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
      { "<leader>sw", function() require("spectre").open_visual({select_word=true}) end, desc = "Search current word" },
      { "<leader>sp", function() require("spectre").open_file_search({select_word=true}) end, desc = "Search on current file" },
    },
  },
}
