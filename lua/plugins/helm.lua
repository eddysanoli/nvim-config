return {
    "towolf/vim-helm",
    config = function()
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
