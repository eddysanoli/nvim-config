return {
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "neovim/nvim-lspconfig" },
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		config = function()
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_lspconfig()

            -- Remove inlay hints. These are the little hint inferences that show up after 
            -- a variable or function, but that are not part of the code
			lsp_zero.on_attach(function(_, bufnr)
				lsp_zero.default_keymaps({ buffer = bufnr })
				if vim.lsp.inlay_hint then
					vim.lsp.inlay_hint.enable(true, { 0 })
				end

                -- Set the onhover box to have a rounded border
                vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
                    vim.lsp.handlers.hover,
                    {
                        border = "rounded",
                        focusable = false,
                        style = "minimal",
                        relative = "cursor",
                        width = 80,
                        height = 20,
                    }
                )

                -- Set the signature help box to have a rounded border
                vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
                    vim.lsp.handlers.signature_help,
                    {
                        border = "rounded",
                        focusable = false,
                        style = "minimal",
                        relative = "cursor",
                        width = 80,
                        height = 20,
                    }
                )
			end)

			require("mason").setup({
				ui = {
					border = "rounded",
				},
			})
			require("mason-lspconfig").setup({
				ensure_installed = {
					"bashls",
					"cssls",
					"dotls",
					"intelephense",
					"html",
					"vimls",

					-- Rust
					"rust_analyzer",

					-- Docker
					"dockerls",
					"docker_compose_language_service",

					-- Markup Languages
					"jsonls",
					"yamlls",
					"taplo",

					-- Python
					"ruff",
					"pylsp",
					"basedpyright",
				},
				handlers = {
					function(server_name)
						local server = require("lspconfig")[server_name]

						if server_name == "solargraph" then
							local util = require("lspconfig.util")
							server.setup({
								settings = {
									Solargraph = {
										root_dir = util.root_pattern("Gemfile", ".git")(fname)
											or util.path.dirname(vim.api.nvim_buf_get_name(0)),
									},
								},
							})
							return
						end

						if server_name == "rust_analyzer" then
							server.setup({
								settings = {
									["rust-analyzer"] = {
										diagnostics = {
											enable = true,
											disabled = { "unresolved-imports" },
										},
									},
								},
							})
							return
						end
						if server_name == "basedpyright" then
							server.setup({
								settings = {
									basedpyright = {
										disableTaggedHints = true,
										typeCheckingMode = "strict",
									},
								},
							})
							return
						end
						if server_name == "pylsp" then
							server.setup({
								settings = {
									pylsp = {
										plugins = {
											ruff = {
												enabled = true,
												formatEnabled = true,
											},
											pycodestyle = { enabled = false },
											pyflakes = { enabled = false },
											mccabe = { enabled = false },
											autopep8 = { enabled = false },
											yapf = { enabled = false },
										},
									},
								},
							})
							return
						else
							server.setup({})
						end
					end,
				},
			})

			-- Add mapping for code actions
			-- For more mappings see this: https://lsp-zero.netlify.app/v3.x/reference/lua-api.html#lsp-actions
			vim.keymap.set("n", "<leader>ca", function()
				vim.lsp.buf.code_action()
			end, { desc = "Show code actions" })

			local bufnr = vim.fn.bufnr("%")
			vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", { buffer = bufnr, desc = "Show references" })
		end,
	},
}
