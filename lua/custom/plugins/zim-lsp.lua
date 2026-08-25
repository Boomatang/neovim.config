local M = {}

M.config = {
	root = "/tmp/other",
}

local function zim_link_at_cursor()
	local line = vim.api.nvim_get_current_line()
	local col = vim.api.nvim_win_get_cursor(0)[2]

	-- Find all Zim links on the current line.
	for start_pos, link, display in line:gmatch("()%[%[([^%]|]+)|?([^%]]*)%]%]") do
		local end_pos = start_pos + #link + 3

		-- Cursor is inside this link.
		if col >= start_pos - 1 and col <= end_pos then
			return link
		end
	end

	return nil
end

local function zim_page_path(page)
	local parts = vim.split(page, ":")

	return M.config.root .. "/" .. table.concat(parts, "/") .. ".md"
end

local function goto_zim_page(page)
	local filepath = zim_page_path(page)

	if vim.fn.filereadable(filepath) == 0 then
		vim.fn.mkdir(vim.fn.fnamemodify(filepath, ":h"), "p")

		local title = vim.fn.fnamemodify(filepath, ":t:r")

		vim.fn.writefile({
			"# " .. title,
			"",
		}, filepath)
	end

	vim.cmd("edit " .. vim.fn.fnameescape(filepath))
end

function M.goto_definition()
	local page = zim_link_at_cursor()

	if page then
		goto_zim_page(page)
		return
	end

	-- Not a Zim link: use the normal LSP behaviour.
	vim.lsp.buf.definition()
end

function M.setup()
	vim.keymap.set("n", "zz", M.goto_definition, {
		desc = "Go to definition / Zim page",
	})
end

M.setup()

return M
