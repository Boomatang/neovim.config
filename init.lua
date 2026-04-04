vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("options")
require("keymaps")
require("filetype")

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically

	require("kickstart.plugins.debug"),

	-- plugins that are used
	require("plugins.comment"),
	require("plugins.conform"),
	require("plugins.gitsigns"),
	require("plugins.harpoon"),
	require("plugins.lspconfig"),
	require("plugins.mini"),
	require("plugins.nvim-cmp"),
	require("plugins.telescope"),
	require("plugins.todo-comments"),
	require("plugins.tokyonight"),
	require("plugins.treesitter"),
	require("plugins.which-key"),

	-- plugins under review
	require("plugins.obsidian"),
	require("plugins.oil"),
	require("plugins.nvim-coverage"),

	-- Plugins I am not sure I want to use.
	-- require 'plugins.vim-fugitive',
})
