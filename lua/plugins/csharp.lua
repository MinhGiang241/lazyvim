local cs=  
 {
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

return cs 
