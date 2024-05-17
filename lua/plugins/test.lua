return {
  -- { import = "lazyvim.plugins.extras.test.core" },
  {
    "nvim-neotest/neotest",
    enabled = false,
    dependencies = {
      "antoinemadec/FixCursorHold.nvim",
      "thenbe/neotest-playwright",
      "marilari88/neotest-vitest",
    },
    opts = {
      -- Can be a list of adapters like what neotest expects,
      -- or a list of adapter names,
      -- or a table of adapter names, mapped to adapter configs.
      -- The adapter will then be automatically loaded with the config.
      adapters = {
        -- ["neotest-playwright"] = {},
        ["neotest-vitest"] = {},
      },
    },
  },
}
