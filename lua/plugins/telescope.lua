return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-tree/nvim-web-devicons', enabled = true },
  },
  config = function()
    require('telescope').setup {}
    pcall(require('telescope').load_extension, 'fzf')

    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<Leader>ff', builtin.find_files)
    vim.keymap.set('n', '<Leader>fg', builtin.live_grep)
    vim.keymap.set('n', '<Leader>fh', builtin.help_tags)
    vim.keymap.set('n', '<Leader><Leader>', builtin.buffers)
    vim.keymap.set('n', '<Leader>fc', function()
      builtin.commands(require('telescope.themes').get_dropdown {
        previewer = false,
      })
    end)
    vim.keymap.set('n', '<Leader>fn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end)
  end,
}
