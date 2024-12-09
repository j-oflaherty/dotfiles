return {
	{
		"folke/trouble.nvim",
		opts = {
			modes = {
				test = {
					mode = "diagnostics",
					preview = {
						type = "split",
						relative = "win",
						position = "right",
						size = 0.4,
					},
				},
			},
		}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble test test toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble test toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>ds",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
		},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
		keys = {
			{
				"<leader>xt",
				"<cmd>TodoTrouble<cr>",
				desc = "Todo List (Trouble)",
			},
		},
	},

	---------- LUALINE ----------
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		dependencies = {
			{ "nvim-tree/nvim-web-devicons", opt = true },
			{ "f-person/git-blame.nvim" },
			{ "f-person/lua-timeago" },
		},
	},

	---------- NEOTREE ----------
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		opts = {
			close_if_last_window = true,
			window = {
				mappings = {
					["e"] = function()
						vim.api.nvim_exec("Neotree focus filesystem right", true)
					end,
					["b"] = function()
						vim.api.nvim_exec("Neotree focus buffers right", true)
					end,
					["<C-b>"] = function()
						vim.api.nvim_exec("Neotree toggle", true)
					end,
				},
			},
			source_selector = {
				winbar = true,
				sources = { -- table
					{
						source = "filesystem", -- string
						display_name = " 󰉓 Files ", -- string | nil
					},
				},
			},
			filesystem = {
				filtered_items = {
					hide_dotfiles = false,
					hide_gitignores = true,
					never_show = {
						".git",
					},
					always_show = {
						".venv",
						".env",
					},
				},
			},
		},
		keys = {
			{ "<leader>b", ":Neotree buffers toggle right<CR>", silent = true },
			{ "<c-b>", ":Neotree toggle right<CR>", silent = true },
			{ "<c-e>", ":Neotree filesystem toggle right<CR>", silent = true },
			{ "<c-t>", ":Neotree reveal right<CR>", silent = true },
		},
	},

	---------- NOICE ----------
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			views = {
				notify = {
					position = {
						row = "100%",
						col = "100%",
					},
				},
			},
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
				},
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
	{
		"rcarriga/nvim-notify",
		opts = {
			top_down = false,
			render = "compact",
			stages = "slide",
		},
	},
}
