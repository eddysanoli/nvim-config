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
