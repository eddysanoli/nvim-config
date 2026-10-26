return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "saghen/blink.cmp", -- Registers its completion capabilities for all servers on its own
        },
        config = function()
            -- =============================
            -- SERVER SETTINGS
            -- =============================

            -- Applies to every server. Merged with the defaults from nvim-lspconfig and blink.cmp
            vim.lsp.config("*", {
                capabilities = require("lsp-file-operations").default_capabilities(),
            })

            vim.lsp.config("gopls", {
                settings = {
                    gopls = {
                        completeUnimported = true,
                        usePlaceholders = true,
                        analyses = {
                            unusedparams = true,
                        },
                    },
                },
            })

            vim.lsp.config("rust_analyzer", {
                settings = {
                    ["rust-analyzer"] = {
                        diagnostics = {
                            enable = true,
                            disabled = { "unresolved-imports" },
                        },
                    },
                },
            })

            vim.lsp.config("basedpyright", {
                settings = {
                    basedpyright = {
                        disableTaggedHints = true,
                        analysis = {
                            useTypingExtensions = true,
                        },
                    },
                },
            })

            -- Ruff reads its settings from init_options instead of settings
            vim.lsp.config("ruff", {
                init_options = {
                    settings = {
                        configurationPreference = "filesystemFirst",
                        lint = {
                            enable = true,
                            select = { "E", "W" },
                            extendSelect = { "I", "F" },
                        },
                        format = {
                            enable = true,
                        },
                    },
                },
            })

            -- =============================
            -- INSTALL AND ENABLE SERVERS
            -- =============================

            require("mason").setup({
                ui = {
                    border = "rounded",
                },
                ensure_installed = {
                    -- Golang
                    "gofumpt",
                    "goimports-reviser",
                    "golines",
                },
            })

            -- Every server installed through Mason gets enabled automatically (vim.lsp.enable)
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "bashls",
                    "cssls",
                    "dotls",
                    "intelephense",
                    "html",
                    "vimls",

                    -- Go
                    "gopls",

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
            })

            -- =============================
            -- KEYMAPS
            -- =============================

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
                callback = function(ev)
                    local function map(mode, lhs, rhs, desc)
                        vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = desc })
                    end

                    -- Same mappings lsp-zero used to provide. K, [d and ]d are Neovim defaults
                    map("n", "gd", vim.lsp.buf.definition, "Go to definition")
                    map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
                    map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
                    map("n", "go", vim.lsp.buf.type_definition, "Go to type definition")
                    map("n", "gs", vim.lsp.buf.signature_help, "Show function signature")
                    map("n", "gl", vim.diagnostic.open_float, "Show diagnostic")
                    map("n", "<F2>", vim.lsp.buf.rename, "Rename symbol")
                    map({ "n", "x" }, "<F3>", function()
                        vim.lsp.buf.format({ async = true })
                    end, "Format file")
                    map({ "n", "x" }, "<F4>", vim.lsp.buf.code_action, "Execute code action")
                    map("n", "<leader>ca", vim.lsp.buf.code_action, "Show code actions")

                    -- nowait: don't pause for Neovim's default grr/gra/grn/gri mappings
                    vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", {
                        buffer = ev.buf,
                        nowait = true,
                        desc = "Show references",
                    })

                    -- Inlay hints only for Rust
                    local client = vim.lsp.get_client_by_id(ev.data.client_id)
                    if client and client.name == "rust_analyzer" then
                        vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
                    end
                end,
            })
        end,
    },
}
