vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.cmd([[syntax match ZimTag /\v\@\w+/]])
		vim.api.nvim_set_hl(0, "ZimTag", { fg = "#e0af68", bold = true }) -- tweak to your colorscheme
		vim.cmd([[highlight link ZimTag ZimTag]])
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		-- Only matches on list items: "- [ ]", "- [x]", "- [*]", "- [>]", "- [<]"
		-- (also allows "*" as the bullet char, since markdown supports both)
		-- Priority marker must immediately follow the checkbox.
		local checkbox = [[^\s*[-*]\s\[[ x*<>]\]\s*\zs]]

		vim.cmd("syntax match ZimPriorityHigh /\\v" .. checkbox .. "!{3}(!)@!/")
		vim.cmd("syntax match ZimPriorityMed /\\v" .. checkbox .. "!{2}(!)@!/")
		vim.cmd("syntax match ZimPriorityLow /\\v" .. checkbox .. "!(!)@!/")

		vim.api.nvim_set_hl(0, "ZimPriorityHigh", { fg = "#f7768e", bold = true }) -- red
		vim.api.nvim_set_hl(0, "ZimPriorityMed", { fg = "#e0af68", bold = true }) -- orange
		vim.api.nvim_set_hl(0, "ZimPriorityLow", { fg = "#e0e068" }) -- yellow
	end,
})
