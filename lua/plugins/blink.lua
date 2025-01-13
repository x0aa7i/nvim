return {
  "saghen/blink.cmp",
  dependencies = {
    "xzbdmw/colorful-menu.nvim",
  },
  opts = {
    keymap = {
      preset = "enter",
      ["<C-J>"] = { "select_next", "fallback" },
      ["<C-K>"] = { "select_prev", "fallback" }, -- conflic with LSP Signature in svelte files

      ["<C-U>"] = { "scroll_documentation_up", "fallback" },
      ["<C-D>"] = { "scroll_documentation_down", "fallback" },
    },
    completion = {
      menu = {
        draw = {
          align_to = "label", -- 'label' or 'none' to disable, or 'cursor' to align to the cursor
          -- We don't need label_description now because label and label_description are already
          -- conbined together in label by colorful-menu.nvim.
          columns = { { "kind_icon" }, { "label", gap = 1 } },
          components = {
            label = {
              text = function(ctx)
                return require("colorful-menu").blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require("colorful-menu").blink_components_highlight(ctx)
              end,
            },
            kind_icon = {
              text = function(ctx)
                if require("blink.cmp.completion.windows.render.tailwind").get_hex_color(ctx.item) then
                  return "󱓻"
                end
                return ctx.kind_icon .. ctx.icon_gap
              end,
            },
          },
        },
      },
      ghost_text = { enabled = false },
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
