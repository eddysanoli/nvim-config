return {
    {
        "cappyzawa/trim.nvim",
        cmd = { "Trim", "TrimToggle" },
        config = function()
            require("trim").setup({
                trim_on_write = false,
                highlight = false,
            })
        end,
    },
    {
        "stevearc/conform.nvim",
        cmd = "ConformInfo",
        keys = {
            {
                "<leader>fm",
                function()
                    require("conform").format({ async = true })
                end,
                mode = { "n", "x" },
                desc = "Format the current file",
            },
        },
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                -- Ruff sorts imports with the same rules as isort. The isort on PATH is a pyenv-win shim,
                -- which Neovim can't launch on Windows
                python = { "ruff_organize_imports", "ruff_format" },
                go = { "goimports-reviser", "gofumpt", "golines" },
                terraform = { "terraform_fmt" },
                ["terraform-vars"] = { "terraform_fmt" },
                javascript = { "prettier" },
                javascriptreact = { "prettier" },
                typescript = { "prettier" },
                typescriptreact = { "prettier" },
                vue = { "prettier" },
                css = { "prettier" },
                scss = { "prettier" },
                less = { "prettier" },
                html = { "prettier" },
                json = { "prettier" },
                jsonc = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
                graphql = { "prettier" },
            },
            -- Filetypes without a formatter above use their language server, if it can format
            default_format_opts = {
                lsp_format = "fallback",
            },
        },
    },
    {
        -- Only diagnostics and code actions now. Formatting is handled by conform.nvim above
        "nvimtools/none-ls.nvim",
        dependencies = {
            "nvimtools/none-ls-extras.nvim",
        },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                -- Some sources (like gitsigns code actions) apply to every filetype, so skip big files explicitly
                should_attach = function(bufnr)
                    return vim.bo[bufnr].filetype ~= "bigfile"
                end,
                sources = {
                    null_ls.builtins.code_actions.gitsigns,
                    null_ls.builtins.diagnostics.mypy.with({
                        only_local = true,
                    }),
                },
            })
        end,
    },
}
