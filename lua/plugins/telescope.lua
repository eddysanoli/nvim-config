return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local builtin = require("telescope.builtin")
			local actions = require("telescope.actions")

			vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Find files" })
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
			vim.keymap.set("n", "<leader>ft", builtin.live_grep, { desc = "Search text in files" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
			vim.keymap.set("n", "<leader>fn", "<cmd>Telescope notify<cr>", { desc = "Find notifications" })
			vim.keymap.set(
				"n",
				"<leader>fs",
				builtin.lsp_document_symbols,
				{ desc = "Find symbols (variables, functions, etc)" }
			)
			vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Search previously opened files" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help tags" })
			vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Search for the currently selected word" })

			require("telescope").setup({
				defaults = {
					path_display = { "truncate" }, -- Truncate file paths in results
					mappings = {
						i = {
							["<C-j>"] = actions.cycle_history_next, -- Cycle through history in insert mode
							["<C-k>"] = actions.cycle_history_prev, -- Cycle through history in insert mode
						},
					},
				},
			})
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = { require("telescope.themes").get_dropdown({}) },
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
	{
		"AckslD/nvim-neoclip.lua",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("neoclip").setup({
				history = 20,
			})

			vim.keymap.set("n", "<leader>fc", function()
				require("telescope").extensions.neoclip.default()
			end, { desc = "Find clipboard history" })
		end,
	},
}
