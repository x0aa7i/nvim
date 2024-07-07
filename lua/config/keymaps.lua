-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- keymap function
local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  -- opts.noremap = opts.noremap ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Quit
map({ "n" }, "<C-q>", "<cmd>qa<cr>", { desc = "Quit all" })

-- Press jk fast to enter normal mode
map("i", "jk", "<ESC>")

-- inset empty blank line above/below
map("n", "<leader>o", "m`o<esc>``", { desc = "Insert blank line above" })
map("n", "<leader>O", "m`O<esc>``", { desc = "Insert blank line below" })

-- select all
map({ "i", "n", "v" }, "<C-a>", "<esc>ggVG")

-- Move to start/end of line
map({ "n", "x", "o" }, "H", "g^")
map({ "n", "x", "o" }, "L", "g$")

-- Delete word with backspace
map("i", "<C-BS>", "<C-w>")

map("n", "<cr>", "ciw", { desc = "Change word under cursor" })
map("n", "gl", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

-- Google search
local searching_google_in_visual =
  [[<ESC>gv"gy<ESC>:lua vim.fn.system({'xdg-open', 'https://google.com/search?q=' .. vim.fn.getreg('g')})<CR>]]

vim.keymap.set("v", "gx", searching_google_in_visual, { silent = true, noremap = true })

local Util = require("lazyvim.util")
-- local unmap = vim.keymap.del

if not vim.g.vscode then
  map("n", "<C-\\>", function()
    Util.terminal(nil, { cwd = Util.root() })
  end, { desc = "Terminal (root dir)" })

  map("t", "<C-\\>", "<cmd>close<cr>", { desc = "Hide Terminal" })
end
