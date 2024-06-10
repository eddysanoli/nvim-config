return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                ui = {
                    border = "rounded",
                },
            })
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
            lsp_zero.on_attach(function(_, bufnr)
                lsp_zero.default_keymaps({ buffer = bufnr })
            end)

            require("mason").setup({})
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "bashls",
                    "cssls",
                    "dotls",
                    "intelephense",
                    "html",
                    "tsserver",
                    "vimls",

                    -- Docker
                    "dockerls",
                    "docker_compose_language_service",

                    -- Markup Languages
                    "jsonls",
                    "yamlls",
                    "taplo",

                    -- Python
                    "ruff",
                    "pylsp",
                },
                handlers = {
                    function(server_name)
                        local server = require("lspconfig")[server_name]
                        if server_name == "pylsp" then
                            server.setup({
                                settings = {
                                    pylsp = {
                                        plugins = {
                                            ruff = {
                                                enabled = true,
                                                formatEnabled = true,
                                                lineLength = 91,
                                            },
                                            pycodestyle = { enabled = false },
                                            pyflakes = { enabled = false },
                                            mccabe = { enabled = false },
                                            autopep8 = { enabled = false },
                                            yapf = { enabled = false },
                                        },
                                    },
                                },
                            })
                            return
                        else
                            server.setup({})
                        end
                    end,
                },
            })

            -- Add mapping for code actions
            -- For more mappings see this: https://lsp-zero.netlify.app/v3.x/reference/lua-api.html#lsp-actions
            vim.keymap.set("n", "<leader>ca", function()
                vim.lsp.buf.code_action()
            end, { desc = "Show code actions" })

            local bufnr = vim.fn.bufnr("%")
            vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", { buffer = bufnr, desc = "Show references" })
        end,
    },
}
