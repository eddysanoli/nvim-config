return {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    init = function()
        -- Keep Copilot off big files. copilot.vim attaches on FileType before the bigfile setup below
        -- runs, so this has to go by filetype instead of a buffer variable
        vim.g.copilot_filetypes = vim.tbl_extend("force", vim.g.copilot_filetypes or {}, { bigfile = false })
    end,
    opts = {
        -- Files over 1.5MB, or with very long lines (minified files), get the filetype "bigfile".
        -- That alone stops treesitter, LSP, none-ls and filetype plugins from attaching
        bigfile = {
            enabled = true,
            size = 1.5 * 1024 * 1024,
            line_length = 1000,

            -- The first part matches the snacks default. The rest turns off the plugins that
            -- attach to every buffer regardless of filetype. ibl, ufo and gitsigns skip
            -- "bigfile" in their own configs
            setup = function(ctx)
                if vim.fn.exists(":NoMatchParen") ~= 0 then
                    vim.cmd([[NoMatchParen]])
                end
                Snacks.util.wo(0, { foldmethod = "manual", statuscolumn = "", conceallevel = 0 })
                vim.b.completion = false
                vim.b.minianimate_disable = true
                vim.b.minihipatterns_disable = true
                vim.schedule(function()
                    if vim.api.nvim_buf_is_valid(ctx.buf) then
                        vim.bo[ctx.buf].syntax = ctx.ft
                    end
                end)

                -- Only highlight the start of long lines with the regex syntax that replaces treesitter
                vim.bo[ctx.buf].synmaxcol = 200
                -- Don't write an undo file for every save
                vim.bo[ctx.buf].undofile = false
                vim.b[ctx.buf].enable_spelunker_vim = 0
            end,
        },
    },
}
