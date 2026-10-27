-- =================================================
--   FILENAME FIRST PATH DISPLAY                   
-- =================================================

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("UserTelescopeResults", { clear = true }),
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
		-- master: 0.1.x still uses nvim-treesitter's old "master" modules for previews
		branch = "master",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-live-grep-args.nvim",
				-- This will not install any breaking changes.
				-- For major updates, this must be adjusted manually.
				version = "^1.0.0",
			},
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-telescope/telescope-ui-select.nvim",
		},
		cmd = "Telescope",
		keys = {
			{ "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
			{
				"<leader>ft",
				function()
					require("telescope").extensions.live_grep_args.live_grep_args()
				end,
				desc = "Search text in files (Live grep)",
			},
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
			{
				"<leader>fa",
				function()
					-- Also lists hidden and gitignored files (.env), minus folders too big to be useful
					require("telescope.builtin").find_files({
						prompt_title = "Find All Files",
						find_command = {
							"fd", "--type", "f", "--hidden", "--no-ignore", "--color", "never",
							"--exclude", ".git",
							"--exclude", ".venv",
							"--exclude", "node_modules",
							"--exclude", "__pycache__",
						},
					})
				end,
				desc = "Find all files (hidden and ignored too)",
			},
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
			{ "<leader>fn", "<cmd>Telescope notify<cr>", desc = "Find notifications" },
			{ "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Find symbols (variables, functions, etc)" },
			{ "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Search previously opened files" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find help tags" },
			{ "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Search for the currently selected word" },
		},
		init = function()
			-- Load telescope the first time something asks for a selection. Loading the ui-select
			-- extension replaces vim.ui.select, so the call below goes to telescope
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("telescope")
				return vim.ui.select(...)
			end
		end,
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")

			telescope.setup({
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
				extensions = {
					["ui-select"] = { require("telescope.themes").get_dropdown({}) },
				},
			})

			telescope.load_extension("live_grep_args")
			telescope.load_extension("ui-select")
			telescope.load_extension("fzf")
		end,
	},
	{
		"AckslD/nvim-neoclip.lua",
		-- Loads on the first yank so the history is recorded. Telescope loads when the list is opened
		event = "TextYankPost",
		keys = {
			{
				"<leader>fc",
				function()
					require("telescope").extensions.neoclip.default()
				end,
				desc = "Find clipboard history",
			},
		},
		config = function()
			require("neoclip").setup({
				history = 20,
			})
		end,
	},
}
