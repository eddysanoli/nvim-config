return {
	"Bekaboo/dropbar.nvim",
	-- optional, but required for fuzzy finder support
	dependencies = {
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
    opts = {
        sources = {
            path = {
                max_depth = 4,
            },
            lsp = {
                max_depth = 2,
            },
            treesitter = {
                max_depth = 2,
            },
        }
    },
	config = function()
		local dropbar_api = require("dropbar.api")
		vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
		vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
		vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
	end,
}
