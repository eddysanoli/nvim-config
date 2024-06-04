return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local config = require("nvim-treesitter.configs")
        config.setup({
            auto_install = true, -- Automatically install parsers for languages treesitter doesn't know
            highlight = { enable = true },
            indent = { enable = true },
        })
    end,
}
