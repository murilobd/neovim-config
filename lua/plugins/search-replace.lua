return {
  "MagicDuck/grug-far.nvim",
  config = true,
  keys = {
    {
      "<leader>sr",
      function()
        require("grug-far").open()
      end,
      desc = "Search and replace project",
    },
  }
}
