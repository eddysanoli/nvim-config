return {
	{
		"github/copilot.vim",
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
				debug = true, -- Enable debugging
			})
			vim.keymap.set("n", "<leader>cc", ":CopilotChatOpen<CR>", { silent = true, desc = "Open Copilot Chat" })
			vim.keymap.set("n", "<leader>cx", ":CopilotChatClose<CR>", { silent = true, desc = "Close Copilot Chat" })
		end,
	},
}
