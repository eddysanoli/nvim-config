return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("neo-tree").setup({
            use_libuv_file_watcher = false,
            source_selector = {
                winbar = true,
                statusline = true,
            },
            window = {
                mappings = {
                    ["P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = true } },
                },
            },
            filesystem = {
                filtered_items = {
                    -- Display hidden items as "faded" instead of grouping them as (X Hidden Items)
                    visible = true,
                },
            },
        })

        vim.keymap.set("n", "<C-b>", ":Neotree filesystem toggle left<CR>", { desc = "Open side file tree explorer" })
        vim.keymap.set(
            "n",
            "<leader>ftl",
            ":Neotree filesystem toggle left<CR>",
            { desc = "Open file tree explorer on the left" }
        )
        vim.keymap.set(
            "n",
            "<leader>ftr",
            ":Neotree filesystem toggle left<CR>",
            { desc = "Open file tree explorer on the right" }
        )
        vim.keymap.set(
            "n",
            "<leader>gs",
            ":Neotree float git_status<CR>",
            { desc = "Open git status in a floating window" }
        )
    end,
}
