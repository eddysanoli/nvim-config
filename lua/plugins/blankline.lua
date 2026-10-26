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
		})
	end,
}
