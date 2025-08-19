-- =================================================
--   FILENAME FIRST PATH DISPLAY                   
-- =================================================

vim.api.nvim_create_autocmd("FileType", {
	pattern = "TelescopeResults",
	callback = function(ctx)
		vim.api.nvim_buf_call(ctx.buf, function()
			vim.fn.matchadd("TelescopeParent", "\t\t.*$")
			vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
		end)
	end,
})

local function filenameFirst(_, path)
	local tail = vim.fs.basename(path)
	local parent = vim.fs.dirname(path)
	if parent == "." then return tail end
	return string.format("%s\t\t%s", tail, parent)
end


-- =================================================
--   SETUP                                         
-- =================================================

return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-live-grep-args.nvim",
				-- This will not install any breaking changes.
				-- For major updates, this must be adjusted manually.
				version = "^1.0.0",
			},
		},
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")
			local actions = require("telescope.actions")

			vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Find files" })
			vim.keymap.set(
				"n",
				"<leader>ft",
				"<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
				{ desc = "Search text in files (Live grep)" }
			)
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
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
					path_display = filenameFirst,
					mappings = {
						i = {
							["<C-j>"] = actions.cycle_history_next, -- Cycle through history in insert mode
							["<C-k>"] = actions.cycle_history_prev, -- Cycle through history in insert mode
						},
					},
				},
				pickers = {
					buffers = {
                        path_display = filenameFirst,
						sort_lastused = true, -- Sort buffers by last used
						ignore_current_buffer = true, -- Ignore the current buffer in the list
						mappings = {
							i = {
								["<C-d>"] = actions.delete_buffer, -- Delete buffer in insert mode
							},
							n = {
								["d"] = actions.delete_buffer, -- Delete buffer in normal mode
							},
						},
					},
				},
			})

			telescope.load_extension("live_grep_args")
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
