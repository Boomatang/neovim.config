-- https://github.com/MeanderingProgrammer/render-markdown.nvim
return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
	ft = { "markdown" },
	config = function()
		require("render-markdown").setup({
			completion = { lsp = { enabled = true } },
		})
	end,
}
