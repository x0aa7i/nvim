return {
  "luukvbaal/statuscol.nvim",
  event = { "LazyFile" },
  config = function()
    local builtin = require("statuscol.builtin")
    require("statuscol").setup({
      ft_ignore = {
        "neo-tree",
        "neo-tree-popup",
        "alpha",
        "dashboard",
        "lazy",
        "mason",
        "noice",
        "toggleterm",
      },
      relculright = true, -- whether to right-align the cursor line number with 'relativenumber' set
      segments = {
        { text = { "%s" }, click = "v:lua.ScSa" }, -- sign
        {
          text = { builtin.lnumfunc, " " }, -- line number
          condition = { true, builtin.not_empty },
          click = "v:lua.ScLa",
        },
        { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" }, -- fold
      },
    })
  end,
}
