return {
    {
        "cappyzawa/trim.nvim",
        config = function()
            require("trim").setup({
                trim_on_write = false,
                highlight = false,
            })
        end,
    },
    {
        "nvimtools/none-ls.nvim",
        dependencies = {
            "nvimtools/none-ls-extras.nvim",
        },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.prettier,
                    null_ls.builtins.code_actions.refactoring,
                    null_ls.builtins.code_actions.gitsigns,
                    null_ls.builtins.formatting.terraform_fmt,
                    null_ls.builtins.formatting.djhtml,
                    null_ls.builtins.diagnostics.mypy.with({
                        only_local = true,
                    }),
                    null_ls.builtins.formatting.isort.with({
                        only_local = true,
                    }),
                },
            })

            vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, { desc = "Format the current file" })
        end,
    },
}
