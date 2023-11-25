-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

--border

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste",
})

local cmp = require("cmp")

local border = {
  { "🭽", "FloatBorder" },
  { "▔", "FloatBorder" },
  { "🭾", "FloatBorder" },
  { "▕", "FloatBorder" },
  { "🭿", "FloatBorder" },
  { "▁", "FloatBorder" },
  { "🭼", "FloatBorder" },
  { "▏", "FloatBorder" },
}

-- LSP settings (for overriding per client)
local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}

-- Do not forget to use the on_attach function
-- require("lspconfig").myserver.setup({ handlers = handlers })

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  window = {

    documentation = cmp.config.window.bordered({
      border = "single",
      winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,cursorLine:PmenuSel,Search:None",
    }),
    completion = cmp.config.window.bordered({
      border = "single",
      winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,cursorLine:PmenuSel,Search:None",
    }),
  },
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "json", "jsonc" },
  callback = function()
    vim.wo.spell = false
    vim.wo.conceallevel = 0
  end,
})

local current_window = vim.api.nvim_get_current_win()
vim.wo[current_window].wrap = true

-- local nvim_lsp = require("lspconfig")

-- local on_attach = function(client, bufnr)
--   -- other stuff --
--   require("tailwindcss-colors").buf_attach(bufnr)
-- end
--
-- nvim_lsp["tailwindcss"].setup({
--   -- other settings --
--   on_attach = on_attach,
-- })
