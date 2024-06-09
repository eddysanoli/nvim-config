return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			disabled_filetypes = { "neo-tree" },
			options = { theme = "dracula" },
			extensions = {
				"fugitive",
				"neo-tree",
                "toggleterm",
				"trouble",
				"mason",
				"lazy",
				"nvim-dap-ui",
				{
					sections = {
						lualine_a = {
							function()
								return "Cheatsheet"
							end,
						},
					},
					filetypes = { "nvcheatsheet" },
				},
			},
		})
	end,
}
