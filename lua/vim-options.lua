-- No plugins use the Python provider. Probing for it fails on the pyenv-win shims and
-- aborts the FileType autocmds for Python buffers, which stops the LSP servers from attaching
vim.g.loaded_python3_provider = 0

local augroup = vim.api.nvim_create_augroup("UserOptions", { clear = true })

vim.opt.smartindent = true

-- Enable 24bit color support. Needed for bufferline and notify
vim.opt.termguicolors = true

-- Delay before CursorHold fires (used by checktime, lightbulb, spelunker, gitsigns blame)
vim.opt.updatetime = 250

-- Leader key
vim.g.mapleader = " "

-- Enable mouse support
vim.opt.mouse = "a"

-- Reload buffer if file changes on disk
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
    group = augroup,
    command = "if mode() != 'c' | checktime | endif",
})

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
vim.opt.wrap = false

-- Only highlight the first 300 columns of a line. Very long lines (minified files) are slow to highlight
vim.opt.synmaxcol = 300

-- Enable line numbers with relative numbering
vim.opt.number = true
vim.opt.relativenumber = true

-- Make the clipboard the recipient of all yanked data. Set after startup because detecting
-- the clipboard provider on Windows slows down startup
vim.schedule(function()
    vim.opt.clipboard = "unnamedplus"
end)

-- When I scroll down I want to see at least 20 lines at the bottom
vim.opt.scrolloff = 20
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- Spell checking
vim.opt.spell = false
vim.opt.spelllang = { "en_us" }

-- Squiggly underlines for errors instead of displaying errors as virtual text
-- vim.cmd.highlight("highlight-name gui=undercurl")
vim.diagnostic.config({
    underline = true,
    virtual_text = false,
    signs = true,
    update_in_insert = false,
})

-- Quickfix
vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>", { desc = "Cycle to next quickfix item" })
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>", { desc = "Cycle to previous quickfix item" })
vim.keymap.set("n", "<leader>qo", "<cmd>copen<CR>", { desc = "Open quickfix list" })
vim.keymap.set("n", "<leader>qc", "<cmd>cclose<CR>", { desc = "Close quickfix list" })

-- Make lines wrap (visually, not including newlines) in Markdown files
vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = "markdown",
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.textwidth = 0
        vim.opt_local.colorcolumn = ""
    end,
})

-- Setup for sessions.lua session support
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,localoptions"

-- Disable spell checking for terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
    group = augroup,
    command = "setlocal nospell",
})

-- Folds
vim.opt.foldcolumn = "1"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
