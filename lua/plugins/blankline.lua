return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("ibl").setup({
			scope = {
				enabled = false,
				show_start = false,
				show_end = false,
			},
			-- Added to ibl's default exclude list. Big files are detected in snacks.lua
			exclude = {
				filetypes = { "bigfile" },
			},
		})
	end,
}
