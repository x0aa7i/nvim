-- plugin
local vscode = require("vscode-neovim")

vim.notify = vscode.notify
vim.g.clipboard = vim.g.vscode_clipboard

-- Options
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.timeoutlen = 500
vim.opt.shortmess = "oOtTWIcCFS"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 8
vim.opt.virtualedit = "block"
vim.opt.jumpoptions = "stack"
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.smartindent = true
vim.opt.formatoptions = "tcrqjnl"
vim.opt.clipboard = "unnamedplus"
vim.cmd.syntax("off")

-- Keymaps
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- keymap functions
local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  -- opts.noremap = opts.noremap ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

local function vscode_action(cmd)
  return function()
    vscode.action(cmd)
  end
end

-- Editor: buffers
-- vim.keymap.set("n", "H", vscode_action("workbench.action.previousEditorInGroup"), { desc = "Previous Editor" })
-- vim.keymap.set("n", "L", vscode_action("workbench.action.nextEditorInGroup"), { desc = "Next Editor" })
map("n", "<Leader>bo", vscode_action("workbench.action.closeOtherEditors"), { desc = "Close Other Editors" })
map("n", "<Leader>bh", vscode_action("workbench.action.closeEditorsToTheLeft"), { desc = "Close Left Editors" })
map("n", "<Leader>bl", vscode_action("workbench.action.closeEditorsToTheRight"), { desc = "Close Right Editors" })

-- Search: clear highlight
-- NOTE: conflict with <Esc> of vscode-multi-cursor in operation.lua
map("n", "<Esc>", "<Cmd>nohlsearch|diffupdate|normal! <C-L><CR><Esc>", { desc = "Clear Highlight" })

-- Search: fix direction of n/N
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Search: code navigation
map("n", "gy", vscode_action("editor.action.goToTypeDefinition"), { desc = "Go To Type Definition" })
map("n", "gr", vscode_action("editor.action.goToReferences"), { desc = "Go To References" })
map("n", "gi", vscode_action("editor.action.goToImplementation"), { desc = "Go To Implementations" })

-- Motion: basic move
map({ "n", "x" }, "j", function()
  if vim.v.count == 0 then
    vim.cmd("normal gj") -- vscode's gj
  else
    vim.cmd(string.format("normal! %dj", vim.v.count))
  end
end, { desc = "Down" })

map({ "n", "x" }, "k", function()
  if vim.v.count == 0 then
    vim.cmd("normal gk") -- vscode's gk
  else
    vim.cmd(string.format("normal! %dk", vim.v.count))
  end
end, { desc = "Down" })

-- Motion: diagnostic
map("n", "]g", function()
  vscode.action("workbench.action.editor.nextChange")
  vscode.action("workbench.action.compareEditor.nextChange")
end, { desc = "Next Git Diff" })

map("n", "[g", function()
  vscode.action("workbench.action.editor.previousChange")
  vscode.action("workbench.action.compareEditor.previousChange")
end, { desc = "Prev Git Diff" })

map("n", "]d", vscode_action("editor.action.marker.next"), { desc = "Next Diagnostic" })
map("n", "[d", vscode_action("editor.action.marker.prev"), { desc = "Prev Diagnostic" })

-- Operation: delete or change without register
map({ "n", "x" }, "<A-d>", '"_d', { desc = "Delete Without Register" })
map({ "n", "x" }, "<A-c>", '"_c', { desc = "Change Without Register" })

-- Operation: better indenting
map("n", "<", "<<", { desc = "Deindent" })
map("n", ">", ">>", { desc = "Indent" })
map("x", "<", "<gv", { desc = "Deindent" })
map("x", ">", ">gv", { desc = "Indent" })

-- Operation: yank and paste
map("i", "<C-v>", "<C-g>u<C-r><C-p>+")
map("c", "<C-v>", "<C-r>+")

-- Operation: undo
map("i", "<C-z>", "<Cmd>normal u<CR>")

-- Operation: repeat
vim.keymap.del("x", "mi")
vim.keymap.del("x", "mI")
vim.keymap.del("x", "ma")
vim.keymap.del("x", "mA")

-- tab navigation
map("n", "<tab>", vscode_action("workbench.action.nextEditorInGroup"), { desc = "Next Editor" })
map("n", "<S-tab>", vscode_action("workbench.action.previousEditorInGroup"), { desc = "Previous Editor" })
--
-- next/previous git change
map("n", "]g", vscode_action("workbench.action.editor.nextChange"))
map("n", "[g", vscode_action("workbench.action.editor.prevChange"))
map("n", "gr", vscode_action("editor.action.referenceSearch.trigger"))

map("n", "<leader>cc", vscode_action("workbench.action.commentLine"))
map("n", "<leader>sg", vscode_action("workbench.action.findInFiles"))
map("n", "<leader>ci", vscode_action("extension.toggleBool"))
map("n", "<leader>e", vscode_action("workbench.view.explorer"))
map("n", "<leader>ff", vscode_action("workbench.action.quickOpen"))

-- Text navigation
map("n", "L", "$")
map("n", "H", "^")

map("n", "<cr>", "ciw", { desc = "Change word under cursor" })

-- inset empty blank line above/below
map("n", "<leader>o", "m`o<esc>``", { desc = "Insert blank line above" })
map("n", "<leader>O", "m`O<esc>``", { desc = "Insert blank line below" })
