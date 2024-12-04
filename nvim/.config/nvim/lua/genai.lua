-- Recomended
vim.opt.laststatus = 3

require("copilot").setup({
	suggestion = {
		enabled = true,
		auto_trigger = true,
	},
})

require("avante").setup({
	provider = "claude",
	windows = {
		position = "left",
	},
})
Map("n", "<leader>aa", ":AvanteToggle<CR>")
