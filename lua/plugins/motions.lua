return {
	"chaoren/vim-wordmotion", -- When using word motions, camel case and underscored words are treated accordingly
	"tpope/vim-surround", -- Surround text with brackets, quotes, etc.
	"easymotion/vim-easymotion", -- Show visible landmarks for easier navigation
	"tpope/vim-speeddating", -- Increment dates, times, and more using CTRL-A and CTRL-X
    "cohama/lexima.vim", -- Auto close brackets, quotes, etc.
	{
		"ggandor/leap.nvim", -- Jump to a new location using two characters. Analog to the "f" motion
		dependencies = {
			"tpope/vim-repeat",
		},
		config = function()
			vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
			vim.keymap.set({ "n", "x", "o" }, "sb", "<Plug>(leap-backward)")
			vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-from-window)")
		end,
	},
}
