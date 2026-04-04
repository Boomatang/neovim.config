-- https://github.com/andythigpen/nvim-coverage

return {
  'andythigpen/nvim-coverage',
  version = '*',
  config = function()
    require('coverage').setup {
      auto_reload = true,
    }
  end,
}
