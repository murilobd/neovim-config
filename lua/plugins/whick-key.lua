return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    delay = 0,
    icons = { mappings = vim.g.have_nerd_font },
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
