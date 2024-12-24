-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local discipline = require("user.discipline")
local wk = require("which-key")
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Coding
keymap.set("v", "D", '"_d')

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a waord backwards
keymap.set("n", "dw", "vbd")

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- New tab
keymap.set("n", "te", ":tabedit", opts)
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)

-- Split Window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Move Window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Toggleterm
keymap.set("n", "tt", "<cmd>ToggleTerm<cr>", opts)
keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)
for i = 1, 10 do
  keymap.set("n", "tt" .. i, "<cmd>ToggleTerm " .. i .. "<cr>", opts)
end

-- Diagnostics
keymap.set("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end)

-- projects
wk.add(
  { "<leader>p", "<cmd>Telescope projects<cr>", desc = "Find Projects", mode = "n" }

  --   {
  --   p = { "<cmd>Telescope projects<cr>", "projects", noremap = false },
  --   prefix = "<leader>",
  -- }
)
wk.add({ "<leader>so", "<cmd>FzfLua oldfiles<cr>", desc = "Recent Files", mode = "n" })

wk.add({ "<leader>sh", "<cmd>FzfLua oldfiles<cr>", desc = "Help Doc", mode = "n" })

wk.add({ "<leader>cp", "<cmd>CccPick<cr>", desc = "Pick color", mode = "n" })

wk.add({ "<leader>cv", "<cmd>CccConvert<cr>", desc = "Convert color", mode = "v" })
