-- Set python path explicitly otherwise start time is v slow.
-- Need to create this venv manually
-- vim.g.python3_host_prog = vim.fn.expand('~/.config/nvim/venv/bin/python')
vim.g.loaded_python3_provider = 0

require('user.leader')

LAZY_PLUGINS = {}
local function register_plugin(plugin_path)
  table.insert(LAZY_PLUGINS, { import = plugin_path })
end

register_plugin('user.plugins.catppuccin')
register_plugin('user.plugins.comment')
register_plugin('user.plugins.fugitive')
register_plugin('user.plugins.gitsigns')
register_plugin('user.plugins.harpoon')
register_plugin('user.plugins.indent-blankline')
register_plugin('user.plugins.lazygit')
register_plugin('user.plugins.lsp')
register_plugin('user.plugins.lualine')
register_plugin('user.plugins.neo-tree')
register_plugin('user.plugins.nerdfonts')
register_plugin('user.plugins.null-ls')
register_plugin('user.plugins.nvim-cmp')
register_plugin('user.plugins.rhubarb')
register_plugin('user.plugins.sleuth')
register_plugin('user.plugins.telescope')
register_plugin('user.plugins.treesitter')
register_plugin('user.plugins.which-key')

register_plugin('user.plugins.startuptime')

require('user.lazy')

require('user.options')
require('user.keymaps')
require('user.autocmds')

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
