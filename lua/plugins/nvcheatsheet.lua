return {
	"smartinellimarco/nvcheatsheet.nvim",
	keys = {
		{ "<leader>ch", desc = "Toggle cheatsheet" },
		{ "<leader>?", desc = "Toggle cheatsheet" },
	},
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
					{ "Quick chat", "<leader>ccq" },
					{ "Pick a prompt", "<leader>ccp" },
					{ "View/select models", "<leader>ccm" },
				},
				["Indent"] = {
					{ "Indent / de-indent selection (visual)", "<Tab> / <S-Tab>" },
					{ "Indent / de-indent line", ">> / <<" },
					{ "Jump forward in jumplist", "<C-i>" },
				},
				["Folds"] = {
					{ "Toggle fold", "za" },
					{ "Close all folds", "zM" },
					{ "Open all folds", "zR" },
				},
				["Spelling"] = {
					{ "See spelling suggestions (Telescope)", "<leader>zl" },
					{ "Next / previous misspelled word", "]s / [s" },
                    { "See spelling suggestions (which-key)", "z=" },
					{ "Add word under cursor as good word", "<leader>zg" },
					{ "Add word under cursor as bad word", "<leader>zw" },
					{ "Remove word under cursor from good word list", "<leader>zug" },
					{ "Remove word under cursor from bad word list", "<leader>zuw" },
				},
				["Bufferline"] = {
					{ "Move to next tab", "gt" },
					{ "Move to previous tab", "gT" },
					{ "Close buffer", "<leader>bc" },
				},
				["Telescope"] = {
					{ "Scroll preview up", "<C-u>" },
					{ "Scroll preview down", "<C-d>" },
					{ "Find file", "<C-p>" },
					{ "Search text in files (Live grep)", "<leader>ft" },
					{ "Move through buffers", "<leader>fb" },
                    { "Find symbols (variables, functions, etc)", "<leader>fs" },
                    { "Go through previously opened files", "<leader>fo" },
                    { "Find help tags", "<leader>fh" },
                    { "Search for the currently selected word", "<leader>fw" },
                    { "Search through clipboard", "<leader>fc" },
                    { "See all shown notifications", "<leader>fn" },
                    { "Prev / next search history (in picker)", "<C-k> / <C-j>" },
                    { "Open result in horizontal / vertical split", "<C-x> / <C-v>" },
                    { "Delete buffer (buffer picker)", "<C-d> / d" },
                    { "Show all picker keymaps (in picker)", "<C-/>" },
				},
				["Live Grep (<leader>ft)"] = {
					{ "Quote the search text, then add filters", '"text" <flags>' },
					{ "Only one file type (names: rg --type-list)", '"text" -t py' },
					{ "Exclude a file type", '"text" -T js' },
					{ "Only files matching a glob", '"text" -g *.sql' },
					{ "Only files under a folder", '"text" --iglob **/tests/**' },
					{ "Exclude a folder", '"text" -g !**/vendor/**' },
					{ "Case-sensitive search", '"Text" -s' },
					{ "Whole word only", '"text" -w' },
					{ "Literal text (no regex)", '"a.b(c)" -F' },
					{ "Search ignored/hidden files", '"text" --no-ignore --hidden' },
					{ "Starting with a flag also works", "-t py text" },
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
					{ "Search for word behind cursor", "S" },
					{ "Search for word in window", "gs" },
				},
				["Debugging"] = {
					{ "Toggle breakpoint", "<leader>dt" },
					{ "Continue debugging session", "<leader>dc" },
                    { "Open debugging sidebar", "<leader>ds" },
                    { "(Go) Debug Golang Test", "<leader>dgt" },
                    { "(Go) Debug last Golang Test", "<leader>dgl" },
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
					{ "Open scopes window", "<leader>gts" },
                    { "Remove tag", "List tags. Delete a line" }
				},
				["LSP"] = {
					{ "Code actions (lightbulb shows on the left)", "<leader>ca" },
					{ "See references", "gr" },
					{ "Go to definition", "gd" },
					{ "Check documentation", "K" },
					{ "Go to declaration", "gD" },
					{ "Go to implementation", "gi" },
					{ "Go to type definition", "go" },
					{ "Show function signature", "gs" },
					{ "Show diagnostic under cursor", "gl" },
					{ "Next / previous diagnostic", "]d / [d" },
					{ "Rename symbol", "<F2>" },
					{ "Format file (conform)", "<F3>" },
					{ "Execute code action", "<F4>" },
                    { "Check LSP info for current buffer", ":LspInfo" }
				},
				["Text objects"] = {
					{ "Around / inside function", "af / if" },
					{ "Around / inside class", "ac / ic" },
					{ "Around language scope", "as" },
					{ "Example: delete a whole function", "daf" },
					{ "Example: change a function's body", "cif" },
				},
				["Surround"] = {
					{ "Add surrounding (ysiw\" quotes a word)", "ys<motion><char>" },
					{ "Change surrounding (cs\"' swaps \" for ')", "cs<old><new>" },
					{ "Delete surrounding (ds( removes parens)", "ds<char>" },
					{ "Surround visual selection", "S<char> (visual)" },
				},
				["Neotree"] = {
					{ "Toggle file tree", "<C-b>" },
					{ "Move through scopes (Files, buffers, git)", "gT" },
                    { "Create file", "a" },
                    { "Delete file", "d" },
				},
				["Formatting"] = {
					{ "Format file or selection (conform)", "<leader>fm" },
					{ "Show formatters for current file", ":ConformInfo" },
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
                    { "Replace in current line", ":s/old/new/" },
                    { "Replace in entire file", ":%s/old/new/g" },
                    { "Replace in entire file (confirm each)", ":%s/old/new/gc" },
                    { "Replace in quickfix entries (confirm)", ":cdo s/old/new/gc" },
                },
				["Treesitter"] = {
					{ "Update supported languages (Treesitter)", ":TSUpdate" },
					{ "Install parser for a language", ":TSInstall <lang>" },
					{ "Start incremental selection", '<leader>ss' },
					{ "Increment selection by node (visual: an)", '<leader>si' },
					{ "Decrement selection by node (visual: in)", '<leader>sd' },
				},
				["Refactoring"] = {
					{ "Pick a refactor", "<leader>rs" },
					{ "Extract function (motion or selection)", "<leader>re" },
					{ "Extract variable (motion or selection)", "<leader>rv" },
					{ "Inline variable", "<leader>ri" },
					{ "Inline function", "<leader>rI" },
				},
				["Regex"] = {
					{ "Explain regex under cursor (Regexplainer)", "gR" },
				},
				["Other Packages"] = {
					{ "Install LSPs, debuggers, linters, formatters", ":Mason" },
					{ "Install missing Mason tools", ":MasonToolsInstall" },
					{ "Update Mason tools", ":MasonToolsUpdate" },
                    { "Lazy package manager", ":Lazy" },
					{ "Remove plugins no longer in the config", ":Lazy clean" },
					{ "Check health (or :checkhealth vim.lsp)", ":checkhealth" },
					{ "Increment / decrement number or date", "<C-a> / <C-x>" },
				},
			},
		})

		-- nvcheatsheet errors when the window is narrower than one column (the longest entry + ~20),
		-- so show a message instead. Keep entries short so more columns fit
		local function toggle()
			if pcall(nvcheatsheet.toggle) then
				return
			end
			-- The plugin switches to a new scratch buffer and marks itself as open before drawing,
			-- so undo that: go back to the previous buffer and drop the half-drawn one
			local scratch = vim.api.nvim_get_current_buf()
			local previous = vim.g.nvcheatsheet_previous_buffer
			if previous and previous ~= scratch and vim.api.nvim_buf_is_valid(previous) then
				vim.api.nvim_set_current_buf(previous)
				pcall(vim.api.nvim_buf_delete, scratch, { force = true })
			end
			vim.g.nvcheatsheet_displayed = false
			vim.notify("Window too narrow for the cheatsheet. Widen it or use :only", vim.log.levels.WARN)
		end
		vim.keymap.set("n", "<leader>ch", toggle, { desc = "Toggle cheatsheet" })
		vim.keymap.set("n", "<leader>?", toggle, { desc = "Toggle cheatsheet" })
	end,
}
