-- keymap function
local function map(mode, lhs, rhs, opts)
	opts = opts or {}
	opts.silent = opts.silent ~= false
	-- opts.noremap = opts.noremap ~= false
	vim.keymap.set(mode, lhs, rhs, opts)
end

--Remap space as leader key
map("", "<Space>", "<Nop>")
vim.g.mapleader = " "

-- better up/down
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })

--save
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr>", { desc = "Save file" })

-- quit
map({ "i", "n" }, "<C-q>", "<cmd>q<cr>", { desc = "Quit" })

-- undo & redo
map({ "i", "n", "v", "x" }, "<C-z>", "<cmd>:undo<cr>")

-- copy & paste
map("v", "<C-c>", '"+y', { desc = "Copy to clipboard" })
map("v", "<C-x>", '"+x', { desc = "Cut to clipboard" })
map("i", "<C-v>", "<C-r>*")

-- Better paste
map("v", "p", '"_dP')
map("x", "<leader>p", '"_dP')

-- map({ "n", "v" }, "d", '"_d', { desc = "Delete without yank" })
map({ "n", "v" }, "c", '"_c', { desc = "Change without yank" })
map("v", "s", '"_s', { desc = "Replace without yank" })

-- select all
map({ "i", "n", "v" }, "<C-a>", "<esc>ggVG")

-- delete word to the left
map("i", "<C-BS>", "<C-w>")
map("i", "<C-h>", "<C-w>")

map("n", "<cr>", "ciw", { desc = "Change inner word" })

-- select with shift arrows
-- map("n", "<S-Up>", "v<Up>")
-- map("n", "<S-Down>", "v<Down>")
-- map("n", "<S-Left>", "v<Left>")
-- map("n", "<S-Right>", "v<Right>")

-- map("v", "<S-Up>", "<Up>")
-- map("v", "<S-Down>", "<Down>")
-- map("v", "<S-Left>", "<Left>")
-- map("v", "<S-Right>", "<Right>")

-- map('i', '<S-Up>', '<Esc>v<Up>')
-- map('i', '<S-Down', '<Esc>v<Down>')
-- map('i', '<S-Left>', '<Esc>v<Left>')
-- map('i', '<S-Right>', '<Esc>v<Right>')

-- select with ctrl shift arrows
-- map("n", "<C-S-Left>", "vb")
-- map("n", "<C-S-Right>", "vw")

-- map("i", "<C-S-Left>", "<Esc>vb")
-- map("i", "<C-S-Right>", "<Esc>vw")

-- duplicate line
-- map({ "i", "n", "v" }, "<C-j>", "<cmd>:t.<CR>")
map({ "i", "n", "v" }, "<C-A-Down>", "<cmd>:t.<CR>")

-- Text navigation
map("n", "<S-l>", "$")
map("n", "<S-h>", "^")

-- Drag lines
map("n", "<A-Up>", ":m .-2<CR>", { desc = "Move line up" })
map("n", "<A-Down>", ":m .+1<CR>", { desc = "Move line down" })
map("i", "<A-Up>", "<ESC>:m .-2<CR>==gi", { desc = "Move line up" })
map("i", "<A-Down>", "<ESC>:m .+1<CR>==gi", { desc = "Move line down" })
map("v", "<A-Up>", ":m '<-2<CR>gv=gv", { desc = "Move line up" })
map("v", "<A-Down>", ":m '>+1<CR>gv=gv", { desc = "Move line down" })

map("n", "<A-k>", ":m .-2<CR>", { desc = "Move line up" })
map("n", "<A-j>", ":m .+1<CR>", { desc = "Move line down" })
map("i", "<A-k>", "<ESC>:m .-2<CR>==gi", { desc = "Move line up" })
map("i", "<A-j>", "<ESC>:m .+1<CR>==gi", { desc = "Move line down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move line down" })

-- Better window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Resize with arrows
map("n", "<C-Up>", ":resize -2<CR>")
map("n", "<C-Down>", ":resize +2<CR>")
map("n", "<C-Left>", ":vertical resize -2<CR>")
map("n", "<C-Right>", ":vertical resize +2<CR>")

-- keep cursor in place when joining lines
map("n", "J", "mzJ`z")

-- fixed cursor in half page jumping
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- fixed cursor for next search
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- buffer navigation using bufferline
map("n", "<tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
map("n", "<S-tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
-- map("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
-- map("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })

-- Close buffers
map("n", "<S-q>", "<cmd>bdelete<CR>")
-- map("n", "<S-w>", "<cmd>bdelete<CR>")

-- Clear highlights
-- map("n", "<leader>h", "<cmd>noh<CR>", { desc = "Clear highlight" })

-- Clear search highlight with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>")

-- Press jk fast to enter normal mode
map("i", "jk", "<ESC>")

-- copy to system clipboard
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy to system clipboard" })
map("n", "<leader>Y", '"+Y', { desc = "Copy to system clipboard" })

-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Terminal
map("t", "<C-\\>", "<C-\\><C-n>")

-- inset empty blank line above/below
map("n", "<leader>o", "m`o<esc>``", { desc = "Insert blank line above" })
map("n", "<leader>O", "m`O<esc>``", { desc = "Insert blank line below" })

-- tabs
-- map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
-- map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
-- map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
-- map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
-- map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
-- map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
