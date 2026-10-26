return {
	{
		"numToStr/Comment.nvim",
		dependencies = {
			{
				"JoosepAlviste/nvim-ts-context-commentstring",
				-- Comment.nvim calls it through pre_hook, so its own autocmd isn't needed
				opts = { enable_autocmd = false },
			},
		},
		keys = {
			{ "gcc", desc = "Comment line toggle" },
			{ "gbc", desc = "Comment block toggle" },
			{ "gc", mode = { "n", "x" }, desc = "Comment linewise" },
			{ "gb", mode = { "n", "x" }, desc = "Comment blockwise" },
			{ "gcO", desc = "Add comment on the line above" },
			{ "gco", desc = "Add comment on the line below" },
			{ "gcA", desc = "Add comment at the end of line" },
		},
		config = function()
			require("Comment").setup({
				toggler = {
					---Line-comment toggle keymap
					line = "gcc",
					---Block-comment toggle keymap
					block = "gbc",
				},
				opleader = {
					---Line-comment keymap
					line = "gc",
					---Block-comment keymap
					block = "gb",
				},
				extra = {
					---Add comment on the line above
					above = "gcO",
					---Add comment on the line below
					below = "gco",
					---Add comment at the end of line
					eol = "gcA",
				},
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},
	{
		"LudoPinelli/comment-box.nvim",
		cmd = { "CBllbox", "CBlcline" },
		keys = {
			{ "<leader>cb", "<Cmd>CBllbox<CR>", mode = { "n", "v" }, desc = "Comment box" },
			{ "<leader>cl", "<Cmd>CBlcline<CR>", mode = { "n", "v" }, desc = "Comment line" },
		},
		config = function()
			local cb = require("comment-box")
			cb.setup({
				comment_style = "line",
				doc_width = 80, -- width of the document
				box_width = 46, -- width of the boxes
				borders = { -- symbols used to draw a box
					top = "=",
					bottom = "=",
					top_left = "=",
					top_right = "=",
					bottom_left = "=",
					bottom_right = "=",
					left = "",
					right = "",
					-- left = "│",
					-- right = "│",
					-- top_left = "╭",
					-- top_right = "╮",
					-- bottom_left = "╰",
					-- bottom_right = "╯",
				},
				line_width = 46, -- width of the lines
				lines = { -- symbols used to draw a line
					line = "=",
					line_start = "=",
					line_end = "=",
					title_left = "=",
					title_right = "=",
				},
				outer_blank_lines_above = false, -- insert a blank line above the box
				outer_blank_lines_below = false, -- insert a blank line below the box
				inner_blank_lines = false, -- insert a blank line above and below the text
				line_blank_line_above = false, -- insert a blank line above the line
				line_blank_line_below = false, -- insert a blank line below the line
			})
		end,
	},
}
