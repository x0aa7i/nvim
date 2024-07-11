-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- keymap function
local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  opts.noremap = opts.noremap ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Quit
map({ "n" }, "<C-q>", "<cmd>qa<cr>", { desc = "Quit all" })

-- Better Search navigation
map("n", "n", "nzz")
map("n", "N", "Nzz")
map("n", "*", "*zz")
map("n", "#", "#zz")
map("n", "g*", "g*zz")
map("n", "g#", "g#zz")

-- Press jk fast to enter normal mode
map("i", "jk", "<ESC>")

-- inset empty blank line above/below
map("n", "<leader>o", "m`o<esc>``", { desc = "Insert blank line above" })
map("n", "<leader>O", "m`O<esc>``", { desc = "Insert blank line below" })

-- select all
map({ "i", "n", "v" }, "<C-a>", "<esc>ggVG")

-- Move to start/end of line
map({ "n", "x" }, "H", "^")
map({ "n", "x" }, "L", "$")

-- Delete word with backspace
map("i", "<C-BS>", "<C-w>")
map("i", "<C-Del>", "<esc>cw")

map("n", "<cr>", "ciw", { desc = "Change word under cursor" })
map("n", "gl", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

-- windows
map("n", "<leader>wq", "<C-W>c", { desc = "Delete Window", remap = true })
map("n", "<leader>ws", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>wv", "<C-W>v", { desc = "Split Window Right", remap = true })

-- Comment
vim.keymap.del("n", "<c-/>") -- Remove terminal keybind
map("n", "<c-/>", "gcc", { desc = "comment toggle", remap = true })
map("v", "<c-/>", "gc", { desc = "comment toggle", remap = true })

-- Terminal
-- stylua: ignore
local lazyterm = function() LazyVim.terminal(nil, { cwd = LazyVim.root() }) end
map("n", "<c-\\>", lazyterm, { desc = "Terminal (Root Dir)" })
map("t", "<c-\\>", "<cmd>close<cr>", { desc = "Hide Terminal" })

-- Google search
local searching_google_in_visual =
  [[<ESC>gv"gy<ESC>:lua vim.fn.system({'xdg-open', 'https://google.com/search?q=' .. vim.fn.getreg('g')})<CR>]]

vim.keymap.set("v", "gx", searching_google_in_visual, { silent = true, noremap = true })
