return {
  "monaqa/dial.nvim",
  opts = function(_, opts)
    local augend = require("dial.augend")

    return vim.tbl_deep_extend("force", opts, {
      groups = {
        default = {
          augend.constant.alias.bool, -- boolean value (true <-> false)
        },
      },
    })
  end,
}
