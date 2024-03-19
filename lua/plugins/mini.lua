
return {
  'echasnovski/mini.nvim',
  config = function()
    require('mini.basics').setup({ mappings = { windows = true } })
    require('mini.comment').setup()
    require('mini.completion').setup()
    require('mini.notify').setup()
    require('mini.pairs').setup()
    require('mini.statusline').setup()
  end
}

