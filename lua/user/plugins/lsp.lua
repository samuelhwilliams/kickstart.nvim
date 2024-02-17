local function on_attach(client, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', function()
    vim.lsp.buf.code_action { context = { only = { 'quickfix', 'refactor', 'source' } } }
  end, '[C]ode [A]ction')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })

  if client.supports_method "textDocument/inlayHint" then
    vim.lsp.inlay_hint.enable(bufnr, true)
  end
end

local function common_capabilities()
  -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
  return capabilities
end

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'j-hui/fidget.nvim',
    'folke/neodev.nvim',
    'hrsh7th/cmp-nvim-lsp',
  },
  config = function()
    -- mason-lspconfig requires that these setup functions are called in this order
    -- before setting up the servers.
    local mason_lspconfig = require 'mason-lspconfig'

    require('mason').setup({
      PATH = 'append',
    })
    require('neodev').setup()

    local servers = {
      'bashls',
      'cssls',
      'eslint',
      'gopls',
      'html',
      'jsonls',
      'lua_ls',
      'marksman',
      'pyright',
      'rust_analyzer',
      'tailwindcss',
      'tsserver',
      'yamlls',
    }

    mason_lspconfig.setup {
      ensure_installed = servers,
    }

    mason_lspconfig.setup_handlers {
      function (server_name)
        local opts = {
          on_attach = on_attach,
          capabilities = common_capabilities(),
        }

        local require_ok, settings = pcall(require, 'user.plugins.lspsettings.' .. server_name)
        if require_ok then
          opts = vim.tbl_deep_extend("force", settings, opts)
        end

        if server_name == 'lua_ls' then
          require('neodev').setup({})
        end

        require('lspconfig')[server_name].setup(opts)
      end
    }
  end
}
