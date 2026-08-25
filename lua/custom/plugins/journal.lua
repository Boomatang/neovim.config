local M = {}

function M.insert_date()
	local display_date = os.date("%d/%m/%Y")
	local journal_page = os.date("Journal:%Y:%m:%d")

	local link = string.format("[[%s|%s]]", journal_page, display_date)

	vim.api.nvim_put({ link }, "c", true, true)
end

vim.keymap.set("n", "<leader>zd", M.insert_date, {
	desc = "Insert journal date",
})

return M
