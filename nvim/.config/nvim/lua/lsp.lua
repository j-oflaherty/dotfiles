local lspconfig = require("lspconfig")
local lsp_defaults = lspconfig.util.default_config
local capabilities =
	vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

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

require("mason-lspconfig").setup({})

lspconfig.lua_ls.setup({
	capabilities = capabilities,
})

lspconfig.pyright.setup({
	root_dir = function(fname)
		return require("lspconfig").util.root_pattern(".git")(fname) or require("lspconfig").util.path.dirname(fname)
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
