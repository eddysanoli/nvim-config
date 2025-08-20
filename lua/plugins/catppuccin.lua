return {
	"catppuccin/nvim",
	lazy = false,
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
			integrations = {
				mason = true,
				neotree = true,
				lsp_trouble = true,
				which_key = true,
			},

			-- Custom highlights for nvcheatsheet
			custom_highlights = function(colors)
				return {
					NvChAsciiHeader = { bg = colors.base, fg = colors.subtext0 }, -- Title
					NvChSection = { bg = colors.surface0 }, -- Each card

					-- Colors for the headers
					NvCheatsheetWhite = { bg = colors.lavender, fg = colors.base },
					NvCheatsheetGray = { bg = colors.sky, fg = colors.base },
					NvCheatsheetBlue = { bg = colors.blue, fg = colors.base },
					NvCheatsheetCyan = { bg = colors.pink, fg = colors.base },
					NvCheatsheetRed = { bg = colors.red, fg = colors.base },
					NvCheatsheetGreen = { bg = colors.green, fg = colors.base },
					NvCheatsheetYellow = { bg = colors.yellow, fg = colors.base },
					NvCheatsheetOrange = { bg = colors.teal, fg = colors.base },
					NvCheatsheetPurple = { bg = colors.maroon, fg = colors.base },
					NvCheatsheetMagenta = { bg = colors.mauve, fg = colors.base },
				}
			end,
		})

		vim.cmd.colorscheme("catppuccin")
	end,
}
