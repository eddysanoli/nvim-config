return {
	"bennypowers/nvim-regexplainer",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"MunifTanjim/nui.nvim",
	},
	cmd = { "RegexplainerToggle", "RegexplainerShow", "RegexplainerHide" },
	keys = {
		{ "gR", desc = "Toggle Regexplainer" },
	},
	config = function()
		require("regexplainer").setup()
	end,
}
