return {
    "Bekaboo/dropbar.nvim",
    -- optional, but required for fuzzy finder support
    dependencies = {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
    },
    config = function()
        local dropbar_api = require("dropbar.api")
        require("dropbar").setup({
            sources = {
                lsp = {
                    max_depth = 2,
                },
                treesitter = {
                    max_depth = 2,
                },
                path = {
                    max_depth = 3,
                },
                markdown = {
                    max_depth = 3,
                },
                terminal = {
                    show_current = false,
                    icon = "",
                    name = function()
                        return nil
                    end
                },
            },
            bar = {
                hover = true,
                padding = {
                    left = 2,
                    right = 2,
                }
            }
        })

        vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
        vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
        vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
    end,
}
