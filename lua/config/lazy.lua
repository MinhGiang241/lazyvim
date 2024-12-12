local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins", opts = { colorscheme = "tokyonight-night" } },
    -- import any extras modules here
    -- { import = "lazyvim.plugins.extras.ui.edgy" },
    -- { import = "lazyvim.plugins.extras.editor.symbols-outline" },
    { import = "lazyvim.plugins.extras.editor.mini-files" },
    { import = "lazyvim.plugins.extras.dap.core" },
    { import = "plugins.extras.lang.flutter" },
    -- { import = "lazyvim.plugins.extras.test.core" },
    -- { import = "lazyvim.plugins.extras.util.project" },
    { import = "lazyvim.plugins.extras.ui.alpha" },
    { import = "lazyvim.plugins.extras.linting.eslint" },
    { import = "lazyvim.plugins.extras.formatting.prettier" },
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.tailwind" },
    { import = "lazyvim.plugins.extras.lang.omnisharp" },
    { import = "lazyvim.plugins.extras.lang.json" },
    -- { import = "lazyvim.plugins.extras.coding.copilot" },
    { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
    { import = "lazyvim.plugins.extras.coding.mini-surround" },
    -- { import = "lazyvim.plugins.extras.lang.kotlin" },
    { import = "lazyvim.plugins.extras.lang.java" },
    -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
    { import = "lazyvim.plugins.extras.coding.mini-surround" },
    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "catppuccin-mocha", "nighfly", "tokyonight", "habamax" } },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

require("neo-tree").setup({
  filesystem = {
    window = {
      mappings = {
        ["<leader>h"] = "image_wezterm", -- " or another map
      },
    },
    commands = {
      image_wezterm = function(state)
        local node = state.tree:get_node()
        if node.type == "file" then
          require("image_preview").PreviewImage(node.path)
        end
      end,
    },
  },
})

local picker = require("window-picker")

vim.keymap.set("n", ",w", function()
  local picked_window_id = picker.pick_window({
    include_current_win = true,
  }) or vim.api.nvim_get_current_win()
  vim.api.nvim_set_current_win(picked_window_id)
end, { desc = "Pick a window" })

-- Colorscheme
vim.cmd([[colorscheme base16-catppuccin-mocha]])

vim.diagnostic.config({
  float = {
    border = "rounded", -- Kiểu viền: 'none', 'single', 'double', 'rounded', 'solid', 'shadow'
  },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded", -- Kiểu viền: 'none', 'single', 'double', 'rounded', 'solid', 'shadow'
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded", -- Kiểu viền: 'none', 'single', 'double', 'rounded', 'solid', 'shadow'
})

-- vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#FFD700" })
-- vim.api.nvim_set_hl(0, "NormalFloatBorder", { bg = "#FFD700" })
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
-- local handlers = {
--   ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
--   ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
-- }
--
-- Do not forget to use the on_attach function
-- require("lspconfig").myserver.setup({ handlers = handlers })

vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#FF5733" }) -- Màu viền cho toàn bộ cửa sổ Telescope
vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = "#A3BE8C" }) -- Màu viền cho cửa sổ Prompt
vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = "#5E81AC" }) -- Màu viền cho cửa sổ Results
vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { bg = "#F9E9E9", fg = "#000000" }) -- Màu viền cho cửa sổ Results
vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = "#BF616A" }) -- Màu viền cho cửa sổ Preview

vim.api.nvim_set_hl(0, "MasonNormal", { fg = "#FFFFFF", bg = "#2E3440" }) -- Màu nền cho Mason
vim.api.nvim_set_hl(0, "MasonBorder", { fg = "#88C0D0", bg = "NONE" }) -- Màu viền cho cửa sổ Mason
vim.api.nvim_set_hl(0, "MasonHeading", { fg = "#A3BE8C", bg = "NONE" }) -- Màu tiêu đề

local cmp = require("cmp")
cmp.setup({
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
})

-- color documentation border
vim.api.nvim_set_hl(0, "CmpDocBorder", { fg = "#FFFFFF" })

-- color menu autocompletion border
vim.api.nvim_set_hl(0, "CmpMenuBorder", { fg = "#FFFFFF" })

-- local api = vim.api
-- local diagnostic = vim.diagnostic
--
-- api.nvim_create_autocmd("CursorHold", {
--   buffer = bufnr,
--   callback = function()
--     local float_opts = {
--       focusable = false,
--       close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
--       border = "rounded",
--       source = "always", -- show source in diagnostic popup window
--       prefix = " ",
--     }
--
--     if not vim.b.diagnostics_pos then
--       vim.b.diagnostics_pos = { nil, nil }
--     end
--
--     local cursor_pos = api.nvim_win_get_cursor(0)
--     if
--       (cursor_pos[1] ~= vim.b.diagnostics_pos[1] or cursor_pos[2] ~= vim.b.diagnostics_pos[2])
--       and #diagnostic.get() > 0
--     then
--       diagnostic.open_float(nil, float_opts)
--     end
--
--     vim.b.diagnostics_pos = cursor_pos
--   end,
-- })
