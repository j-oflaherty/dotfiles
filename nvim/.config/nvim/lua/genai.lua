-- Recomended
vim.opt.laststatus = 3

require("avante").setup({
	provider = "claude",
	behaviour = {
		auto_suggestions = false, -- Experimental stage
		auto_set_highlight_group = true,
		auto_set_keymaps = true,
		auto_apply_diff_after_generation = false,
		support_paste_from_clipboard = false,
	},
	windows = {
		position = "left",
	},
})
Map("n", "<C-l>", ":AvanteToggle<CR>")
