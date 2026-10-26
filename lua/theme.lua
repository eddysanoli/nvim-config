-- The colorscheme, set in one place. catppuccin.lua, lualine.lua and init.lua read it from here
return {
    -- Colorscheme loaded with :colorscheme (and used by lazy.nvim while installing plugins)
    colorscheme = "catppuccin",

    -- Catppuccin flavour: "latte", "frappe", "macchiato" or "mocha"
    flavour = "mocha",

    -- Lualine theme. "catppuccin-nvim" follows whichever flavour is active
    lualine = "catppuccin-nvim",
}
