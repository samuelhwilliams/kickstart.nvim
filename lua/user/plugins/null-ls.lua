return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'jay-babu/mason-null-ls.nvim',
  },
  config = function()
    require('mason-null-ls').setup({
      ensure_installed = { 'stylua', 'jq', 'black', 'isort', 'prettier', 'flake8' },
    })

    local none_ls = require('null-ls')
    local formatting = none_ls.builtins.formatting
    local diagnostics = none_ls.builtins.diagnostics

    none_ls.setup({
      debug = true,
      sources = {
        formatting.stylua,
        formatting.prettier,
        formatting.black,
        formatting.isort,
        diagnostics.flake8,
        none_ls.builtins.completion.spell,
      },
    })
  end,
}
