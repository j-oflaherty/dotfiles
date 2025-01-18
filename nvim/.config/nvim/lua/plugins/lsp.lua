return {
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
		event = { "BufReadPost", "BufNewFile" },
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
	},

	-- Nvim linter
	{
		"mfussenegger/nvim-lint",
		event = "BufWritePost",
		config = function()
			local python_linters = { "mypy" }
			if ConfigExists("pyproject.toml", "ruff") then
				python_linters[2] = "ruff"
			else
				python_linters[2] = "flake8"
			end

			require("lint").linters_by_ft = {
				python = python_linters,
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
