return {
	{
		"tpope/vim-fugitive",
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signcolumn = true,
				current_line_blame = true,
			})
			vim.keymap.set("n", "<leader>gh", ":Gitsigns preview_hunk<CR>", { desc = "Preview git hunk (file diff)" })
            vim.keymap.set("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", { desc = "Reset git hunk" })
            vim.keymap.set("n", "<leader>gb", ":Gitsigns blame<CR>", { desc = "Show blame for current buffer" })
            vim.keymap.set("n", "<leader>gc", ":Gitsigns blame_line<CR>", { desc = "Show blame for current line" })
            vim.keymap.set("n", "<leader>gq",":Gitsign setqflist<CR>", { desc = "Set quickfix/loclist with git changes" })
		end,
	},
}
