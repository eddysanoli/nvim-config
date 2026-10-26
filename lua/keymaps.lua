-- =============================
-- CHANGE TO NORMAL MODE
-- =============================

vim.keymap.set("i", "jk", "<Esc>")

-- =============================
-- INDENT AND DE-INDENT
-- =============================

-- Visual mode only. A normal-mode <Tab> mapping would also replace <C-i> (jump forward),
-- because most terminals send the same key for both. In normal mode use >> and <<
vim.keymap.set("v", "<Tab>", ">gv")
vim.keymap.set("v", "<S-Tab>", "<gv")

-- =============================
-- TERMINAL
-- =============================

-- For every terminal buffer. <C-w> is left alone so it still deletes the previous word in the shell
vim.api.nvim_create_autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup("UserTerminalKeymaps", { clear = true }),
    pattern = "term://*",
    callback = function(ev)
        local opts = { buffer = ev.buf }
        vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)
        vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
        vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
    end,
})
