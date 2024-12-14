return {
  {
    "neovim/nvim-lspconfig",
    optional = true,
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- unmap hover keymap
      keys[#keys + 1] = { "K", false }
    end,
  },
  { -- better fold
    "kevinhwang91/nvim-ufo",
    enabled = false,
    event = { "BufRead", "BufNewFile" },
    dependencies = { "kevinhwang91/promise-async" },
  -- stylua: ignore start
    keys = {
      { 'zR', function() require('ufo').openAllFolds() end },
      { 'zM', function() require('ufo').closeAllFolds() end },
      -- { 'zr', function() require('ufo').openFoldsExceptKinds() end },
      -- { 'zm', function() require('ufo').closeFoldsWith() end },
    },
    -- stylua: ignore end
    -- Specifies code to run before this plugin is loaded.
    opts = function()
      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (" 󰁂 %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end

      local ft_providers = {
        ["neo-tree"] = "",
      }

      return {
        fold_virt_text_handler = handler,
        provider_selector = function(_, ft, _)
          -- INFO some filetypes only allow indent, some only LSP, some only
          -- treesitter. However, ufo only accepts two kinds as priority,
          -- therefore making this function necessary :/
          local lspWithOutFolding = { "markdown", "sh", "css", "html", "python" }
          if vim.tbl_contains(lspWithOutFolding, ft) then
            return { "treesitter", "indent" }
          end
          return ft_providers[ft] or { "treesitter", "indent" }
        end,
        -- when opening the buffer, close these fold kinds
        -- use `:UfoInspect` to get available fold kinds from the LSP
        close_fold_kinds_for_ft = {
          -- default = { "imports", "comment" },
        },
        open_fold_hl_timeout = 400,
      }
    end,
    config = function(_, opts)
      require("ufo").setup(opts)

      local map = require("lazyvim.util").safe_keymap_set
      map("n", "K", function()
        if not require("ufo").peekFoldedLinesUnderCursor() then
          vim.lsp.buf.hover()
        end
      end, { desc = "Peek folded lines or hover" })
    end,
  },
}
