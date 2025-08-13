return {
	{ "alefpereira/pyenv-pyright" },
	{
		"tnfru/nvim-venv-detector",
		event = "VimEnter",
		config = function()
			require("venv_detector").setup({
				auto_activate_venv = true, -- Set VIRTUAL_ENV and PATH automatically (default: true)
				auto_restart_lsp = true, -- Restart Python LSP clients automatically (default: true)
				lsp_client_names = { -- LSP client names to restart (default list includes common Python LSPs)
					"pyright",
					"pylsp",
					"ruff",
					"ruff_lsp",
					"basedpyright",
					"python",
				},
				notify = true, -- Show notifications (default: true)
			})
		end,
	},
}
