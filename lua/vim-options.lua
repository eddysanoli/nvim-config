vim.o.readonly = false
vim.opt.smartindent = true

-- Enable true color support. Needed for bufferline
vim.opt.termguicolors = true

-- Faster updates
vim.opt.updatetime = 50

-- Leader key
vim.g.mapleader = " "

-- 4 Space indents
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- No backups or swap files
vim.opt.backup = false
vim.opt.swapfile = false

-- Enable persistent undo
vim.opt.undofile = true

-- Search highlighting
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Disable line wrapping
vim.wo.wrap = false

-- Enable line numbers with relative numbering
vim.wo.number = true
vim.wo.relativenumber = true

-- Make the clipboard the recipient of all yanked data
vim.o.clipboard = "unnamedplus"

-- When I scroll down I want to see at least 8 lines at the bottom
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- Python Settings
vim.g.python_host_prog = 'C:\\Users\\eddys\\.pyenv\\pyenv-win\\versions\\3.10.5\\python3.exe'
vim.g.python3_host_prog = 'C:\\Users\\eddys\\.pyenv\\pyenv-win\\versions\\3.10.5\\python3.exe'

-- Spell checking
vim.opt.spell = false
vim.opt_local.spell = false
vim.opt.spelllang = { "en_us" }

-- Setup for scope.lua session support
vim.opt.sessionoptions = {
    "buffers",
    "tabpages",
    "globals",
}

-- Disable spell checking for terminal buffers
vim.cmd [[
    autocmd TermOpen * setlocal nospell
]]

-- Folds
vim.opt.foldcolumn = "1"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
