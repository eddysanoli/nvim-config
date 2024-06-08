return {
    "tiagovla/scope.nvim",
    config = function()
        require("scope").setup({})
        require("telescope").load_extension("scope")

        vim.keymap.set(
            "n",
            "<leader>sbl",
            "<cmd>Telescope scope buffers<cr>",
            { silent = true, desc = "Search buffers" }
        )
    end,
}
