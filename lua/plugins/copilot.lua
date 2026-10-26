return {
	{
		"github/copilot.vim",
		init = function()
			-- Use the language server bundled with the plugin. The default runs it through npx,
			-- which fails on Windows ("copilot-language-server" is not recognized)
			vim.g.copilot_version = false
			-- Node prints an "experimental feature" warning on every start, which ends up in lsp.log
			vim.g.copilot_node_command = { "node", "--no-warnings" }
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		build = "make tiktoken",
		dependencies = {
			{ "github/copilot.vim" },
			{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log wrapper
		},
		config = function()
			require("CopilotChat").setup({
				show_help = true,
			})
		end,
		cmd = {
			"CopilotChat",
			"CopilotChatOpen",
			"CopilotChatClose",
			"CopilotChatToggle",
			"CopilotChatModels",
			"CopilotChatPrompts",
		},
		keys = {
			-- Pick a prompt (uses vim.ui.select, which telescope-ui-select displays)
			{
				"<leader>ccp",
				"<cmd>CopilotChatPrompts<CR>",
				desc = "CopilotChat - Prompt actions",
			},
			-- Quick chat with Copilot
			{
				"<leader>ccq",
				function()
					local input = vim.fn.input("Quick Chat: ")
					if input ~= "" then
						vim.cmd("CopilotChat " .. input)
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
			-- View/select available models
            {
                "<leader>ccm",
                ":CopilotChatModels<CR>",
                desc = "CopilotChat - View/select models",
                silent = true,
            }
		},
	},
}
