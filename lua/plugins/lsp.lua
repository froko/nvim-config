return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufWritePre' },
    cmd = { 'LspInfo', 'LspInstall', 'LspUninstall', 'Mason' },
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'hrsh7th/cmp-nvim-lsp',
      { 'j-hui/fidget.nvim', opts = {} },
      { 'folke/neodev.nvim', opts = {} },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup(
          'kickstart-lsp-attach',
          { clear = true }
        ),
        callback = function()
          local map = function(keys, func)
            vim.keymap.set('n', keys, func)
          end

          map('gd', require('telescope.builtin').lsp_definitions)
          map('gr', require('telescope.builtin').lsp_references)
          map('gi', require('telescope.builtin').lsp_implementations)
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols)
          map(
            '<leader>ws',
            require('telescope.builtin').lsp_dynamic_workspace_symbols
          )
          map('gD', vim.lsp.buf.declaration)
          map('<leader>rn', vim.lsp.buf.rename)
          map('<leader>ca', vim.lsp.buf.code_action)
          map('K', vim.lsp.buf.hover)
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local servers = {
        omnisharp = {
          enable_editorconfig = true,
          enable_roslyn_analyzers = true,
          organize_imports_on_format = true,
          enable_import_completion = true,
        },
        tsserver = {},
        cssls = {},
        html = {},
        jsonls = {},
        tailwindcss = {},
        yamlls = {},
        lua_ls = {
          settings = { Lua = { completion = { callSnippet = 'Replace' } } },
        },
      }

      require('mason').setup()

      local ensure_installed = vim.tbl_keys(servers)
      vim.list_extend(
        ensure_installed,
        { 'stylua', 'csharpier', 'prettierd', 'eslint_d' }
      )
      require('mason-tool-installer').setup {
        ensure_installed = ensure_installed,
      }
      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend(
              'force',
              {},
              capabilities,
              server.capabilities or {}
            )
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    opts = {
      notify_on_error = true,
      format_on_save = {
        async = true,
        timeout_ms = 1000,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        cs = { { 'csharpier' } },
        lua = { 'stylua' },
        js = { 'prettierd' },
        ts = { 'prettierd' },
      },
    },
  },
}
