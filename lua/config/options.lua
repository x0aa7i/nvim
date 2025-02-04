-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.linebreak = true
vim.opt.breakindent = true -- Every wrapped line will continue visually indented
vim.opt.breakindentopt = "list:-1"

vim.opt.pumblend = 0 -- make popup menu transparent, value range [0,100]

-- fold
vim.o.foldcolumn = "auto"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldnestmax = 0
vim.o.foldenable = true
vim.o.foldmethod = "indent"

vim.opt.listchars:append({
  tab = "▏ ",
  trail = "·",
  nbsp = "␣",
  extends = "…",
  precedes = "…",
})

vim.filetype.add({ pattern = { [".*/tmux.*.conf"] = "tmux" } })
