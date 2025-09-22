return {
	"bennypowers/nvim-regexplainer",
	requires = {
		"nvim-treesitter/nvim-treesitter",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("regexplainer").setup()
	end,
}
