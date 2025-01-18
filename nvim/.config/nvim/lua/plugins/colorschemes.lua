return {
	{
		"EdenEast/nightfox.nvim",
		version = "*",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd("colorscheme terafox")
		end,
	},
}
