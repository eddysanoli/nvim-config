return {
	{
		"cbochs/grapple.nvim",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons", lazy = true },
		},
		opts = {
			scope = "git",
		},
		event = { "BufReadPost", "BufNewFile" },
		cmd = "Grapple",
		keys = {
			{ "<leader>ga", "<cmd>Grapple toggle<cr>", desc = "Grapple toggle tag" },
			{ "<leader>gl", "<cmd>Grapple toggle_tags<cr>", desc = "Grapple open tags window (List tags)" },
			{ "<leader>g1", "<cmd>Grapple select index=1<cr>", desc = "Select first tag" },
			{ "<leader>g2", "<cmd>Grapple select index=2<cr>", desc = "Select second tag" },
			{ "<leader>g3", "<cmd>Grapple select index=3<cr>", desc = "Select third tag" },
			{ "<leader>g4", "<cmd>Grapple select index=4<cr>", desc = "Select fourth tag" },
			{ "<leader>gn", "<cmd>Grapple cycle_tags next<cr>", desc = "Grapple cycle next tag" },
			{ "<leader>gp", "<cmd>Grapple cycle_tags prev<cr>", desc = "Grapple cycle previous tag" },
			{ "<leader>gs", "<cmd>Grapple toggle_scopes<cr>", desc = "Grapple open scopes window" },
		},
	},
}
