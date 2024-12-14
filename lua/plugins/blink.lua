return {
  "saghen/blink.cmp",
  enabled = false,
  opts = {
    keymap = {
      ["<C-J>"] = { "select_next", "fallback" },
      ["<C-K>"] = { "select_prev", "fallback" }, -- conflic with LSP Signature in svelte files

      ["<C-U>"] = { "scroll_documentation_up", "fallback" },
      ["<C-D>"] = { "scroll_documentation_down", "fallback" },
    },
    -- sources = {
    --   providers = {
    --     codeium = {
    --       name = "codeium",
    --       module = "blink.compat.source",
    --       kind = "Codeium",
    --       max_item = 3,
    --     },
    --   },
    -- },
  },
}
