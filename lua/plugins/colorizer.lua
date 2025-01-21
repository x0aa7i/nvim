return {
  "catgoose/nvim-colorizer.lua",
  event = "BufReadPre",
  opts = {
    filetypes = {
      "css",
      "scss",
      html = { names = false },
      "svelte",
      "javascript",
      "typescript",
      "lua",
      "json",
      cmp_docs = {
        always_update = true,
      },
    },
    user_default_options = {
      -- Available modes for `mode`: foreground, background,  virtualtext
      mode = "virtualtext",
      css = true,
      css_fn = true,
      names = false,
      tailwind = false, -- "normal" | "lsp" | "both" -- true is 'normal'
      virtualtext = " ",
      virtualtext_inline = true,
    },
  },
}
