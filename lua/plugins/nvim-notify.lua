return {
  'rcarriga/nvim-notify',
  event = 'VeryLazy',
  setup = {},
  config = function()
    vim.cmd [[
      highlight link NotifyBackground Normal 
      highlight NotifyERRORBorder guifg=#ed8796
      highlight NotifyERRORIcon guifg=#ed8796
      highlight NotifyERRORTitle  guifg=#ed8796
      highlight NotifyINFOBorder guifg=#8aadf4
      highlight NotifyINFOIcon guifg=#8aadf4
      highlight NotifyINFOTitle guifg=#8aadf4
      highlight NotifyWARNBorder guifg=#f5a97f
      highlight NotifyWARNIcon guifg=#f5a97f
      highlight NotifyWARNTitle guifg=#f5a97f
    ]]
  end,
}
