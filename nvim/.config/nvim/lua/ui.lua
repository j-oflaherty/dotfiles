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
		disabled_filetypes = {
			winbar = { "neo-tree", "startup", "Avante" },
		},
	},
	sections = {
		lualine_a = {
			{
				"mode",
			},
			{
				"swenv",
			},
		},
		lualine_b = {
			{
				"macro",
				fmt = function()
					local reg = vim.fn.reg_recording()
					if reg ~= "" then
						return "Recording @" .. reg
					end
					return nil
				end,
				color = { fg = "#ff9e64" },
				draw_empty = false,
			},
			{
				"branch",
				"diagnostics",
			},
		},
		lualine_x = {
			{ git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available },
		},
	},
	winbar = {
		lualine_c = { "filename", "diagnostics" },
	},
	inactive_winbar = {
		lualine_c = { "filename", "diagnostics" },
	},
})
