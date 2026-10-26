return {
    "kamykn/spelunker.vim",
    -- Set before the plugin loads, since its plugin file reads some of these
    init = function()
        vim.g.enable_spelunker_vim = 1
        vim.g.spelunker_target_min_char_len = 3
        vim.g.spelunker_max_suggest_words = 10
        vim.g.spelunker_disable_uri_checking = 1
        vim.g.spelunker_disable_acronym_checking = 1
        -- Only check the words on screen (on CursorHold) instead of the whole buffer on every
        -- BufWinEnter and save, which is slow on long files
        vim.g.spelunker_check_type = 2
    end,
    config = function()
        -- remap: the Z* keys are the plugin's own mappings
        vim.keymap.set("n", "<leader>zg", "Zg", { remap = true, desc = "Add word to dictionary" })
        vim.keymap.set("n", "<leader>zl", "Zl", { remap = true, desc = "List corrections for misspelling" })
        vim.keymap.set("n", "<leader>zw", "Zw", { remap = true, desc = "Add word to misspelled words" })
        vim.keymap.set("n", "<leader>zug", "Zug", { remap = true, desc = "Undo dictionary addition of word" })
        vim.keymap.set("n", "<leader>zuw", "Zuw", { remap = true, desc = "Undo misspelled word addition" })
    end,
}
