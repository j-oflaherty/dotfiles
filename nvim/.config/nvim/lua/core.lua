vim.o.autoread = true
vim.wo.relativenumber = true
vim.wo.number = true
vim.wo.numberwidth = 2

vim.o.scrolloff = 4

-- set leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.cursorline = true -- underlines where the cursor is
vim.opt.autoread = true

-- tab configuration setup
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true

-- Global Map function
Map = vim.keymap.set

-- useful keymaps
Map("n", "<esc>", function()
	vim.cmd("nohlsearch")
end)

Map("n", "<c-s>", function()
	vim.cmd("w")
end)

Map("n", "<a-q>", ":q<CR>")
Map("n", "<a-w>", ":bd<CR>")

Map("n", "<c-l>", "<c-w>l")
Map("n", "<c-h>", "<c-w>h")
Map("n", "<c-j>", "<c-w>j")
Map("n", "<c-k>", "<c-w>k")

Map("n", "<a-.>", ":bNext<CR>", { silent = true })
Map("n", "<a-,>", ":bprevious<CR>", { silent = true })

-- lazy nvim setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
