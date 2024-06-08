return {
    "mbbill/undotree",
    config = function()
        vim.keymap.set("n", "<leader>ut", vim.cmd.UndotreeToggle, {})

        -- Add this to add support for undotree in windows
        -- Based on this: https://www.reddit.com/r/neovim/comments/18o8ag3
        vim.g.undotree_DiffCommand = "FC"
    end,
}
