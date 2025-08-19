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

				-- ================== HARPOON INDEX ==================
                
				components = {
					harpoon_index = function(config, node, _)
						local harpoon_list = require("harpoon"):list()
						local path = node:get_id()
						local harpoon_key = vim.uv.cwd()

						for i, item in ipairs(harpoon_list.items) do
							local value = item.value
							if string.sub(item.value, 1, 1) ~= "/" then
								value = harpoon_key .. "/" .. item.value
							end

							if value == path then
								vim.print(path)
								return {
									text = string.format(" ⥤ %d", i), -- <-- Add your favorite harpoon like arrow here
									highlight = config.highlight or "NeoTreeDirectoryIcon",
								}
							end
						end
						return {}
					end,
				},
				renderers = {
					file = {
						{ "icon" },
						{ "name", use_git_status_colors = true },
						{ "harpoon_index" }, --> This is what actually adds the component in where you want it
						{ "diagnostics" },
						{ "git_status", highlight = "NeoTreeDimText" },
					},
				},
			},
		})

		vim.keymap.set("n", "<C-b>", ":Neotree filesystem toggle left<CR>", { desc = "Open side file tree explorer" })
		vim.keymap.set(
			"n",
			"<leader>gs",
			":Neotree float git_status<CR>",
			{ desc = "Open git status in a floating window" }
		)
	end,
}
