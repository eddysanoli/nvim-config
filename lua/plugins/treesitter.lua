-- Parsers kept installed. Any other supported language is installed the first time a file of
-- that type is opened (what auto_install did on the old master branch)
local ensure_installed = {
	"bash",
	"c",
	"css",
	"csv",
	"diff",
	"dockerfile",
	"gitattributes",
	"gitignore",
	"go",
	"gomod",
	"gosum",
	"gotmpl",
	"helm",
	"html",
	"htmldjango",
	"ini",
	"javascript",
	"json",
	"lua",
	"make",
	"markdown",
	"markdown_inline",
	"python",
	"query",
	"regex",
	"rust",
	"scss",
	"sql",
	"toml",
	"typescript",
	"vim",
	"vimdoc",
	"yaml",
}

-- Turns on treesitter highlighting and indentation for a buffer
local function start(buf, lang)
	if not vim.api.nvim_buf_is_valid(buf) or not pcall(vim.treesitter.start, buf, lang) then
		return
	end
	vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end

return {
	{
		-- main branch: needs Neovim 0.12+, the tree-sitter CLI and a C compiler (both installed through Mason / gcc)
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false, -- main doesn't support lazy-loading
		build = ":TSUpdate",
		config = function()
			-- nvim-treesitter runs "tree-sitter" by name. Mason's bin folder only has a .cmd wrapper, which
			-- Windows can't run that way, and it isn't on PATH until Mason loads. So put the folder with
			-- the real tree-sitter.exe (installed by mason-tool-installer) on PATH
			local ts_cli = vim.fn.stdpath("data") .. "/mason/packages/tree-sitter-cli"
			if vim.uv.fs_stat(ts_cli .. "/tree-sitter.exe") then
				vim.env.PATH = vim.fs.normalize(ts_cli) .. ";" .. vim.env.PATH
			end

			local ts = require("nvim-treesitter")
			ts.install(ensure_installed)

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true }),
				callback = function(ev)
					local lang = vim.treesitter.language.get_lang(ev.match)
					if not lang then
						return
					end
					if vim.treesitter.language.add(lang) then
						start(ev.buf, lang)
					elseif vim.tbl_contains(ts.get_available(), lang) then
						-- Not installed yet: install it, then start once it's ready
						ts.install(lang):await(function()
							vim.schedule(function()
								start(ev.buf, lang)
							end)
						end)
					end
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = {
					lookahead = true,
					selection_modes = {
						["@parameter.outer"] = "v", -- charwise
						["@function.outer"] = "V", -- linewise
						["@class.outer"] = "<c-v>", -- blockwise
					},
					include_surrounding_whitespace = true,
				},
			})

			local function select(lhs, query, group, desc)
				vim.keymap.set({ "x", "o" }, lhs, function()
					require("nvim-treesitter-textobjects.select").select_textobject(query, group)
				end, { desc = desc })
			end
			select("af", "@function.outer", "textobjects", "Select outer function")
			select("if", "@function.inner", "textobjects", "Select inner function")
			select("ac", "@class.outer", "textobjects", "Select outer class")
			select("ic", "@class.inner", "textobjects", "Select inner part of a class region")
			select("as", "@local.scope", "locals", "Select language scope")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			max_lines = 1,
		},
	},
}
