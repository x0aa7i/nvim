return {
  "saghen/blink.cmp",
  dependencies = {
    "xzbdmw/colorful-menu.nvim",
  },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
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
          align_to = "label",
          treesitter = { "lsp" },
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
      compat = {
        "codeium",
        "markdown",
        "obsidian",
        "obsidian_new",
        "obsidian_tags",
      },
      providers = {
        codeium = {
          kind = "Codeium",
          score_offset = 100,
          async = true,
          max_items = 3,
        },
        markdown = {
          name = "RenderMarkdown",
          module = "render-markdown.integ.blink",
          fallbacks = { "lsp" },
        },
        obsidian = { name = "obsidian", module = "blink.compat.source" },
        obsidian_new = { name = "obsidian_new", module = "blink.compat.source" },
        obsidian_tags = { name = "obsidian_tags", module = "blink.compat.source" },
      },
    },
  },
}
