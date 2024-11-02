-------------------- LUALINE --------------------
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
---------------------- GIT ----------------------
--require("vgit").setup({
--	keymaps = {},
--})
--
--Map("n", "<C-G>", ":VGit project_diff_preview<CR>", { silent = true })
-------------------- NEOTREE --------------------
require("neo-tree").setup({
	window = {
		mappings = {
			["e"] = function()
				vim.api.nvim_exec("Neotree focus filesystem right", true)
			end,
			["b"] = function()
				vim.api.nvim_exec("Neotree focus buffers right", true)
			end,
			["g"] = function()
				vim.api.nvim_exec("Neotree focus git_status right", true)
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
})
Map("n", "<C-b>", ":Neotree toggle right<CR>", { silent = true })
Map("n", "<C-t>", ":Neotree reveal right<CR>", { silent = true })

-------------------- TABLINE --------------------
vim.opt.termguicolors = true
require("bufferline").setup({
	options = {
		diagnostics = "nvim_lsp",
		offsets = {
			{
				filetype = "neo-tree",
				text = "File Explorer",
				highlight = "Directory",
			},
		},
	},
})

Map("n", "<C-p>", ":BufferLinePick<CR>", { silent = true })
Map("n", "<A-,>", ":BufferLineCyclePrev<CR>", { silent = true })
Map("n", "<A-.>", ":BufferLineCycleNext<CR>", { silent = true })

------------------ MASON SETUP ------------------
require("mason").setup({
	opts = {
		ensure_installed = {
			"mypy",
			"isort",
		},
	},
})
require("mason-lspconfig").setup({
	opts = {
		ensure_installed = { "lua_ls", "pyright" },
	},
})

------------------- FOLDING --------------------
vim.o.foldcolumn = "0" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
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

-- Option 3: treesitter as a main provider instad
-- (Note: the `nvim-treesitter` plugin is *not* needed.)
-- ufo uses the same query files for folding (queries/<lang>/folds.scm)
-- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`
require("ufo").setup({
	provider_selector = function(bufnr, filetype, buftype)
		return { "treesitter", "indent" }
	end,
	fold_virt_text_handler = virtual_text_fold_handler,
})
--

---------------------- LSP ----------------------
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- UFO capabilities setup
-- capabilities.textDocument.foldingRange = {
-- 	dynamicRegistration = false,
-- 	lineFoldingOnly = true,
-- }

local lspconfig = require("lspconfig")

-- lua lsp
lspconfig.lua_ls.setup({
	capabilities = capabilities,
})

-- python lsp
lspconfig.pyright.setup({
	capabilities = capabilities,
	filetypes = { "python" },
	settings = {
		python = {
			analysis = {
				diagnosticSeverityOverrides = {
					reportGeneralTypeIssues = "none",
				},
			},
		},
	},
})

-- docker lsp
lspconfig.dockerls.setup({
	capabilities = capabilities,
})
lspconfig.docker_compose_language_service.setup({
	filetypes = { "yaml" },
	capabilities = capabilities,
})

-- go
lspconfig.gopls.setup({
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
			gofumpt = true,
		},
	},
})

-- typescript
-- lspconfig.eslint.setup({
-- 	capabilities = capabilities,
-- })
lspconfig.ts_ls.setup({
	capabilities = capabilities,
})
lspconfig.angularls.setup({
	capabilities = capabilities,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		-- vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }

		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
		vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, {})

		vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
		vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, {})
		vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
		vim.keymap.set("n", "<space>f", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
	end,
})

--
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

vim.keymap.set("n", "<space>lp", vim.cmd("LspRestart<CR>"))

---------------------- CMP ----------------------
local cmp = require("cmp")

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-e>"] = cmp.mapping.abort(),
		["<tab>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),

	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	}, {
		{ name = "buffer" },
	}),
})

cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

------------------- TELESCOPE -------------------
require("telescope").setup({
	defaults = {
		file_ignore_patterns = {
			".git/*",
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
Map("n", "<space><space>", builtin.grep_string, {})
Map("n", "<leader>fh", builtin.help_tags, {})

-- git
Map("n", "<leader>gs", builtin.git_status, {})
Map("n", "<leader>gb", builtin.git_branches, {})

------------------- FORMATTER -------------------
local function config_exists(filename, substr)
	local f = io.open(filename, "r")
	if f == nil then
		return false
	else
		return string.find(f:read("*all"), substr) ~= nil
	end
end

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		python = function()
			if config_exists("pyproject.toml", "ruff") then
				return { "ruff_fix", "ruff_format" }
			else
				return { "black", "isort" }
			end
		end,
		toml = { "taplo" },
	},
	format_on_save = {
		-- I recommend these options. See :help conform.format for details.
		lsp_fallback = true,
		timeout_ms = 2000,
	},
})

-------------------- LINTER --------------------
local lint = require("lint")
local mypy = lint.linters.mypy
mypy.args = {
	"--no-color-output",
	"--no-error-summary",
	"--show-absolute-path",
	"--show-column-numbers",
	"--show-error-codes",
	"--no-pretty",
	"--show-error-en",
}

require("lint").linters_by_ft = {
	python = { "mypy", "flake8" }, -- "ruff" },
	go = { "gofumpt" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		pcall(lint.try_lint)
	end,
})

-------------------- TROUBLE -------------------
require("trouble").setup({
	mode = "workspace_diagnostics",
})
Map("n", "<leader>xx", "<cmd>Trouble diagnostics focus filter.buf=0<cr>", { silent = true })
Map("n", "<leader>xc", "<cmd>Trouble close<cr>", { silent = true })
Map("n", "<leader>xw", "<cmd>Trouble diagnostics focus<cr>", { silent = true })

local todo = require("todo-comments")
todo.setup({})
Map("n", "<leader>xt", "<cmd>TodoTrouble focus<cr>", { silent = true })
Map("n", "<leader>tt", "<cmd>TodoTelescope<cr>", { silent = true })

------------------- TERMINALS ------------------
local fterm = require("FTerm")
fterm.setup({
	border = "rounded",
	dimensions = {
		height = 0.8,
		width = 0.8,
	},
})
Map("n", "<A-i>", '<CMD>lua require("FTerm").toggle()<CR>')
Map("t", "<A-i>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

------------------ INTERACTIVE -----------------
require("notebook-navigator").setup({
	keys = {
		{ "<c-X>", "<cmd>lua require('notebook-navigator').run_cell()<cr>" },
		{ "<c-x>", "<cmd>lua require('notebook-navigator').run_and_move()<cr>" },
	},
})
