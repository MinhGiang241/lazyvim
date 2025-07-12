-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

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

-- Toggleterm
keymap.set("n", "tt", "<cmd>ToggleTerm<cr>", opts)
keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)
for i = 1, 10 do
  keymap.set("n", "tt" .. i, "<cmd>ToggleTerm " .. i .. "<cr>", opts)
end

wk.add({ "<leader>p", "<cmd>Telescope projects<cr>", desc = "Find Project", mode = "n" })

wk.add({ "<leader>so", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files", mode = "n" })

wk.add({ "gq", "<cmd>:Telescope lsp_references<cr>", desc = "All Referrences", mode = "n" })

wk.add({ "<leader>cp", "<cmd>CccPick<cr>", desc = "Pick color", mode = "n" })

wk.add({ "<leader>cv", "<cmd>CccConvert<cr>", desc = "Convert color", mode = "v" })

wk.add({ "<leader>i", "<cmd>:lua require('nvim-window').pick()<CR>", desc = "Pick window", mode = "n" })
