-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)


require('vim-options')
-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    { import = 'plugins' },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- automatically check for plugin updates
  checker = { enabled = true },
})


-- neo-tree
vim.keymap.set('n', '\\', ':Neotree filesystem right toggle focus<CR>', { desc = 'Reveal neo-tree on right side' })
vim.keymap.set('n', '<leader>gs', ':Neotree git_status right toggle focus<CR>', { desc = 'Reveal neo-tree git status on right side' })


-- shortcuts to move line/selection up and down using command + up/down arrow
vim.keymap.set('n', '<A-Up>', ':m .-2<CR>==', { desc = 'Move line up' })
vim.keymap.set('n', '<A-Down>', ':m .+1<CR>==', { desc = 'Move line down' })

vim.keymap.set('v', '<A-Up>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })
vim.keymap.set('v', '<A-Down>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
