return {
    "linrongbin16/lsp-progress.nvim",
    event = "LspAttach", -- Also loaded by the lualine component that requires it
    config = function()
        require("lsp-progress").setup()
    end,
}
