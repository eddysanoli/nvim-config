return {
	{
		"ryanmsnyder/toggleterm-manager.nvim",
		dependencies = {
			"akinsho/nvim-toggleterm.lua",
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
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
			vim.api.nvim_set_keymap(
				"n",
				"<leader>tm",
				"<cmd>Telescope toggleterm_manager<CR>",
				{ noremap = true, silent = true }
			)
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		version = "2.11.0",
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
					height = math.ceil(vim.o.columns * 0.2),
					highlights = {
						border = "Normal",
						background = "Normal",
					},
				},
			})

			function _G.set_terminal_keymaps()
				local opts = { buffer = 0 }
				vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts, { desc = "Exit terminal mode" })
				vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts, { desc = "Exit terminal mode" })
				vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts, { desc = "Move to the left window" })
				vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts, { desc = "Move to the bottom window" })
				vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts, { desc = "Move to the top window" })
				vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts, { desc = "Move to the right window" })
				vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts, { desc = "Exit terminal mode and move to the next window" })
			end

			vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

			-- Open LazyGit
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
					vim.api.nvim_buf_set_keymap(
						term.bufnr,
						"n",
						"q",
						"<cmd>close<CR>",
						{ noremap = true, silent = true }
					)
				end,

				-- function to run on closing the terminal
				on_close = function(term)
					vim.cmd("startinsert!")
				end,
			})

			function _LAZYGIT_TOGGLE()
				lazygit:toggle()
			end

			vim.api.nvim_set_keymap(
				"n",
				"<leader>lg",
				"<cmd>lua _LAZYGIT_TOGGLE()<CR>",
				{ noremap = true, silent = true, desc = "Open LazyGit in a floating terminal" }
			)

			-- Open Powershell in a floating terminal
			local powershell = Terminal:new({
				cmd = "pwsh",
				direction = "float",
				float_opts = {
					border = "double",
				},
			})
			function _POWERSHELL_TOGGLE()
				powershell:toggle()
			end

			vim.api.nvim_set_keymap(
				"n",
				"<leader>pwsh",
				"<cmd>lua _POWERSHELL_TOGGLE()<CR>",
				{ noremap = true, silent = true, desc = "Open Powershell in a floating terminal" }
			)
		end,
	},
}
