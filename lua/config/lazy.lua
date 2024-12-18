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
    { "LazyVim/LazyVim", import = "lazyvim.plugins", opts = { colorscheme = "base16-tokyo-city-terminal-dark" } },
    -- import any extras modules here
    { import = "lazyvim.plugins.extras.editor.outline" },
    { import = "lazyvim.plugins.extras.editor.mini-files" },
    { import = "lazyvim.plugins.extras.editor.aerial" },
    { import = "lazyvim.plugins.extras.dap.core" },
    { import = "plugins.extras.lang.flutter" },
    { import = "lazyvim.plugins.extras.ui.alpha" },
    { import = "lazyvim.plugins.extras.linting.eslint" },
    { import = "lazyvim.plugins.extras.formatting.prettier" },
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.tailwind" },
    { import = "lazyvim.plugins.extras.lang.omnisharp" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.coding.luasnip" },
    { import = "lazyvim.plugins.extras.editor.fzf" },
    { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
    { import = "lazyvim.plugins.extras.coding.mini-surround" },
    { import = "lazyvim.plugins.extras.lang.java" },
    { import = "lazyvim.plugins.extras.coding.neogen" },
    -- { import = "lazyvim.plugins.extras.ui.edgy" },
    -- { import = "lazyvim.plugins.extras.test.core" },
    -- { import = "lazyvim.plugins.extras.util.project" },
    -- { import = "lazyvim.plugins.extras.coding.blink" },
    -- { import = "lazyvim.plugins.extras.editor.telescope" },
    -- { import = "lazyvim.plugins.extras.ui.edgy" },
    -- { import = "lazyvim.plugins.extras.coding.copilot" },
    -- { import = "lazyvim.plugins.extras.lang.kotlin" },
    -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
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

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded", -- Chọn viền hình tròn cho popup
})

vim.api.nvim_set_hl(0, "MasonNormal", { fg = "#FFFFFF", bg = "#0c190c" }) -- Màu nền cho Mason
vim.api.nvim_set_hl(0, "MasonBorder", { fg = "#88C0D0", bg = "NONE" }) -- Màu viền cho cửa sổ Mason
vim.api.nvim_set_hl(0, "MasonHeading", { fg = "#A3BE8C", bg = "NONE" }) -- Màu tiêu đề
vim.api.nvim_set_hl(0, "LspInfoBorder", { fg = "#FFFFFF" })
-- vim.api.nvim_set_hl(0, "LspInfoNormal", { bg = "#2E3440" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#0c190c" })
-- vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#FFFFFF" })
vim.api.nvim_set_hl(0, "Pmenu", { bg = "#0c190c" })
vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE" })
--TroubleIndentWs links to LineNr
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
