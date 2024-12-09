return {
	-------------------- TREESITTER --------------------
	{
		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			lazy = false,
			priority = 1000,
			config = function()
				require("nvim-treesitter.configs").setup({
					ensure_installed = { "lua", "python", "toml" },
					sync_install = false,
					highlight = { enable = true },
					indent = { enable = true },
				})
			end,
		},
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

	------------------- TELESCOPE -------------------
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				defaults = {
					file_ignore_patterns = {
						".git/*",
						".venv/",
						".*_cache/",
					},
				},
				pickers = {
					find_files = {
						hidden = true,
					},
				},
			})

			local builtin = require("telescope.builtin")

			Map("n", "<leader>ff", builtin.find_files, {})
			Map("n", "<leader>fg", builtin.live_grep, {})
			Map("n", "<leader>ft", builtin.grep_string, {})
			Map("n", "<leader>fb", builtin.buffers, {})
			Map("n", "<space><space>", builtin.oldfiles, {})
			Map("n", "<leader>gb", builtin.git_branches, {})
		end,
	},

	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				-- Customize or remove this keymap to your liking
				"<leader>f",
				function()
					require("conform").format({ async = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		opts = {
			-- Define your formatters
			formatters_by_ft = {
				lua = { "stylua" },
				python = function()
					if ConfigExists("pyproject.toml", "ruff") then
						return { "ruff", "ruff_fix" }
					else
						return { "black", "isort" }
					end
				end,
			},
			-- Set default options
			default_format_opts = {
				lsp_format = "fallback",
			},
			-- Set up format-on-save
			format_on_save = { timeout_ms = 500 },
		},
		init = function()
			-- If you want the formatexpr, here is the place to set it
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},

	{
		"kevinhwang91/nvim-ufo",
		dependencies = "kevinhwang91/promise-async",
		config = function()
			vim.o.foldcolumn = "0" -- '0' is not bad
			vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true

			vim.keymap.set("n", "zR", require("ufo").openAllFolds)
			vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

			local virtual_text_fold_handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local suffix = (" 󰁂 %d "):format(endLnum - lnum)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						local hlGroup = chunk[2]
						table.insert(newVirtText, { chunkText, hlGroup })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						-- str width returned from truncate() may less than 2nd argument, need padding
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end
				table.insert(newVirtText, { suffix, "MoreMsg" })
				return newVirtText
			end

			require("ufo").setup({
				provider_selector = function(bufnr, filetype, buftype)
					return { "treesitter", "indent" }
				end,
				fold_virt_text_handler = virtual_text_fold_handler,
			})
		end,
	},

	------------------- HARPOON -------------------
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
		config = function()
			local harpoon = require("harpoon")

			-- REQUIRED
			harpoon:setup()
			-- REQUIRED

			Map("n", "<leader>h", function()
				harpoon:list():add()
			end)
			Map("n", "<a-h>", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end)

			Map("n", "<leader>1", function()
				harpoon:list():select(1)
			end)
			Map("n", "<leader>2", function()
				harpoon:list():select(2)
			end)
			Map("n", "<leader>3", function()
				harpoon:list():select(3)
			end)
			Map("n", "<leader>4", function()
				harpoon:list():select(4)
			end)

			-- Toggle previous & next buffers stored within Harpoon list
			Map("n", "<C-S-P>", function()
				harpoon:list():prev()
			end)
			Map("n", "<C-S-N>", function()
				harpoon:list():next()
			end)
		end,
	},

	------------------- GIT FUTGITIVE -------------------
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "G" },
		keys = {
			"<a-g>",
			":G<CR>",
			desc = "Open Fugitive vim view",
		},
	},
}
