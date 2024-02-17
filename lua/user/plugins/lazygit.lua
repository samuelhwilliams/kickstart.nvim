return {
    "kdheepak/lazygit.nvim",
    version = "*",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        -- LazyGit keymaps
        vim.keymap.set('n', '<leader>gg', ':LazyGit<CR>', { silent = true })
    end
}
