return {
	{
		-- Loaded by its keys, or by nvim-dap's config when debugging a Go file
		"leoluz/nvim-dap-go",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function(_, opts)
			require("dap-go").setup(opts)
		end,
        keys = {
            { "<leader>dgt", "<cmd>lua require('dap-go').debug_test()<CR>", desc = "Debug Go test" },
            { "<leader>dgl", "<cmd>lua require('dap-go').debug_last()<CR>", desc = "Debug last Go test" },
        },
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},
		keys = {
			{ "<Leader>dt", desc = "Toggle debugging breakpoint" },
			{ "<Leader>dc", desc = "Continue to next debugging step" },
			{ "<leader>ds", desc = "Open debugging sidebar" },
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- Setup the UI and debuggers
			require("dapui").setup()

			-- Register the Go debug configurations, so <Leader>dc works in Go files
			if vim.bo.filetype == "go" then
				require("dap-go")
			end

			-- Initialize the UI automatically when nvim-dap starts
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, { desc = "Toggle debugging breakpoint" })
			vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "Continue to next debugging step" })
            vim.keymap.set("n", "<leader>ds", function()
                local widgets = require("dap.ui.widgets")
                local sidebar = widgets.sidebar(widgets.scopes)
                sidebar.open()
            end, { desc = "Open debugging sidebar" })
		end,
	},
}
