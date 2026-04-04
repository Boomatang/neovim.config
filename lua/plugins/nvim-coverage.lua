-- https://github.com/andythigpen/nvim-coverage
return {
  'andythigpen/nvim-coverage',
  version = '*',
  config = function()
    require('coverage').setup {
      auto_reload = true,
      load_coverage_db = function(ftype)
        vim.notify('Loaded ' .. ftype .. ' coverage')
      end,
    }
  end,
}
