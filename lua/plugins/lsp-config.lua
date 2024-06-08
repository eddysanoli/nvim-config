return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup()
        end,
    },
    {
        "neovim/nvim-lspconfig",
    },
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        config = function()
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_lspconfig()

            lsp_zero.on_attach(function(client, bufnr)
                lsp_zero.default_keymaps({ buffer = bufnr })
            end)

            require("mason").setup({})
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "bashls",
                    "cssls",
                    "dockerls",
                    "docker_compose_language_service",
                    "dotls",
                    "intelephense",
                    "pyright",
                    "html",
                    "jsonls",
                    "tsserver",
                    "vimls",
                    "yamlls",
                },
                handlers = {
                    function(server_name)
                        require("lspconfig")[server_name].setup({})
                    end,
                },
            })

            -- Add mapping for code actions
            -- For more mappings see this: https://lsp-zero.netlify.app/v3.x/reference/lua-api.html#lsp-actions
            vim.keymap.set("n", "<leader>ca", function()
                vim.lsp.buf.code_action()
            end, { desc = "Show code actions" })
            vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", { buffer = bufnr, desc = "Show references" })
        end,
    },
}
