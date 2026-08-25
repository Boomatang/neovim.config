-- https://github.com/echaya/neowiki.nvim

return {
	"echaya/neowiki.nvim",
	event = "VeryLazy",
	opts = {
		wiki_dirs = {
			{ name = "Wiki", path = "/tmp/other" },
			{ name = "projects", path = "/tmp/other/projects" },
			{ name = "area", path = "/tmp/other/area" },
			{ name = "PARA", path = "/tmp/PARA" },
		},
	},
	keys = {
		{
			"<leader>ww",
			function()
				require("neowiki").open_wiki()
			end,
			desc = "Open Wiki Index",
		},
		{
			"<leader>wW",
			function()
				require("neowiki").open_wiki_floating()
			end,
			desc = "Open Wiki (float)",
		},
		{
			"<leader>w<leader>w",
			function()
				_G.open_today_journal()
			end,
			desc = "Open Today's Journal",
		},
	},
	config = function(_, opts)
		require("neowiki").setup(opts)

		local wiki_path = vim.fn.expand(opts.wiki_dirs[1].path)

		local function open_today()
			local dir = string.format("%s/Journal/%s/%s", wiki_path, os.date("%Y"), os.date("%m"))
			vim.fn.mkdir(dir, "p")
			local file = string.format("%s/%s.md", dir, os.date("%d"))

			if vim.fn.filereadable(file) == 0 then
				local lines = {
					"# " .. os.date("%A, %B %d %Y"),
					"",
					"## Tasks",
					"",
					"## Notes",
					"",
				}
				vim.fn.writefile(lines, file)
			end

			vim.cmd("edit " .. file)
		end

		_G.open_today_journal = open_today

		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function()
				local argc = vim.fn.argc()
				local target_dir
				if argc == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
					target_dir = vim.fn.fnamemodify(vim.fn.argv(0), ":p")
				elseif argc == 0 then
					target_dir = vim.fn.getcwd() .. "/"
				end
				if not target_dir then
					return
				end

				target_dir = vim.fn.resolve(target_dir)
				local normalized_wiki = vim.fn.resolve(wiki_path) .. "/"
				if target_dir:sub(1, #normalized_wiki) == normalized_wiki or target_dir == normalized_wiki then
					open_today()
				end
			end,
		})
	end,
}
