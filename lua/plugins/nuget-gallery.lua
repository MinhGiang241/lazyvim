return {
  "d7omdev/nuget.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("nuget").setup({
      keys = {
        install = { "n", "<leader>ri" },
        remove = { "n", "<leader>rr" },
      },
    })
  end,
}
