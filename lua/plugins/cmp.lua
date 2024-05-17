return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    { "octaltree/cmp-look", ft = { "markdown", "text" } }, -- dictionary
  },
  opts = function(_, opts)
    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local cmp = require("cmp")

    opts.mapping = vim.tbl_extend("force", opts.mapping, {
      ["<C-j>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<C-k>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end, { "i", "s" }),
    })

    opts.sources = cmp.config.sources({
      { name = "codeium", max_item_count = 4 },
      { name = "nvim_lsp" },
      { name = "buffer", max_item_count = 5 },
      { name = "path", max_item_count = 3 },
      { name = "snippets" },
    }, {
      { name = "buffer" },
      { name = "look", keyword_length = 3 },
    })
  end,
}
