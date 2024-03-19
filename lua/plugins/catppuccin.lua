return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavor = 'mocha',
      transparent_background = true,
      integrations = {
        telescope = true,
        mini = {
          enabled = true,
          indentscope_color = "",
        }
      }
    })

    vim.cmd([[colorscheme catppuccin]])
  end
}
