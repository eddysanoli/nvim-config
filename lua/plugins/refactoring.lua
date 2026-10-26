-- Extract/inline variables and functions. The plugin's rewrite (Neovim 0.12.5+) dropped the API that
-- none-ls's "refactoring" code action used, so it's used through its own keymaps instead.
-- The operator keymaps (expr = true) take a motion or work on a visual selection
local function refactor(fn)
    return function()
        return require("refactoring")[fn]()
    end
end

return {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
        -- Only needed on Neovim 0.12. Neovim 0.13 has it built in
        "lewis6991/async.nvim",
    },
    cmd = "Refactor",
    keys = {
        {
            "<leader>rs",
            function()
                require("refactoring").select_refactor()
            end,
            mode = { "n", "x" },
            desc = "Select refactor",
        },
        { "<leader>re", refactor("extract_func"), mode = { "n", "x" }, expr = true, desc = "Extract function" },
        { "<leader>rv", refactor("extract_var"), mode = { "n", "x" }, expr = true, desc = "Extract variable" },
        { "<leader>ri", refactor("inline_var"), mode = { "n", "x" }, expr = true, desc = "Inline variable" },
        { "<leader>rI", refactor("inline_func"), mode = { "n", "x" }, expr = true, desc = "Inline function" },
    },
}
