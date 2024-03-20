return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local treesitter = require 'nvim-treesitter.configs'
    treesitter.setup {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        'css',
        'html',
        'javascript',
        'json',
        'lua',
        'markdown',
        'svelte',
        'tsx',
        'typescript',
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-Space>',
          node_incremental = '<C-Space>',
          scope_incremental = false,
          node_decremental = '<BS>',
        },
      },
    }
  end,
}
