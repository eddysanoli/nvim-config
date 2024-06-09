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
					{ "Search for text in files", "<leader>st" },
				},
				["Completions"] = {
					{ "Select next completion", "<C-j>" },
					{ "Select previous completion", "<C-k>" },
					{ "Accept completion", "<CR>" },
				},
				["Comment"] = {
					{ "Comment line toggle", "gc" },
					{ "Comment block toggle", "gbc" },
					{ "Comment visual selection", "gc" },
					{ "Comment visual selection using block delimiters", "gb" },
					{ "Comment out text object line wise", "gc<motion>" },
					{ "Comment out text object block wise", "gb<motion>" },
					{ "Add comment on the line above", "gcO" },
					{ "Add comment on the line below", "gco" },
					{ "Add comment at the end of line", "gcA" },
				},
				["Debugging"] = {
					{ "Toggle breakpoint", "<leader>dt" },
					{ "Continue debugging session", "<leader>dc" },
				},
				["Git"] = {
					{ "Preview hunk", "<leader>gp" },
					{ "Open git status window (neotree)", "<leader>gs" },
					{ "Open lazy git", "<leader>lg" },
				},
				["Harpoon"] = {
					{ "Add to harpoon list", "<leader>ha" },
					{ "Open harpoon list", "<leader>hl" },
					{ "Go to harpoon 1", "<leader>h1" },
					{ "Go to harpoon 2", "<leader>h2" },
					{ "Go to harpoon 3", "<leader>h3" },
					{ "Go to harpoon 4", "<leader>h4" },
					{ "Go to previous harpoon", "<leader>hp" },
					{ "Go to next harpoon", "<leader>hp" },
				},
				["LSP"] = {
					{ "See code actions (lightbulb will show up on the left)", "<leader>ca" },
					{ "See references", "gr" },
					{ "Go to definition", "gd" },
					{ "Check documentation", "K" },
				},
				["Neotree"] = {
					{ "Toggle left file tree", "<C-b>" },
					{ "Toggle left file tree", "<leader>ftl" },
					{ "Toggle right file tree", "<leader>ftr" },
				},
				["None-LS"] = {
					{ "Format file", "<leader>fm" },
				},
				["Scope"] = {
					{ "Buffer list menu", "<leader>bl" },
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
					{ "Toggle trouble diagnostics filter", "<leader>tdf" },
					{ "Toggle trouble symbols", "<leader>ts" },
					{ "Toggle trouble LSP", "<leader>tlsp" },
					{ "Toggle trouble loclist", "<leader>tloc" },
					{ "Toggle trouble QF List", "<leader>tqf" },
				},
				["Undotree"] = {
					{ "Open Undotree", "<leader>ut" },
				},
				["Virtual Env Selector"] = {
					{ "Open virtual environment selector", "<leader>vs" },
				},
			},
		})

		vim.keymap.set("n", "<leader>ch", nvcheatsheet.toggle)
		vim.keymap.set("n", "<leader>?", nvcheatsheet.toggle)
	end,
}
