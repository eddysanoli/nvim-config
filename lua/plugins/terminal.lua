return {
	{
		"ryanmsnyder/toggleterm-manager.nvim",
		dependencies = {
			"akinsho/toggleterm.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>tm", desc = "Open toggle term manager" },
		},
		config = function()
			local toggleterm_manager = require("toggleterm-manager")
			local actions = toggleterm_manager.actions
			toggleterm_manager.setup({
				i = {
					["<CR>"] = { action = actions.toggle_term, exit_on_action = false }, -- toggles terminal open/closed
					["<C-i>"] = { action = actions.create_term, exit_on_action = false }, -- creates a new terminal buffer
					["<C-d>"] = { action = actions.delete_term, exit_on_action = false }, -- deletes a terminal buffer
					["<C-r>"] = { action = actions.rename_term, exit_on_action = false }, -- provides a prompt to rename a terminal
				},
			})

			-- Run the command: :Telescope toggleterm_manager
			vim.keymap.set(
				"n",
				"<leader>tm",
				"<cmd>Telescope toggleterm_manager<CR>",
				{ silent = true, desc = "Open toggle term manager" }
			)
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		version = "2.11.0",
		cmd = { "ToggleTerm", "TermExec", "ToggleTermToggleAll" },
		keys = {
			{ "<C-\\>", desc = "Open new terminal" },
			{ "<leader>lg", desc = "Open LazyGit in a floating terminal" },
			{ "<leader>pwsh", desc = "Open Powershell in a floating terminal" },
		},
		config = function()
			require("toggleterm").setup({
				open_mapping = "<C-\\>",
				start_in_insert = true,
				shell = '"C:\\Program Files\\Git\\bin\\bash.exe"',
				direction = "horizontal",
				shading_factor = 2,
				shade_terminals = true,
				persist_size = true,
				close_on_exit = true,
				float_opts = {
					border = "curved",
					width = math.ceil(vim.o.columns * 0.8),
					height = math.ceil(vim.o.lines * 0.2),
					highlights = {
						border = "Normal",
						background = "Normal",
					},
				},
			})

			-- Terminal-mode keymaps are in keymaps.lua, so they also apply before toggleterm loads

            -- ===================== LAZYGIT =====================

			local Terminal = require("toggleterm.terminal").Terminal
			local lazygit = Terminal:new({
				cmd = "lazygit",
				dir = "git_dir",
				direction = "float",
				float_opts = {
					border = "double",
				},

				-- function to run on opening the terminal
				on_open = function(term)
					vim.cmd("startinsert!")
					vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = term.bufnr, silent = true })
					-- Let lazygit handle Esc itself
					vim.keymap.set("t", "<Esc>", "<Esc>", { buffer = term.bufnr, silent = true })
				end,

				-- function to run on closing the terminal
				on_close = function()
					vim.cmd("startinsert!")
				end,
			})

			vim.keymap.set("n", "<leader>lg", function()
				lazygit:toggle()
			end, { silent = true, desc = "Open LazyGit in a floating terminal" })

            -- =================== POWERSHELL ================

			-- Open Powershell in a floating terminal
			local powershell = Terminal:new({
				cmd = "pwsh",
				direction = "float",
				float_opts = {
					border = "double",
				},
			})
			vim.keymap.set("n", "<leader>pwsh", function()
				powershell:toggle()
			end, { silent = true, desc = "Open Powershell in a floating terminal" })
		end,
	},
}
