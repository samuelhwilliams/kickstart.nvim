return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require('harpoon')
    harpoon:setup({})

    vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
    vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon list' })

    vim.keymap.set("n", "<C-S-h>", function() harpoon:list():select(1) end, { desc = 'Harpoon jump #1' })
    vim.keymap.set("n", "<C-S-j>", function() harpoon:list():select(2) end, { desc = 'Harpoon jump #2' })
    vim.keymap.set("n", "<C-S-k>", function() harpoon:list():select(3) end, { desc = 'Harpoon jump #3' })
    vim.keymap.set("n", "<C-S-l>", function() harpoon:list():select(4) end, { desc = 'Harpoon jump #4' })

    -- Toggle previous & next buffers stored within Harpoon list
    -- vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
    -- vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
  end
}
