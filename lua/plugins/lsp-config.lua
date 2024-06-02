return {
    {
        "williamboman/mason.nvim",
        config = function ()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function ()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls", "tsserver", "rust_analyzer", "terraformls",
                    "tailwindcss", "intelephense", "eslint",
                    "dockerls", "docker_compose_language_service", "bashls"
                }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function ()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            local lspconfig = require("lspconfig")

            lspconfig.lua_ls.setup({ capabilities = capabilities })
            lspconfig.tsserver.setup({ capabilities = capabilities})
            lspconfig.rust_analyzer.setup({ capabilities = capabilities})
            lspconfig.terraformls.setup({ capabilities = capabilities })
            lspconfig.tailwindcss.setup({ capabilities = capabilities })
            lspconfig.intelephense.setup({ capabilities = capabilities })
            lspconfig.eslint.setup({ capabilities = capabilities })
            lspconfig.dockerls.setup({ capabilities = capabilities })
            lspconfig.docker_compose_language_service.setup({ capabilities = capabilities })
            lspconfig.bashls.setup({ capabilities = capabilities })

            vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, {})
        end
    }
}
