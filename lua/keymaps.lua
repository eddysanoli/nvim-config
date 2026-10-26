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
-- SPELLING
-- =============================

-- Same keys spelunker used, now for the built-in spell checker. The word list is spell/en.utf-8.add
vim.keymap.set("n", "<leader>zg", "zg", { desc = "Add word to dictionary" })
vim.keymap.set("n", "<leader>zl", "<cmd>Telescope spell_suggest<CR>", { desc = "List corrections for misspelling" })
vim.keymap.set("n", "<leader>zw", "zw", { desc = "Add word to misspelled words" })
vim.keymap.set("n", "<leader>zug", "zug", { desc = "Undo dictionary addition of word" })
vim.keymap.set("n", "<leader>zuw", "zuw", { desc = "Undo misspelled word addition" })

-- =============================
-- INCREMENTAL SELECTION
-- =============================

-- Neovim 0.12 has treesitter incremental selection built in: `an` (parent node) and `in` (child node)
-- in visual mode. These keep the keys that nvim-treesitter's master branch provided
vim.keymap.set("n", "<leader>ss", "van", { remap = true, desc = "Start incremental selection" })
vim.keymap.set("x", "<leader>si", "an", { remap = true, desc = "Increment selection to parent node" })
vim.keymap.set("x", "<leader>sd", "in", { remap = true, desc = "Decrement selection to child node" })

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
