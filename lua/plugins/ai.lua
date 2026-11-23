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
		opts = {
			adapters = {
				http = {
					-- Claude through the Anthropic API. Reads the key from the ANTHROPIC_API_KEY environment variable
					anthropic = function()
						return require("codecompanion.adapters").extend("anthropic", {
							schema = { model = { default = "claude-opus-5-5" } },
						})
					end,
				},
			},
			-- Chat uses Claude when an API key is set, otherwise Copilot (which reuses copilot.lua's GitHub login).
			-- Inline edits stay on Copilot. Switch adapter/model inside a chat with `ga`
			interactions = {
				chat = {
					adapter = vim.env.ANTHROPIC_API_KEY and "anthropic" or "copilot",
					tools = {
						-- In Auto mode these run without asking. They're matched by prefix ("git log --oneline"
						-- counts as "git log"), and anything chained with ; & | or $( always asks
						["run_command"] = {
							opts = {
								safe_commands = {
									"git status",
									"git diff",
									"git log",
									"git show",
									"git branch",
									"git blame",
									"ls",
									"pwd",
									"rg",
								},
							},
						},
					},
				},
				inline = { adapter = "copilot" },
			},
			prompt_library = {
				-- A chat with the "agent" tool group: it can search, read, edit and create files, check
				-- diagnostics and run commands. Starts in Auto mode: reads, searches and edits go ahead without
				-- asking (no diff to accept, so review with git afterwards); deleting files and commands not in
				-- safe_commands still ask. Switch to Ask mode to review each edit as a diff.
				-- Inside the chat, `gty` switches between Ask / Auto / YOLO and `gtx` resets approvals
				["Agent"] = {
					interaction = "chat",
					description = "Agent that can read, edit and run code (Auto approval mode)",
					opts = {
						alias = "agent",
						approval_mode = "auto",
						intro_message = "Agent mode: I can search, read and edit files and run commands. gty changes the approval mode",
					},
					tools = { "agent" },
					-- Prompt library chats load no rules unless asked. "default" is CLAUDE.md, AGENTS.md,
					-- .cursorrules, copilot-instructions.md and similar files in the project
					rules = { "default" },
					prompts = {},
				},
			},
		},
		cmd = {
			"CodeCompanion",
			"CodeCompanionChat",
			"CodeCompanionActions",
			"CodeCompanionCmd",
		},
		keys = {
			{ "<leader>aa", "<cmd>CodeCompanionChat Toggle<CR>", mode = { "n", "x" }, desc = "CodeCompanion - Toggle chat" },
			{
				"<leader>ag",
				function()
					require("codecompanion").prompt("agent")
				end,
				mode = { "n", "x" },
				desc = "CodeCompanion - Agent chat",
			},
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
