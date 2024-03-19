--------------------------------------------------------------------------------
-- Options
--------------------------------------------------------------------------------
vim.g.mapleader = ' '
vim.opt.relativenumber = true

--------------------------------------------------------------------------------
-- Key Bindings
--------------------------------------------------------------------------------
local function map(mode, binding, action, opts)
  local options = { noremap = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, binding, action, options)
end

-- Use "jk" to return to Normal mode
map('i', 'jk', '<Esc>')

-- Buffers
map('n', '<Tab>', ':bNext<CR>')
map('n', 'bd', ':bd<CR>')

-- Splits
map('n', 'ss', '<C-w>v')
map('n', 'sS', '<C-w>n')
map('n', 'sd', '<C-w>c')


--------------------------------------------------------------------------------
-- Plugins
--------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins', {
  install = { colorscheme = { 'catppuccin' } },
  checker = { enabled = false, notify = false },
  change_detection = { notify = false }
})
