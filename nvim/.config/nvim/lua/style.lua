require("nightfox").setup()
vim.cmd("colorscheme duskfox")

require("nvim-treesitter.configs").setup({
	ensure_installed = { "lua", "vim", "python", "yaml", "json", "markdown", "toml" },

	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
	},
	autotag = {
		enable = true,
	},
})
