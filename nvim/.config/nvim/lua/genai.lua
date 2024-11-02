-- Recomended
vim.opt.laststatus = 3

require("copilot").setup({
	suggestion = {
		enabled = true,
	},
})

require("avante").setup({
	provider = "claude",
	windows = {
		position = "left",
	},
})
Map("n", "<C-l>", ":AvanteToggle<CR>")
