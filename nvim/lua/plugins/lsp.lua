local servers = {
  lua_ls = {
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
        runtime = {
          version = 'LuaJIT',
        },
        workspace = {
          checkThirdParty = false,
          library = vim.api.nvim_get_runtime_file('', true),
        },
        diagnostics = {
          globals = { 'vim' },
          disable = { 'missing-fields' },
        },
        format = {
          enable = false,
        },
      },
    },
  },
  bashls = {},
  jsonls = {},
  yamlls = {},
  html = { filetypes = { 'html', 'twig', 'hbs' } },
  pyright = {},
}

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    {
      'j-hui/fidget.nvim',
      opts = {
        notification = {
          window = {
            winblend = 0,
          },
        },
      },
    },
    'hrsh7th/cmp-nvim-lsp',
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        local telescope = require 'telescope.builtin'
        map('gd', telescope.lsp_definitions, 'Goto definition')
        map('gr', telescope.lsp_references, 'Goto references')
        map('gI', telescope.lsp_implementations, 'Goto implementation')
        map('gD', vim.lsp.buf.declaration, 'Goto declaration')
        map('<leader>D', telescope.lsp_type_definitions, 'Type definition')
        map('<leader>ds', telescope.lsp_document_symbols, 'Document symbols')
        map('<leader>ws', telescope.lsp_dynamic_workspace_symbols, 'Workspace symbols')
        map('<leader>rn', vim.lsp.buf.rename, 'Rename')
        map('<leader>ca', vim.lsp.buf.code_action, 'Code action')
        map('K', vim.lsp.buf.hover, 'Hover documentation')

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
          local group = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = group,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = group,
            callback = vim.lsp.buf.clear_references,
          })
          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
            callback = function(args)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = args.buf }
            end,
          })
        end

        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end, 'Toggle inlay hints')
        end
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    require('mason-lspconfig').setup()
    require('mason-tool-installer').setup {
      ensure_installed = vim.tbl_keys(servers),
      auto_update = false,
      run_on_start = true,
      start_delay = 3000,
    }

    for name, config in pairs(servers) do
      config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, config.capabilities or {})
      vim.lsp.config(name, config)
      vim.lsp.enable(name)
    end
  end,
}
