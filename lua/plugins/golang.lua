return {
	"olexsmir/gopher.nvim",
	ft = "go",
	build = function()
		vim.cmd.GoInstallDeps()
	end,
	---@module "gopher"
	---@type gopher.Config
	opts = {},
    config = function(_, opts)
        require("gopher").setup(opts)
    end,
    keys = {
        { "<leader>gsj", "<cmd>GoTagAdd json<CR>", desc = "Add JSON tags to Go struct" },
        { "<leader>gsy", "<cmd>GoTagAdd yaml<CR>", desc = "Add YAML tags to Go struct" },
    },
}
