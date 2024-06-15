return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.code_actions.refactoring,
				null_ls.builtins.diagnostics.mypy,
				null_ls.builtins.formatting.djhtml,
				null_ls.builtins.formatting.isort,
				require("none-ls.diagnostics.eslint_d"),
			},
		})

		vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, { desc = "Format the current file" })
	end,
}
