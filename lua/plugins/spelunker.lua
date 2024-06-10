return {
    "kamykn/spelunker.vim",
    config = function()
        vim.g.enable_spelunker_vim = 1
        vim.g.spelunker_target_min_char_len = 3
        vim.g.spelunker_max_suggest_words = 10
        vim.g.spelunker_disable_uri_checking = 1
        vim.g.spelunker_disable_acronym_checking = 1

        vim.api.nvim_set_keymap("n", "<leader>zg", "Zg", { desc = "Add word to dictionary" })
        vim.api.nvim_set_keymap("n", "<leader>zl", "Zl", { desc = "List corrections for misspelling" })
        vim.api.nvim_set_keymap("n", "<leader>zw", "Zw", { desc = "Add word to misspelled words" })
        vim.api.nvim_set_keymap("n", "<leader>zug", "Zug", { desc = "Undo dictionary addition of word" })
        vim.api.nvim_set_keymap("n", "<leader>zuw", "Zuw", { desc = "Undo misspelled word addition" })
    end,
}
