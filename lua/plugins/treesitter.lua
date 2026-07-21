return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    local config = require('nvim-treesitter')
    config.install { 'lua', 'javascript', 'typescript', 'html', 'jsx', 'vue', 'astro', 'python' }
    -- highlighting
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { '<filetype>' },
      callback = function() vim.treesitter.start() end,
    })
    -- fold
    -- vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    -- vim.wo[0][0].foldmethod = 'expr'
    -- identation
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
}

