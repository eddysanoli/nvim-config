return {
	"catppuccin/nvim",
	lazy = false,
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = require("theme").flavour,
			integrations = {
				mason = true,
				neotree = true,
				lsp_trouble = true,
				which_key = true,
				blink_cmp = {
					style = "bordered",
				},
                leap= true,
                copilot_vim = true,
			},

			custom_highlights = function(colors)
				return {
					-- Spelling mistakes get a dotted underline instead of catppuccin's red squiggle, so
					-- they don't look like code errors (diagnostics keep the squiggle). Mauve isn't used
					-- by any diagnostic level
					SpellBad = { sp = colors.mauve, style = { "underdotted" } },
					SpellCap = { sp = colors.yellow, style = { "underdotted" } },
					SpellLocal = { sp = colors.blue, style = { "underdotted" } },
					SpellRare = { sp = colors.green, style = { "underdotted" } },

					-- Custom highlights for nvcheatsheet
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

		vim.cmd.colorscheme(require("theme").colorscheme)
	end,
}
