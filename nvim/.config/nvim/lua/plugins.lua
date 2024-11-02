return {
	-------------------- TREESITTER --------------------
	{
		{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	},

	--------------------- SURROUND ---------------------
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},

	-------------------- AUTOCLOSE ---------------------
	{
		"m4xshen/autoclose.nvim",
		config = function()
			require("autoclose").setup({})
		end,
	},

	--------------------- NEO-TREE ---------------------
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
	},

	--------------------- BUFFERLINE --------------------
	{ "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons" },

	---------------------- TROUBLE ----------------------
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
	},

	----------------------- MASON -----------------------
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },

	----------------------- LSP -------------------------
	{ "neovim/nvim-lspconfig" },

	{
		"hrsh7th/cmp-buffer",
		dependencies = {
			{ "L3MON4D3/LuaSnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-cmdline" },
			{ "hrsh7th/nvim-cmp" },
		},
	},

	-------------------- TELESCOPE ---------------------
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
		},
	},

	--------------------- LUALINE ----------------------
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		dependencies = {
			{ "nvim-tree/nvim-web-devicons", opt = true },
			{ "f-person/git-blame.nvim" },
			{ "f-person/lua-timeago" },
		},
	},

	-------------------- FORMATTER ---------------------
	{
		"stevearc/conform.nvim",
	},

	--------------------- LINTER -----------------------
	{
		"mfussenegger/nvim-lint",
	},

	------------------ TODO COMMENTS -------------------
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	--------------------- TROUBLE ----------------------
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	----------------------- GIT ------------------------
	{
		"tpope/vim-fugitive",
	},
	--{
	--'tanvirtin/vgit.nvim',
	--requires = {
	--  'nvim-lua/plenary.nvim'
	--}},

	------------------- INTERACTIVE --------------------
	{
		"GCBallesteros/NotebookNavigator.nvim",
		keys = {
			{
				"]h",
				function()
					require("notebook-navigator").move_cell("d")
				end,
			},

			{
				"[h",
				function()
					require("notebook-navigator").move_cell("u")
				end,
			},
			{ "<leader>X", "<cmd>lua require('notebook-navigator').run_cell()<cr>" },
			{ "<leader>x", "<cmd>lua require('notebook-navigator').run_and_move()<cr>" },
		},
		dependencies = {
			"echasnovski/mini.comment",
			"hkupty/iron.nvim", -- repl provider
			-- "akinsho/toggleterm.nvim", -- alternative repl provider
			-- "benlubas/molten-nvim", -- alternative repl provider

			-- "anuvyklack/hydra.nvim",
		},
		event = "VeryLazy",
	},
	{ "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async" },

	-------------------- AI CODING ---------------------
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		lazy = false,

		version = "v0.0.8", -- set this if you want to always pull the latest change
		opts = {
			-- add any opts here
		},
		build = "make",

		dependencies = {
			"stevearc/dressing.nvim",

			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"zbirenbaum/copilot.lua", -- for providers='copilot'
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users

						use_absolute_path = true,
					},
				},
			},
			{
				-- Make sure to set this up properly if you have lazy=true
				"MeanderingProgrammer/render-markdown.nvim",

				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
	},

	------------------- COLORSCHEME -------------------
	{ "EdenEast/nightfox.nvim", version = "*", lazy = true, priority = 1000 },

	{ "rebelot/kanagawa.nvim", version = "*", lazy = true, priority = 1000 },

	------------------- STARTUP -------------------
	{
		"startup-nvim/startup.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
		},
		config = function()
			require("startup").setup({ theme = "dashboard" })
		end,
	},

	------------------- TERMINALS -------------------
	{
		"numToStr/FTerm.nvim",
	},
}
