local keymap = vim.keymap
-- Hàm để resize terminal
local function resize_terminal(delta)
  local win_id = vim.api.nvim_get_current_win()
  local height = vim.api.nvim_win_get_height(win_id)
  vim.api.nvim_win_set_height(win_id, height + delta)
end
keymap.set("t", "<C-Up>", function()
  resize_terminal(2)
end, { noremap = true, silent = true })
keymap.set("t", "<C-Down>", function()
  resize_terminal(-2)
end, { noremap = true, silent = true })
local setup = {

  -- amongst your other plugins
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        shell = "pwsh.exe",
        shade_terminals = false,
        hightlights = {
          Normal = {
            guibg = "NONE",
            ctermbg = "NONE",
          },
          NormalFloat = {
            guibg = "NONE",
            ctermbg = "NONE",
          },
        },
      }) --C:/Windows/System32/WindowsPowerShell/v1.0/powershell.exe
    end,
  },
}

return { setup }
