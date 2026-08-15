return {
  {
  'nvim-telescope/telescope.nvim', version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- optional but recommended
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  config = function()
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<D-p>', builtin.find_files, { desc = '[CMD + p] Telescope find files' })
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[ ff] Telescope find files' })
    vim.keymap.set('n', '<D-S-f>', builtin.live_grep, { desc = '[CMD + SHIFT + f] Telescope live grep' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[ fg] Telescope live grep' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[  ] Find existing buffers' })
  end
},
{
  "nvim-telescope/telescope-ui-select.nvim",
  config = function()
    require("telescope").setup {
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown {
          }
        }
      }
    }
    require("telescope").load_extension("ui-select")
  end
  }
}
