-- Folding is native (see the fold options in vim-options.lua and the LspAttach callback in
-- lsp-config.lua). statuscol only draws the fold column, signs and line numbers
return {
	"luukvbaal/statuscol.nvim",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		local builtin = require("statuscol.builtin")
		require("statuscol").setup({
			relculright = true,
			segments = {
				{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
				{ text = { "%s" }, click = "v:lua.ScSa" },
				{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
			},
		})
	end,
}
