return {
	{
		{
			"williamboman/mason.nvim",
			lazy = false,
			opts = {},
		},

		-- Autocompletion
		{
			"hrsh7th/nvim-cmp",
			event = "InsertEnter",
			config = function()
				local cmp = require("cmp")

				cmp.setup({
					sources = {
						{ name = "nvim_lsp" },
					},
					mapping = cmp.mapping.preset.insert({
						["<C-Space>"] = cmp.mapping.complete(),
						["<C-u>"] = cmp.mapping.scroll_docs(-4),
						["<C-d>"] = cmp.mapping.scroll_docs(4),
					}),
					snippet = {
						expand = function(args)
							vim.snippet.expand(args.body)
						end,
					},
				})
			end,
		},

		-- LSP
		{
			"neovim/nvim-lspconfig",
			cmd = { "LspInfo", "LspInstall", "LspStart" },
			event = { "BufReadPre", "BufNewFile" },
			dependencies = {
				{ "hrsh7th/cmp-nvim-lsp" },
				{ "williamboman/mason.nvim" },
				{ "williamboman/mason-lspconfig.nvim" },
			},
			init = function()
				-- Reserve a space in the gutter
				-- This will avoid an annoying layout shift in the screen
				vim.opt.signcolumn = "yes"
			end,
			config = function()
				local lsp_defaults = require("lspconfig").util.default_config

				-- Add cmp_nvim_lsp capabilities settings to lspconfig
				-- This should be executed before you configure any language server
				lsp_defaults.capabilities = vim.tbl_deep_extend(
					"force",
					lsp_defaults.capabilities,
					require("cmp_nvim_lsp").default_capabilities()
				)

				-- LspAttach is where you enable features that only work
				-- if there is a language server active in the file
				vim.api.nvim_create_autocmd("LspAttach", {
					desc = "LSP actions",
					callback = function(event)
						local opts = { buffer = event.buf }

						Map("n", "<leader>rn", vim.lsp.buf.rename, opts)
						Map("n", "<leader>s", vim.diagnostic.open_float, {})
						Map("n", "gd", vim.lsp.buf.definition, opts)
						Map("n", "gi", vim.lsp.buf.implementation, opts)
						Map("n", "gr", require("telescope.builtin").lsp_references, opts)
						Map("n", "K", vim.lsp.buf.hover, opts)
					end,
				})

				require("mason-lspconfig").setup({
					ensure_installed = {},
					handlers = {
						-- this first function is the "default handler"
						-- it applies to every language server without a "custom handler"
						function(server_name)
							require("lspconfig")[server_name].setup({})
						end,
						-- custom handler for pyright to disable type checking and other hints
						["pyright"] = function()
							require("lspconfig").pyright.setup({
								root_dir = function(fname)
									return require("lspconfig").util.root_pattern(".git")(fname)
										or require("lspconfig").util.path.dirname(fname)
								end,
								settings = {
									python = {
										analysis = {
											typeCheckingMode = "off",
											reportUnusedVariable = "none",
											reportUnusedImport = "none",
											reportMissingImports = "none",
											reportMissingTypeStubs = "none",
											reportOptionalSubscript = "none",
											reportOptionalMemberAccess = "none",
										},
									},
								},
							})
						end,
					},
				})
			end,
		},
	},

	-- Nvim linter
	{
		"mfussenegger/nvim-lint",
		event = "BufWritePost",
		config = function()
			require("lint").linters_by_ft = {
				python = { "mypy", "ruff" },
				go = { "gofumpt" },
			}
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					pcall(require("lint").try_lint)
				end,
			})
		end,
	},
}
