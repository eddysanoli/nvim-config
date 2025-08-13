return {
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "neovim/nvim-lspconfig" },
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        dependencies = {
            'saghen/blink.cmp',
        },
        config = function()
            local capabilities = require("blink.cmp").get_lsp_capabilities()
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_lspconfig()

            lsp_zero.on_attach(function(_, bufnr)
                lsp_zero.default_keymaps({ buffer = bufnr })
            end)

            require("mason").setup({
                ui = {
                    border = "rounded",
                },
            })
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "bashls",
                    "cssls",
                    "dotls",
                    "intelephense",
                    "html",
                    "vimls",

                    -- Rust
                    "rust_analyzer",

                    -- Docker
                    "dockerls",
                    "docker_compose_language_service",

                    -- Markup Languages
                    "jsonls",
                    "yamlls",
                    "taplo",

                    -- Python
                    "ruff",
                    "basedpyright",
                },
                handlers = {
                    function(server_name)
                        local server = require("lspconfig")[server_name]

                        if server_name == "solargraph" then
                            local util = require("lspconfig.util")
                            server.setup({
                                capabilities = capabilities,
                                settings = {
                                    Solargraph = {
                                        root_dir = util.root_pattern("Gemfile", ".git")(fname)
                                            or util.path.dirname(vim.api.nvim_buf_get_name(0)),
                                    },
                                },
                            })
                            return
                        elseif server_name == "rust_analyzer" then
                            server.setup({
                                capabilities = capabilities,
                                settings = {
                                    ["rust-analyzer"] = {
                                        diagnostics = {
                                            enable = true,
                                            disabled = { "unresolved-imports" },
                                        },
                                    },
                                },
                            })
                            return
                        elseif server_name == "basedpyright" then
                            server.setup({
                                capabilities = capabilities,
                                settings = {
                                    basedpyright = {
                                        disableTaggedHints = true,
                                        typeCheckingMode = "strict",
                                    },
                                },
                            })
                            if vim.lsp.inlay_hint then
                                vim.lsp.inlay_hint.enable(false, { 0 })
                            end
                            return
                        elseif server_name == "ruff" then
                            server.setup({
                                capabilities = capabilities,
                                settings = {
                                    ruff = {
                                        enable = true,
                                        extendSelect = { "I", "F" }, -- Enable all rules
                                        select = { "E", "W" }, -- Enable specific rules
                                    },
                                },
                            })
                            return
                        else
                            server.setup({
                                capabilities = capabilities,
                            })
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
