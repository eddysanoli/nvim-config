return {
	{ "chaoren/vim-wordmotion", event = "VeryLazy" }, -- When using word motions, camel case and underscored words are treated accordingly
	{ "tpope/vim-surround", event = "VeryLazy" }, -- Surround text with brackets, quotes, etc.
	{ "tpope/vim-speeddating", event = "VeryLazy" }, -- Increment dates, times, and more using CTRL-A and CTRL-X
	{ "cohama/lexima.vim", event = "InsertEnter" }, -- Auto close brackets, quotes, etc.
	{
		"ggandor/leap.nvim", -- Jump to a new location using two characters. Analog to the "f" motion
		dependencies = {
			"tpope/vim-repeat",
		},
		keys = {
			{ "s", "<Plug>(leap-forward)", mode = { "n", "x", "o" }, desc = "Leap forward" },
			-- Not in visual mode, where S is vim-surround's "surround selection"
			{ "S", "<Plug>(leap-backward)", mode = { "n", "o" }, desc = "Leap backward" },
			{ "gs", "<Plug>(leap-from-window)", mode = { "n", "x", "o" }, desc = "Leap from window" },
		},
	},
}
