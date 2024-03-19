return {
  "nvim-tree/nvim-tree.lua",
  keys = { { '<Leader>e', '<cmd>NvimTreeFindFileToggle<CR>' } },
  config = function()
    require("nvim-tree").setup({})
  end
}
