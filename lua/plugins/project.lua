-- projects
local wk = require("which-key")
wk.add(
  { "<leader>p", "<cmd>Telescope projects<cr>", desc = "Find File", mode = "n" }

  --   {
  --   p = { "<cmd>Telescope projects<cr>", "projects", noremap = false },
  --   prefix = "<leader>",
  -- }
)
wk.add({ "<leader>sh", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files", mode = "n" })

return {
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  },
}
