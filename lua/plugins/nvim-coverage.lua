-- https://github.com/andythigpen/nvim-coverage
return {
	"andythigpen/nvim-coverage",
	version = "*",
	config = function()
		local coverage = require("coverage")
		coverage.setup({
			auto_reload = true,
			load_coverage_db = function(ftype)
				vim.notify("Loaded " .. ftype .. " coverage")
			end,
		})

		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { desc = desc })
		end

		map("<leader>cl", coverage.load, "[C]overage [L]oad")
		map("<leader>cs", coverage.show, "[C]overage [S]how")
		map("<leader>ch", coverage.hide, "[C]overage [H]ide")
		map("<leader>ct", coverage.toggle, "[C]overage [T]oggle")
		map("<leader>cm", coverage.summary, "[C]overage Su[m]mary")
		map("<leader>cc", coverage.clear, "[C]overage [C]lear")
	end,
}
