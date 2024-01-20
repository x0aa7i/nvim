-- stylua: ignore start
-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
vim.opt.termguicolors = true -- Enable 24-bit RGB colors
-- vim.opt.guifont = { "FiraCode Nerd Font", ":h12" }
vim.opt.mouse = "a"          -- allow the mouse to be used in neovim
vim.opt.number = true        -- Show line number
vim.opt.relativenumber = true
vim.opt.numberwidth = 4      -- set number column width to 2 {default 4}

vim.opt.scrolloff = 5        -- scroll offeset at the top and bottom of file
vim.opt.sidescrolloff = 5
vim.opt.showmode = false     -- Dont show mode since we have a statusline
vim.opt.signcolumn = "yes"   -- Always show the signcolumn, otherwise it would shift the text each time

vim.opt.showtabline = 0      -- always show tabs
vim.opt.laststatus = 3
vim.opt.showcmd = false
vim.opt.ruler = false
vim.opt.pumheight = 10     -- pop up menu height
vim.opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = false       -- display lines as one long line
vim.opt.fillchars.eob = " "
vim.opt.list = false       -- Show invisible characters (tabs, spaces...)
vim.opt.listchars = {
  -- space = ".",
  -- eol = "󰌑",
  -- eol = "↴",
  nbsp = "␣",
  trail = "·",
  precedes = "←",
  extends = "→",
  tab = "¬ ",
  -- tab = "▸ ",
  conceal = "※",
}
-- vim.opt.shortmess:append "c"
vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })
vim.opt.iskeyword:append("-") -- treat dash separated words as a single word

-- vim.opt.whichwrap = "<,>,[,]"         -- wrap line
-- vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.cursorline = true  -- highlight the current line

vim.opt.splitright = true  -- Force all Vertical split to the right
vim.opt.splitbelow = true  -- Force all Horizontal split to the bottom

vim.opt.colorcolumn = '100' -- Line lenght marker at 100 columns
vim.opt.laststatus = 0     -- Set global statusline

vim.opt.timeout = true
vim.opt.timeoutlen = 1000 -- time to wait for a mapped sequence to complete (in milliseconds)

-- vim.opt.cmdheight = 0                           -- more space in the neovim command line for displaying messages
-- vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
vim.opt.expandtab = true   -- Use spaces instead of tabs
vim.opt.tabstop = 2        -- insert 2 spaces for a tab
vim.opt.expandtab = true   -- convert tabs to spaces
vim.opt.shiftwidth = 2     -- the number of spaces inserted for each indentation
vim.opt.smartindent = true -- Autoindent new lines
-- vim.opt.shiftwidth = 2             -- Shift 2 spaces when tabopt
-- vim.opt.tabstop = 2                -- 1 tab == 2 spaces

-----------------------------------------------------------
-- Editor
-----------------------------------------------------------
vim.opt.autowrite = true          -- Enable auto write
vim.opt.confirm = true            -- Confirm to save changes before exiting modified buffer
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.hlsearch = true           -- highlight all matches on previous search pattern
vim.opt.incsearch = true
vim.opt.showmatch = true          -- Highlight matching parenthesis
vim.opt.smartcase = true          -- Ignore lowercase for the whole pattern
vim.opt.ignorecase = true         -- ignore case in search patterns
vim.opt.spelllang = { "en" }
vim.opt.foldmethod = 'marker'     -- Enable folding (default 'foldmarker')
vim.opt.fileencoding = "utf-8"    -- the encoding written to a file
-- vim.opt.linebreak = true          -- Wrap on word boundary

-----------------------------------------------------------
-- Buckup, Undo
-----------------------------------------------------------
-- vim.opt.swapfile = false    -- creates a swapfile
vim.opt.undofile = true     -- enable persistent undo
vim.opt.undolevels = 1000
-- vim.opt.backup = false      -- creates a backup file
-- vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.updatetime = 200    -- Save swap file and trigger CursorHold
vim.opt.conceallevel = 3    -- so that `` is visible in markdown files
-- vim.opt.undodir = os.getenv("HOME") .. "./nvim/undodir"

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
vim.opt.hidden = true -- Enable background buffers
-- vim.opt.history = 100 -- Remember N lines in history
-- vim.opt.synmaxcol = 240               -- Max column for syntax highlight
-- vim.opt.updatetime = 100              -- ms to wait for trigger an event

-- stylua: ignore end
