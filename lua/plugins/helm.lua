return {
    "towolf/vim-helm",
    ft = "helm",
    -- Runs at startup so the filetypes are known before the plugin loads
    init = function()
        vim.filetype.add({
            extension = {
                gotmpl = "gotmpl",
            },
            pattern = {
                [".*/templates/.*%.tpl"] = "helm",
                [".*/templates/.*%.ya?ml"] = "helm",
                ["helmfile.*%.ya?ml"] = "helm",
            },
        })
    end,
}
