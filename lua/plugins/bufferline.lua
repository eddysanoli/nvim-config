return {
    "akinsho/bufferline.nvim",
    version = "v4.6.1",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        local bufferline = require("bufferline")
        bufferline.setup({
            options = {
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "File Explorer",
                        separator = true,
                        text_align = "left",
                    },
                },
            },
        })

        -- Keymaps for moving between buffers
        vim.keymap.set(
            "n",
            "<leader>gt",
            "<cmd>BufferLineCycleNext<cr>",
            { silent = true, desc = "Move to next buffer" }
        )
        vim.keymap.set(
            "n",
            "<leader>gT",
            "<cmd>BufferLineCyclePrev<cr>",
            { silent = true, desc = "Move to previous buffer" }
        )

        -- Close current buffer
        -- Focus on a new buffer that is not the tree by toggling the tree, deleting and then reopening
        vim.keymap.set("n", "<leader>bc", function()
            local manager = require("neo-tree.sources.manager")
            local renderer = require("neo-tree.ui.renderer")
            local state = manager.get_state("filesystem")
            local window_exists = renderer.window_exists(state)

            if window_exists then
                vim.cmd("Neotree filesystem toggle left")
            end

            vim.cmd("bd")

            if window_exists then
                vim.cmd("Neotree filesystem toggle left")
            end
        end, { silent = true, desc = "Close current buffer and toggle tree" })
    end,
}
