return {
	"smartinellimarco/nvcheatsheet.nvim",
	config = function()
		local nvcheatsheet = require("nvcheatsheet")

		nvcheatsheet.setup({
			header = {
				"                                                                                  ",
				"                                                                                  ",
				"                                                                                  ",
				" ░░░░░░ ░░   ░░ ░░░░░░░  ░░░░░  ░░░░░░░░ ░░░░░░░ ░░   ░░ ░░░░░░░ ░░░░░░░ ░░░░░░░░ ",
				"▒▒      ▒▒   ▒▒ ▒▒      ▒▒   ▒▒    ▒▒    ▒▒      ▒▒   ▒▒ ▒▒      ▒▒         ▒▒    ",
				"▒▒      ▒▒▒▒▒▒▒ ▒▒▒▒▒   ▒▒▒▒▒▒▒    ▒▒    ▒▒▒▒▒▒▒ ▒▒▒▒▒▒▒ ▒▒▒▒▒   ▒▒▒▒▒      ▒▒    ",
				"▓▓      ▓▓   ▓▓ ▓▓      ▓▓   ▓▓    ▓▓         ▓▓ ▓▓   ▓▓ ▓▓      ▓▓         ▓▓    ",
				" ██████ ██   ██ ███████ ██   ██    ██    ███████ ██   ██ ███████ ███████    ██    ",
				"                                                                                  ",
				"                                                                                  ",
				"                                                                                  ",
			},
			keymaps = {
				["General"] = {
					{ "Exit out of normal mode", "jk" },
					{ "Return from 'go to definition'", "<C-o>" },
					{ "List marks", "'" },
					{ "List registers", '"' },
                    { "Show diagnostics under cursor", "<C-w>d" },
                    { "Set split sizes equal in height and width", "<C-w>=" },
				},
				["Copilot"] = {
					{ "Open Copilot chat", "<leader>cco" },
					{ "Close Copilot chat", "<leader>ccx" },
				},
				["Folds"] = {
					{ "Toggle fold", "za" },
					{ "Close all folds", "zM" },
					{ "Open all folds", "zR" },
					{ "Peek at folded lines", "zK" },
				},
				["Spelling"] = {
					{ "See spelling suggestions", "<leader>zl" },
                    { "See spelling suggestions (which-key)", "z=" },
					{ "Add word under cursor as good word", "<leader>zg" },
					{ "Add word under cursor as bad word", "<leader>zw" },
					{ "Remove word under cursor from good word list", "<leader>zug" },
					{ "Remove word under cursor from bad word list", "<leader>zuw" },
				},
				["Bufferline"] = {
					{ "Move to next buffer", "<leader>gt" },
					{ "Move to previous buffer", "<leader>gT" },
					{ "Close buffer", "<leader>bc" },
				},
				["Telescope"] = {
					{ "Scroll preview up", "<C-u>" },
					{ "Scroll preview down", "<C-d>" },
					{ "Find file", "<C-p>" },
					{ "Search text in files (Live grep)", "<leader>fg" },
					{ "Find text in files", "<leader>ft" },
					{ "Move through buffers", "<leader>fb" },
                    { "Find symbols (variables, functions, etc)", "<leader>fs" },
                    { "Go through previously opened files", "<leader>fo" },
                    { "Find help tags", "<leader>fh" },
                    { "Search for the currently selected word", "<leader>fw" },
                    { "Search through clipboard", "<leader>fc" },
                    { "See all shown notifications", "<leader>fn" },
				},
				["Completions"] = {
					{ "Select next completion", "<C-j>" },
					{ "Select previous completion", "<C-k>" },
					{ "Accept completion", "<CR>" },
				},
				["Comment"] = {
					{ "Comment line toggle", "gcc" },
					{ "Comment block toggle", "gbc" },
					{ "Comment visual selection", "gc" },
					{ "Comment visual selection using block delimiters", "gb" },
					{ "Comment out text object line wise", "gc<motion>" },
					{ "Comment out text object block wise", "gb<motion>" },
					{ "Add comment on the line above", "gcO" },
					{ "Add comment on the line below", "gco" },
					{ "Add comment at the end of line", "gcA" },
				},
				["Leap"] = {
					{ "Search for word in front of cursor", "s" },
					{ "Search for word behind cursor", "sb" },
					{ "Search for word in window", "gs" },
				},
				["Debugging"] = {
					{ "Toggle breakpoint", "<leader>dt" },
					{ "Continue debugging session", "<leader>dc" },
				},
				["Git"] = {
					{ "Preview hunk", "<leader>gh" },
					{ "Open lazy git", "<leader>lg" },
                    { "Reset hunk", "<leader>gr" },
                    { "Show blame for current buffer", "<leader>gb" },
                    { "Show blame for current line", "<leader>gc" },
                    { "Set quickfix/loclist with git changes", "<leader>gq" },
				},
				["Grapple"] = {
					{ "Add grapple tag", "<leader>ga" },
					{ "Toggle tag list", "<leader>gl" },
					{ "Go to first tag", "<leader>g1" },
					{ "Go to second tag", "<leader>g2" },
					{ "Go to third tag", "<leader>g3" },
					{ "Go to fourth tag", "<leader>g4" },
					{ "Go to previous tag", "<leader>gp" },
					{ "Go to next tag", "<leader>gn" },
					{ "Open scopes window", "<leader>gs" },
                    { "Remove tag", "List tags. Delete a line" }
				},
				["LSP"] = {
					{ "See code actions (lightbulb will show up on the left)", "<leader>ca" },
					{ "See references", "gr" },
					{ "Go to definition", "gd" },
					{ "Check documentation", "K" },
                    { "Check LSP info for current buffer", ":LspInfo" }
				},
				["Neotree"] = {
					{ "Toggle file tree", "<C-b>" },
					{ "Move through scopes (Files, buffers, git)", "gT" },
                    { "Create file", "a" },
                    { "Delete file", "d" },
				},
				["None-LS"] = {
					{ "Format file", "<leader>fm" },
				},
				["Sessions"] = {
					{ "Session list menu", "<leader>ls" },
				},
				["Toggleterm"] = {
					{ "Open toggle term manager", "<leader>tm" },
					{ "Open powershell in floating window", "<leader>pwsh" },
					{ "Open new terminal", "<C-\\>" },
					{ "Open X terminal", "X<C-\\>" },
				},
				["Trouble"] = {
                    { "Preview diagnostics for current line", "gR" },
					{ "Toggle trouble diagnostics", "<leader>td" },
					{ "Toggle trouble diagnostics filter", "<leader>tb" },
					{ "Toggle trouble symbols", "<leader>ts" },
					{ "Toggle trouble LSP", "<leader>tt" },
					{ "Toggle trouble loclist", "<leader>tl" },
					{ "Toggle trouble QF List", "<leader>tq" },
				},
				["Undotree"] = {
					{ "Open Undotree", "<leader>ut" },
				},
                ["Quickfix"] = {
                    { "Put all searched files in quickfix list", "<C-q>" },
                    { "Cycle to next quickfix item", "<M-j>" },
                    { "Cycle to previous quickfix item", "<M-k>" },
                    { "Open quickfix list", "<leader>qo" },
                    { "Close quickfix list", "<leader>qc" },
                },
                ["Search and Replace"] = {
                    { "Replace word in current line", ":s/current-word/new-word/" },
                    { "Replace word in entire file", ":%s/current-word/new-word/g" },
                    { "Replace word in entire file (with confirmation)", ":%s/current-word/new-word/gc" },
                    { "Replace word in all elements within quickfix list (with confirmation)", ":cdo %s/current-word/new-word/gc" },
                },
				["Treesitter"] = {
					{ "Update supported languages (Treesitter)", ":TSUpdate" },
					{ "Start incremental selection", '<leader>ss' },
					{ "Increment selection by node", '<leader>si' },
					{ "Increment selection by scope", '<leader>sc' },
					{ "Decrement selection by node", '<leader>sd' },
				},
				["Other Packages"] = {
					{ "Install LSPs, DAP servers, linters and formatters (Mason)", ":Mason" },
                    { "Lazy package manager", ":Lazy" },
				},
			},
		})

		vim.keymap.set("n", "<leader>ch", nvcheatsheet.toggle)
		vim.keymap.set("n", "<leader>?", nvcheatsheet.toggle)
	end,
}
