return {
	{
		"github/copilot.vim",
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = {
			{ "github/copilot.lua" },
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
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
