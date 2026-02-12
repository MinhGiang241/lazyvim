local cs = {
  { "Hoffs/omnisharp-extended-lsp.nvim", lazy = true },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "c_sharp" })
      end
    end,
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        cs = { "omnisharp" },
      },
      formatters = {
        omnisharp = {
          command = "dotnet-format",
          args = { "--stdin" },
          stdin = true,
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        omnisharp = {
          handlers = {
            ["textDocument/definition"] = function(...)
              return require("omnisharp_extended").handler(...)
            end,
          },
          keys = {
            {
              "gd",
              function()
                require("omnisharp_extended").telescope_lsp_definitions()
              end,
              desc = "Goto Definition",
            },
          },
          enable_roslyn_analyzers = false,
          organize_imports_on_format = true,
          enable_import_completion = true,
        },
      },
    },
  },
}

return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        cs = { "lsp" },
      },
    },
  },
  {
    "seblyng/roslyn.nvim",
    ft = "cs",
    opts = {
      -- config nếu cần (để trống dùng mặc định)
      filewatching = "off", -- tuỳ chọn để giảm lag nếu project lớn
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        roslyn = {
          -- không cần cmd nếu Mason đã cài và PATH đúng
        },
        omnisharp = false, -- disable nó đi
      },
    },
  },
}
