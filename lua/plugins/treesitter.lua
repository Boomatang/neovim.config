-- Lightweight treesitter parser manager for Neovim 0.12+
-- Neovim 0.12 has built-in treesitter highlighting; this plugin only handles parser installation.
-- https://github.com/romus204/tree-sitter-manager.nvim
return {
	"romus204/tree-sitter-manager.nvim",
	config = function()
		require("tree-sitter-manager").setup()
	end,
}
