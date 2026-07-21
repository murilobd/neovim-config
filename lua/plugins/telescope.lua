return {
  'nvim-telescope/telescope.nvim', version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- optional but recommended
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  configuration = function()
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<D-p>', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<D-S-f>', builtin.live_grep, { desc = 'Telescope live grep' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
  end
}

