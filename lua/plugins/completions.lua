return {
    {
        "hrsh7th/cmp-nvim-lsp",
    },
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "f3fora/cmp-spell",
            "hrsh7th/cmp-omni",
            "KadoBOT/cmp-plugins",
            "prabirshrestha/vim-lsp",
            "dmitmel/cmp-vim-lsp",
            "FelipeLema/cmp-async-path",
            "hrsh7th/cmp-buffer",
        },
        requires = {
            {
                "KadoBOT/cmp-plugins",
                config = function()
                    require("cmp-plugins").setup({
                        files = { ".*\\.lua" }, -- default
                    })
                end,
            },
        },
        config = function()
            local cmp = require("cmp")
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({

                -- Tells nvim-cmp to use luasnip as the snippet expansion function
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },

                -- How the completion window looks
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },

                -- Bindings for moving through completions
                mapping = cmp.mapping.preset.insert({
                    ["<C-k>"] = cmp.mapping.select_prev_item(),
                    ["<C-j>"] = cmp.mapping.select_next_item(),
                    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-2), { "i", "c" }),
                    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(2), { "i", "c" }),
                    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                    ["<C-y>"] = cmp.config.disable,
                    ["<C-e>"] = cmp.mapping({
                        i = cmp.mapping.abort(),
                        c = cmp.mapping.close(),
                    }),
                    ["<CR>"] = cmp.mapping.confirm(),
                }),

                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "plugins" },
                    { name = "vim_lsp" },
                    { name = 'async_path' },
                    {
                        name = "lazydev",
                        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
                    },
                }, {
                    { name = "buffer" },
                    {
                        name = "omni",
                        option = {
                            disable_omnifuncs = { "v:lua.vim.lsp.omnifunc" },
                        },
                    },
                }),
            })
        end,
    },
}
