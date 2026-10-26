return {
    "kosayoda/nvim-lightbulb",
    config = function()
        require("nvim-lightbulb").setup({
            -- updatetime = -1 keeps lightbulb from overriding the value in vim-options.lua
            autocmd = { enabled = true, updatetime = -1 },
            sign = { enabled = true },
            virtual_text = { enabled = false },
        })
    end,
}
