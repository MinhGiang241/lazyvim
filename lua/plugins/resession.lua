return {
  {
    "stevearc/resession.nvim",
    config = function()
      require("resession").setup({
        autosave = {
          enabled = true,
        },
      })
    end,
  },
}
