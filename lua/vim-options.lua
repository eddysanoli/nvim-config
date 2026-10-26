-- No plugins use the Python provider. Probing for it fails on the pyenv-win shims and
-- aborts the FileType autocmds for Python buffers, which stops the LSP servers from attaching
vim.g.loaded_python3_provider = 0

local augroup = vim.api.nvim_create_augroup("UserOptions", { clear = true })

vim.opt.smartindent = true

-- Enable 24bit color support. Needed for bufferline and notify
vim.opt.termguicolors = true

-- Delay before CursorHold fires (used by lightbulb and gitsigns blame)
vim.opt.updatetime = 250

-- Rounded borders on every floating window (hover, signature help, diagnostics, plugin popups)
vim.o.winborder = "rounded"

-- Leader key
vim.g.mapleader = " "

-- Enable mouse support
vim.opt.mouse = "a"

-- Reload buffer if file changes on disk. Checked when Neovim regains focus or a buffer is entered
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
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

-- Spell checking (built in). With treesitter highlighting only comments and strings are checked
vim.opt.spelllang = { "en_us" }
vim.opt.spelloptions = "camel" -- Check each part of camelCase words separately
vim.opt.spellcapcheck = "" -- Don't flag lowercase words at the start of a "sentence" (noisy in code)
vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"

-- Only in normal file buffers, not in dashboards, file trees, pickers or terminals. Big files skip it too
vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    callback = function(ev)
        if vim.bo[ev.buf].buftype == "" and ev.match ~= "bigfile" then
            vim.opt_local.spell = true
        end
    end,
})

-- The compiled word list (.spl) isn't kept in git. Rebuild it when it's missing or older than
-- the word list (.add), e.g. after pulling words added on another machine
do
    local add = vim.o.spellfile
    local add_stat, spl_stat = vim.uv.fs_stat(add), vim.uv.fs_stat(add .. ".spl")
    if add_stat and (not spl_stat or spl_stat.mtime.sec < add_stat.mtime.sec) then
        vim.cmd("silent mkspell! " .. vim.fn.fnameescape(add))
    end
end

-- Neovim never trims lsp.log (it reached 275 MB). Empty it at startup once it passes 5 MB,
-- before any language server has started writing to it
do
    local lsp_log = vim.fs.joinpath(vim.fn.stdpath("log"), "lsp.log")
    local stat = vim.uv.fs_stat(lsp_log)
    if stat and stat.size > 5 * 1024 * 1024 then
        local fd = vim.uv.fs_open(lsp_log, "w", 420)
        if fd then
            vim.uv.fs_close(fd)
        end
    end
end

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

-- Folds. Native folding from treesitter; lsp-config.lua switches a window to the language server's
-- folds when it supports them. Big files fall back to manual folds (see snacks.lua)
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = "" -- Show the first line of a fold with its normal highlighting
vim.opt.foldcolumn = "1"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
