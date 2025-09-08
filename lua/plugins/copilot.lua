return {
	{
		"github/copilot.vim",
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		build = "make tiktoken",
		dependencies = {
			{ "github/copilot.vim" },
			{ "nvim-telescope/telescope.nvim" },
			{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log wrapper
		},
		config = function()
			require("CopilotChat").setup({
				debug = true,
				show_help = true,
			})

			vim.keymap.set("n", "<leader>cco", ":CopilotChatOpen<CR>", { silent = true, desc = "Open Copilot Chat" })
			vim.keymap.set("n", "<leader>ccx", ":CopilotChatClose<CR>", { silent = true, desc = "Close Copilot Chat" })
		end,
		event = "VeryLazy",
		keys = {
			-- Show help actions with telescope
			{
				"<leader>cch",
				function()
					local actions = require("CopilotChat.actions")
					require("CopilotChat.integrations.telescope").pick(actions.help_actions())
				end,
				desc = "CopilotChat - Help actions",
			},
			-- Show prompts actions with telescope
			{
				"<leader>ccp",
				function()
					local actions = require("CopilotChat.actions")
					require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
				end,
				desc = "CopilotChat - Prompt actions",
			},
			-- Quick chat with Copilot
			{
				"<leader>ccq",
				function()
					local input = vim.fn.input("Quick Chat: ")
					if input ~= "" then
						vim.cmd("CopilotChatBuffer " .. input)
					end
				end,
				desc = "CopilotChat - Quick chat",
			},
            -- Open/close chat window
			{
				"<leader>cco",
				":CopilotChatOpen<CR>",
				desc = "CopilotChat - Open chat window",
				silent = true,
			},
			{
				"<leader>ccx",
				":CopilotChatClose<CR>",
				desc = "CopilotChat - Close chat window",
				silent = true,
			},
		},
	},
}
