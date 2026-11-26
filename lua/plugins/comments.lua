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
		-- Comment banners. Local plugin, see local-plugins/banner.nvim/lua/banner/init.lua
		dir = vim.fn.stdpath("config") .. "/local-plugins/banner.nvim",
		name = "banner.nvim",
		main = "banner",
		keys = {
			{ "<leader>cb", function() return require("banner").operator("block") end, expr = true, desc = "Comment banner (block)" },
			{ "<leader>cl", function() return require("banner").operator("line") end, expr = true, desc = "Comment banner (single line)" },
			{ "<leader>cb", function() require("banner").visual("block") end, mode = "x", desc = "Comment banner (block)" },
			{ "<leader>cl", function() require("banner").visual("line") end, mode = "x", desc = "Comment banner (single line)" },
		},
		opts = {
			fill = "=", -- character the rules are drawn with (one display column wide)
			width = 50, -- total width, comment markers included, counted from the indentation
			uppercase = true, -- uppercase the text
			min_fill = 3, -- shortest fill on each side of the text in a single-line banner
			ellipsis = "…", -- ends text cut short to fit the width
			fallback_marker = "#", -- side marker when the file type has no comment string
		},
	},
}
