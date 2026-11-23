return {
	{ "chaoren/vim-wordmotion", event = "VeryLazy" }, -- When using word motions, camel case and underscored words are treated accordingly
	{ "tpope/vim-surround", event = "VeryLazy" }, -- Surround text with brackets, quotes, etc.
	{ "tpope/vim-speeddating", event = "VeryLazy" }, -- Increment dates, times, and more using CTRL-A and CTRL-X
	{ "cohama/lexima.vim", event = "InsertEnter" }, -- Auto close brackets, quotes, etc.
	{
		-- Extra text objects: brackets (b), quotes (q), arguments (a), function calls (f), tags (t)...
		-- Also works on the last textobject before the cursor (al / il)
		-- af/if/ac/ic/as stay with nvim-treesitter-textobjects, since explicit mappings win over mini.ai
		"nvim-mini/mini.ai",
		event = "VeryLazy",
		opts = {
			-- Search this many lines around the cursor for a textobject (default 50)
			n_lines = 500,
			mappings = {
				-- an / in are Neovim's built-in treesitter incremental selection (see keymaps.lua)
				around_next = "",
				inside_next = "",
			},
		},
	},
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
