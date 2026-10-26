return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    event = "VeryLazy",
    config = function()
        require("lualine").setup({
            options = { theme = require("theme").lualine },
            sections = {
                lualine_b = {
                    "diff",
                    "diagnostics",
                    "grapple",
                },
                lualine_c = {
                    function()
                        return require("lsp-progress").progress()
                    end,
                },
            },
            extensions = {
                "fugitive",
                "neo-tree",
                "toggleterm",
                "trouble",
                "mason",
                "lazy",
                "nvim-dap-ui",
                {
                    sections = {
                        lualine_a = {
                            function()
                                return "Cheatsheet"
                            end,
                        },
                    },
                    filetypes = { "nvcheatsheet" },
                },
            },
        })

        vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
        vim.api.nvim_create_autocmd("User", {
            group = "lualine_augroup",
            pattern = "LspProgressStatusUpdated",
            callback = require("lualine").refresh,
        })
    end,
}
