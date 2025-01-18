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
				"<leader>xX",
				"<cmd>Trouble test test toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xx",
				"<cmd>Trouble test toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>xc",
				"<cmd>Trouble test test close<cr>",
				desc = "Diagnostics (Trouble)",
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
		lazy = true,
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
						vim.api.nvim_exec("Neotree focus filesystem left", true)
					end,
					["b"] = function()
						vim.api.nvim_exec("Neotree focus buffers left", true)
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
			{ "<leader>b", ":Neotree buffers toggle left<CR>", silent = true },
			{ "<c-b>", ":Neotree toggle left<CR>", silent = true },
			{ "<c-e>", ":Neotree filesystem toggle left<CR>", silent = true },
			{ "<c-t>", ":Neotree reveal left<CR>", silent = true },
		},
	},

	---------- BARBAR ----------
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
			"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
		},
		init = function()
			vim.g.barbar_auto_setup = false

			local map = vim.api.nvim_set_keymap
			local opts = { noremap = true, silent = true }

			-- Move to previous/next
			map("n", "<leader>,", "<Cmd>BufferPrevious<CR>", opts)
			map("n", "<leader>.", "<Cmd>BufferNext<CR>", opts)

			-- Re-order to previous/next
			map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)
			map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)

			-- Goto buffer in position...
			map("n", "<leader>1", "<Cmd>BufferGoto 1<CR>", opts)
			map("n", "<leader>2", "<Cmd>BufferGoto 2<CR>", opts)
			map("n", "<leader>3", "<Cmd>BufferGoto 3<CR>", opts)
			map("n", "<leader>4", "<Cmd>BufferGoto 4<CR>", opts)
			map("n", "<leader>5", "<Cmd>BufferGoto 5<CR>", opts)
			map("n", "<leader>6", "<Cmd>BufferGoto 6<CR>", opts)
			map("n", "<leader>7", "<Cmd>BufferGoto 7<CR>", opts)
			map("n", "<leader>8", "<Cmd>BufferGoto 8<CR>", opts)
			map("n", "<leader>9", "<Cmd>BufferGoto 9<CR>", opts)
			map("n", "<leader>0", "<Cmd>BufferLast<CR>", opts)

			-- Pin/unpin buffer
			map("n", "<leader>p", "<Cmd>BufferPin<CR>", opts)

			-- Goto pinned/unpinned buffer
			--                 :BufferGotoPinned
			--                 :BufferGotoUnpinned

			-- Close buffer
			map("n", "<leader>w", "<Cmd>BufferClose<CR>", opts)
		end,
		opts = {
			animation = false,
			auto_hide = 1,
			clickable = false,
			focus_on_close = "previous",
			sidebar_filetypes = {
				["neo-tree"] = { event = "BufWipeout" },
			},
		},
		version = "^1.0.0", -- optional: only update when a new 1.x version is released
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

	---------- FTERM ----------
	{
		"numToStr/FTerm.nvim",
		init = function()
			local fterm = require("FTerm")
			Map("n", "<c-u>", fterm.toggle)
			Map("t", "<c-u>", fterm.toggle)
		end,
		opts = {
			border = "rounded",
			dimensions = {
				height = 0.9,
				width = 0.9,
			},
		},
	},
}
