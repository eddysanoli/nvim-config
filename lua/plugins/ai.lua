-- AI: Copilot suggestions + CodeCompanion chat (see "AI Setup" in the Readme)
return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		opts = {
			suggestion = {
				auto_trigger = true,
				keymap = {
					accept = false, -- <Tab>, handled in the blink.cmp spec below
					accept_word = "<M-w>",
					accept_line = "<M-l>",
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-]>",
				},
			},
			panel = { enabled = false },
			filetypes = { bigfile = false },
		},
	},
	{
		"olimorris/codecompanion.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
		opts = {
			adapters = {
				http = {
					anthropic = function()
						return require("codecompanion.adapters").extend("anthropic", {
							schema = { model = { default = "claude-opus-5-5" } },
						})
					end,
				},
			},
			interactions = {
				-- Claude Code (subscription) > Anthropic API > Copilot. Change it in a chat with `ga`
				chat = {
					adapter = vim.env.CLAUDE_CODE_OAUTH_TOKEN and "claude_code"
						or vim.env.ANTHROPIC_API_KEY and "anthropic"
						or "copilot",
					sessions = { autosave = true },
					tools = {
						-- Run without asking in Auto mode. Chained commands (; & | $( ) always ask
						["run_command"] = {
							opts = {
								safe_commands = {
									"git status", "git diff", "git log", "git show", "git branch", "git blame",
									"ls", "pwd", "rg",
								},
							},
						},
					},
				},
				inline = { adapter = "copilot" },
			},
			-- Chat window: rounded border, title in the top bar, context folded
			display = {
				chat = {
					fold_context = true,
					title = { position = "winbar" },
					window = { border = "rounded" },
					floating_window = { border = "rounded" },
				},
			},
			prompt_library = {
				-- Chat with the built-in agent tools. Only used when Claude Code isn't set up (see <leader>ag)
				["Agent"] = {
					interaction = "chat",
					description = "Agent that can read, edit and run code (Auto approval mode)",
					opts = { alias = "agent", approval_mode = "auto" },
					tools = { "agent" },
					rules = { "default" }, -- CLAUDE.md, AGENTS.md, copilot-instructions.md...
					prompts = {},
				},
			},
		},
		cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions", "CodeCompanionCmd" },
		keys = {
			{ "<leader>aa", "<cmd>CodeCompanionChat Toggle<CR>", mode = { "n", "x" }, desc = "CodeCompanion - Toggle chat" },
			{
				"<leader>ag",
				function()
					if vim.env.CLAUDE_CODE_OAUTH_TOKEN then
						require("codecompanion").chat({ params = { adapter = "claude_code" }, approval_mode = "auto" })
					else
						require("codecompanion").prompt("agent")
					end
				end,
				mode = { "n", "x" },
				desc = "CodeCompanion - Agent chat",
			},
			{ "<leader>ap", "<cmd>CodeCompanionActions<CR>", mode = { "n", "x" }, desc = "CodeCompanion - Action palette" },
			{ "<leader>ai", ":CodeCompanion ", mode = { "n", "x" }, desc = "CodeCompanion - Inline prompt" },
			{ "<leader>ad", "<cmd>CodeCompanionChat Add<CR>", mode = "x", desc = "CodeCompanion - Add selection to chat" },
			{
				"<leader>al",
				function()
					require("codecompanion").sessions()
				end,
				desc = "CodeCompanion - List saved sessions",
			},
		},
	},
	-- Merged into the blink.cmp spec in completions.lua: <Tab> accepts a Copilot suggestion first
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
