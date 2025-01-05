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
    sources = {
      compat = { "codeium" },
      providers = {
        codeium = {
          kind = "Codeium",
          score_offset = 100,
          async = true,
          max_items = 3,
        },
      },
    },
  },
}
