return {
	"akinsho/toggleterm.nvim",
	version = "2.11.0",
	config = function()
		require("toggleterm").setup({
			open_mapping = "<C-\\>",
			start_in_insert = true,
			shell = "\"C:\\Program Files\\Git\\bin\\bash.exe\"",
			direction = "tab",
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
			vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)
			vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
			vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
			vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
			vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
			vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
			vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
		end

		-- if you only want these mappings for toggle term use term://*toggleterm#* instead
		vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
	end,
}
