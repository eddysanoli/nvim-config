return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	opts = {
		preset = "modern",

		-- Names for the leader-key groups, shown in the popup while typing a key sequence.
		-- The keys themselves are defined (with descriptions) in each plugin's file
		spec = {
			mode = { "n", "x" },
			{ "<leader>b", group = "Buffer" },
			{ "<leader>c", group = "Code / Comments / Cheatsheet" },
			{ "<leader>cc", group = "Copilot Chat" },
			{ "<leader>d", group = "Debug" },
			{ "<leader>dg", group = "Debug Go" },
			{ "<leader>f", group = "Find / Format" },
			{ "<leader>g", group = "Git / Grapple" },
			{ "<leader>gt", group = "Grapple scopes" },
			{ "<leader>l", group = "LazyGit / Sessions" },
			{ "<leader>p", group = "PowerShell" },
			{ "<leader>q", group = "Quickfix" },
			{ "<leader>r", group = "Refactor" },
			{ "<leader>s", group = "Treesitter selection" },
			{ "<leader>t", group = "Trouble / Terminals" },
			{ "<leader>u", group = "Undotree" },
			{ "<leader>z", group = "Spelling" },
			{ "<leader>zu", group = "Undo spelling change" },
		},
	},
}
