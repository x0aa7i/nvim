-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Disable diagnostic for .env files
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = { "*.env", ".env.*" },
  desc = "Disable diagnostic for .env files",
  callback = function(ev)
    vim.diagnostic.enable(false, { bufnr = ev.buf })
  end,
})

-- Remove '-' from iskeyword
vim.api.nvim_create_autocmd({ "BufEnter", "BufReadPost" }, {
  pattern = "*",
  callback = function()
    vim.opt_local.iskeyword:remove("-")
  end,
})
