local M = {}

local templates_dir = "/tmp/other/templates"

local function substitute(line, title)
	line = line:gsub("{{title}}", title)
	line = line:gsub("{{date}}", os.date("%Y-%m-%d"))
	line = line:gsub("{{hdate}}", os.date("%A, %B %d %Y"))
	line = line:gsub("{{year}}", os.date("%Y"))
	return line
end

local function create_note(filepath, title, template_path)
	local lines
	if template_path then
		lines = vim.fn.readfile(template_path)
		for i, line in ipairs(lines) do
			lines[i] = substitute(line, title)
		end
	else
		lines = { "# " .. title, "" }
	end
	vim.fn.writefile(lines, filepath)
	vim.cmd("edit " .. filepath)
end

math.randomseed(os.time())

local function generate_uid(length)
	length = length or 4
	local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	local uid = {}
	for _ = 1, length do
		local idx = math.random(1, #chars)
		table.insert(uid, chars:sub(idx, idx))
	end
	return table.concat(uid)
end

function M.new_note()
	local current_dir = vim.fn.expand("%:p:h")

	-- Oil buffers return paths using the oil:// URI scheme.
	if current_dir:sub(1, 6) == "oil://" then
		current_dir = current_dir:sub(7)
	end

	if current_dir == "" then
		current_dir = vim.fn.getcwd()
	end

	-- Look for a Journal directory in the current path.
	local path = current_dir
	local journal_parent = nil

	while path and path ~= "/" do
		local name = vim.fn.fnamemodify(path, ":t")

		if name == "Journal" then
			journal_parent = vim.fn.fnamemodify(path, ":h")
			break
		end

		local parent = vim.fn.fnamemodify(path, ":h")

		if parent == path then
			break
		end

		path = parent
	end

	-- If we're inside Journal, create the note beside Journal.
	if journal_parent then
		current_dir = journal_parent
	end

	vim.ui.input({ prompt = "Note title: " }, function(title)
		if not title or title == "" then
			return
		end

		local filename = tostring(os.time()) .. "-" .. generate_uid() .. ".md"
		local filepath = current_dir .. "/" .. filename

		if vim.fn.filereadable(filepath) == 1 then
			vim.notify("Note already exists, opening it: " .. filepath, vim.log.levels.WARN)
			vim.cmd("edit " .. filepath)
			return
		end

		local templates = vim.fn.glob(templates_dir .. "/*.md", false, true)

		if #templates == 0 then
			create_note(filepath, title, nil)
			return
		end

		local choices = { "None (blank note)" }
		for _, t in ipairs(templates) do
			table.insert(choices, vim.fn.fnamemodify(t, ":t:r"))
		end

		vim.ui.select(choices, { prompt = "Select template:" }, function(choice, idx)
			if not choice then
				return -- cancelled
			elseif idx == 1 then
				create_note(filepath, title, nil)
			else
				create_note(filepath, title, templates[idx - 1])
			end
		end)
	end)
end

vim.keymap.set("n", "<leader>zn", M.new_note, { desc = "New note in current directory" })

return M
