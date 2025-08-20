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
			use_libuv_file_watcher = true,
			source_selector = {
				winbar = true,
				statusline = true,
			},
			window = {
				mappings = {
					["P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = true } },
				},
			},

			-- =================== AUTO CLOSE ================
			event_handlers = {

				{
					event = "file_open_requested",
					handler = function()
						require("neo-tree.command").execute({ action = "close" })
					end,
				},
			},

			filesystem = {

				-- =============== FADED HIDDEN ITEMS ============
                
				filtered_items = {
					visible = true,
				},

			},
		})

		vim.keymap.set("n", "<C-b>", ":Neotree filesystem toggle left<CR>", { desc = "Open side file tree explorer" })
	end,
}
