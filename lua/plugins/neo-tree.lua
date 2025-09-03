return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			source_selector = {
				winbar = true,
				statusline = true,
			},
			window = {
				mappings = {
					["P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = true } },
					["gT"] = "prev_source",
					["gt"] = "next_source",
				},
			},

            -- Close Neo-tree when opening a file          
			event_handlers = {
				{
					event = "file_open_requested",
					handler = function()
						require("neo-tree.command").execute({ action = "close" })
					end,
				},
			},

			filesystem = {

                -- Use libuv to watch for file changes in real time
				use_libuv_file_watcher = true,

                -- When neotree is opened, focus on the current file
				follow_current_file = {
					enabled = true,
				},

                -- Show hidden or ignored files
				filtered_items = {
					visible = true,
				},
			},

            -- Only show active buffers in the buffer source
			buffers = {
				follow_current_file = {
					enabled = true,
				},
				show_unloaded = false,
			},
		})

		vim.keymap.set("n", "<C-b>", ":Neotree filesystem toggle left<CR>", { desc = "Open side file tree explorer" })
	end,
}
