-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

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
vim.api.nvim_create_user_command("Bgon", function()
  vim.cmd([[colorscheme base16-outrun-dark]])
end, {})

vim.api.nvim_create_user_command("Bgoff", function()
  vim.cmd([[
    highlight Normal guibg=NONE ctermbg=NONE
    highlight NonText guibg=NONE ctermbg=NONE
    highlight NormalNC guibg=NONE ctermbg=NONE
    highlight LineNr guibg=NONE ctermbg=NONE
    highlight NvimTreeNormal guibg=NONE ctermbg=NONE
    highlight NvimTreeNormalNC guibg=NONE ctermbg=NONE
    highlight NeoTreeGitModified guibg=NONE ctermbg=NONE
    highlight NeoTreeNormal guibg=NONE ctermbg=NONE
    highlight NeoTreeNormalNC guibg=NONE ctermbg=NONE
    highlight NeoTreeNormalFloat guibg=NONE ctermbg=NONE
    highlight Normal guibg=NONE ctermbg=NONE
    highlight NormalNC guibg=NONE ctermbg=NONE
    highlight NormalFloat guibg=NONE ctermbg=NONE
  ]])
end, {})

vim.cmd([[
  Bgoff
  autocmd FileType cs setlocal commentstring=//\ %s
]])

vim.api.nvim_create_user_command("Sms", function()
  require("lspconfig").omnisharp.setup({
    root_dir = function(fname)
      return require("lspconfig").util.root_pattern("*.csproj")(fname) or vim.loop.cwd() -- <== fallback về đúng thư mục bạn `nvim` . vào!
    end,
  })
end, {})

local function generate_uuid()
  local uuid = vim.fn.system('powershell.exe -command "[guid]::NewGuid().ToString()"'):gsub("\r?\n", "")
  return uuid
end

vim.api.nvim_create_user_command("Uuid", function()
  local uuid = generate_uuid()
  vim.api.nvim_put({ uuid }, "c", true, true)
end, {})

-- Lưu handler gốc
local orig_handler = vim.lsp.handlers["workspace/didChangeWatchedFiles"]

-- Trạng thái
vim.g.lsp_filewatcher_enabled = false

-- Hàm tắt
local function disable_filewatcher()
  vim.lsp.handlers["workspace/didChangeWatchedFiles"] = function() end
  vim.g.lsp_filewatcher_enabled = false
  print("LSP file watcher: OFF")
end

-- Hàm bật
local function enable_filewatcher()
  vim.lsp.handlers["workspace/didChangeWatchedFiles"] = orig_handler
  vim.g.lsp_filewatcher_enabled = true
  print("LSP file watcher: ON")
end

-- Hàm toggle
function ToggleLspFileWatcher()
  if vim.g.lsp_filewatcher_enabled then
    disable_filewatcher()
  else
    enable_filewatcher()
  end
end

-- Mặc định: tắt
disable_filewatcher()
