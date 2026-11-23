-- All AI plugins: Copilot suggestions and CodeCompanion
return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		opts = {
			-- Ghost text while typing. <Tab> accepts it (see the blink.cmp spec below, since blink.cmp owns <Tab>)
			suggestion = {
				auto_trigger = true,
				keymap = {
					accept = false,
					accept_word = "<M-w>",
					accept_line = "<M-l>",
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-]>",
				},
			},
			panel = { enabled = false },
			-- Keep Copilot off big files (snacks.nvim gives them the "bigfile" filetype)
			filetypes = { bigfile = false },
		},
	},
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		-- Uses the Copilot adapter by default, which reuses copilot.lua's GitHub login
		opts = {},
		cmd = {
			"CodeCompanion",
			"CodeCompanionChat",
			"CodeCompanionActions",
			"CodeCompanionCmd",
		},
		keys = {
			{ "<leader>aa", "<cmd>CodeCompanionChat Toggle<CR>", mode = { "n", "x" }, desc = "CodeCompanion - Toggle chat" },
			{ "<leader>ap", "<cmd>CodeCompanionActions<CR>", mode = { "n", "x" }, desc = "CodeCompanion - Action palette" },
			{ "<leader>ai", ":CodeCompanion ", mode = { "n", "x" }, desc = "CodeCompanion - Inline prompt" },
			{ "<leader>ad", "<cmd>CodeCompanionChat Add<CR>", mode = "x", desc = "CodeCompanion - Add selection to chat" },
		},
	},
	-- Merged by lazy.nvim into the main blink.cmp spec in completions.lua.
	-- <Tab> accepts a Copilot suggestion if one is showing, otherwise keeps blink's default behavior
	{
		"saghen/blink.cmp",
		opts = {
			keymap = {
				["<Tab>"] = {
					function()
						local ok, suggestion = pcall(require, "copilot.suggestion")
						if ok and suggestion.is_visible() then
							suggestion.accept()
							return true
						end
					end,
					"snippet_forward",
					"fallback",
				},
			},
		},
	},
}
