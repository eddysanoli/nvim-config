return {
	"akinsho/bufferline.nvim",
	version = "v4.6.1",
	dependencies = "nvim-tree/nvim-web-devicons",
	event = "VeryLazy",
	config = function()
		local bufferline = require("bufferline")
		bufferline.setup({
			options = {
                mode = "tabs",
				-- Show a tab's custom name (set with <leader>tr) instead of its active buffer
				name_formatter = function(item)
					if item.tabnr and vim.api.nvim_tabpage_is_valid(item.tabnr) then
						local ok, name = pcall(vim.api.nvim_tabpage_get_var, item.tabnr, "name")
						if ok and name ~= "" then
							return name
						end
					end
				end,
				offsets = {
					{
						filetype = "neo-tree",
						text = "File Explorer",
						separator = true,
						text_align = "left",
					},
				},
			},
		})

		-- Rename the current tab. An empty name goes back to showing the active buffer
		vim.keymap.set("n", "<leader>tr", function()
			vim.ui.input({ prompt = "Tab name: ", default = vim.t.name or "" }, function(name)
				if name == nil then
					return
				end
				if name == "" then
					vim.t.name = nil
				else
					vim.t.name = name
				end
				vim.cmd("redrawtabline")
			end)
		end, { silent = true, desc = "Rename current tab" })

		-- Close current buffer
		-- Focus on a new buffer that is not the tree by toggling the tree, deleting and then reopening
		vim.keymap.set("n", "<leader>bc", function()
			-- Only check for the tree if neo-tree is already loaded, so closing a buffer doesn't load it
			local window_exists = false
			if package.loaded["neo-tree"] then
				local manager = require("neo-tree.sources.manager")
				local renderer = require("neo-tree.ui.renderer")
				window_exists = renderer.window_exists(manager.get_state("filesystem"))
			end

			if window_exists then
				vim.cmd("Neotree filesystem toggle left")
			end

			vim.cmd("bd")

			if window_exists then
				vim.cmd("Neotree filesystem toggle left")
			end
		end, { silent = true, desc = "Close current buffer and toggle tree" })
	end,
}
