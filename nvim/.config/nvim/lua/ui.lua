local git_blame = require("gitblame")

git_blame.setup({
	enabled = true,
	display_virtual_text = 0,
})

require("lualine").setup({
	options = {
		icons_enabled = true,
		-- https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md
		--
		theme = "auto",
		globalstatus = true,
	},
	sections = {
		lualine_a = {
			{
				"filename",
				path = 1,
			},
			{
				"swenv",
			},
		},
		lualine_x = {
			{ git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available },
		},
	},
})
