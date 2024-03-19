 return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'j-hui/fidget.nvim', opts = {} },
    { 'folke/neodev.nvim', opts = {} },
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function()
        local map = function(keys, func)
          vim.keymap.set('n', keys, func)
        end

        --  Go to definition (press <C-t> to go back)
        map('gd', require('telescope.builtin').lsp_definitions)

        --  Go to declaration
        map('gD', vim.lsp.buf.declaration)

        -- Find references
        map('gr', require('telescope.builtin').lsp_references)

        --  Go to implementation
        map('gi', require('telescope.builtin').lsp_implementations)

        -- Fuzzy find all the symbols in your current document.
        map('<leader>ds', require('telescope.builtin').lsp_document_symbols)

        -- Fuzzy find all the symbols in your current workspace
        map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols)

        -- Rename the variable under your cursor
        map('<leader>rn', vim.lsp.buf.rename)

        -- Execute a code action
        map('<leader>ca', vim.lsp.buf.code_action)

        -- Opens a popup that displays documentation about the word under your cursor
        map('K', vim.lsp.buf.hover)
      end
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
      eslint = { settings = { workingDirectories = { mode = 'auto' } } },
      lua_ls = { settings = { Lua = { completion = { callSnippet = 'Replace' } } } }
    }

    require('mason').setup()

    local ensure_installed = vim.tbl_keys(servers)
    vim.list_extend(ensure_installed, { 'stylua', 'csharpier' })
    require('mason-tool-installer').setup({ ensure_installed = ensure_installed })
    require('mason-lspconfig').setup({
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end
      }
    })
  end
}
