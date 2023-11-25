-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.winbar = "%=%m %f"
vim.opt_local.wrap = true

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

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
  close_events = { "BufHidden", "InsertLeave" },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])
