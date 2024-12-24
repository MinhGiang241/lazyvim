return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        -- for friendly snippets
        require("luasnip.loaders.from_vscode").lazy_load()
        -- for custom snippets
        require("luasnip.loaders.from_vscode").lazy_load({
          paths = vim.fn.stdpath("config") .. "/snippets/",
        })
      end,
    },
    config = function()
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node
      local cmp = require("cmp")

      ls.add_snippets("all", {
        s("hi", {
          t("hello, world"),
        }),
      })
      -- Thêm snippet cho C#
      -- ls.add_snippets("cs", {
      --   s("summary", {
      --     t("/// <summary>"),
      --     t({ "", "/// " }),
      --     i(1, "Description of the method/class."),
      --     t({ "", "/// </summary>" }),
      --     t({ "", "" }),
      --     i(0),
      --   }),
      -- })
      -- Cấu hình nvim-cmp
    end,
  },
  {
    "garymjr/nvim-snippets",
    keys = {
      {
        "<Tab>",
        function()
          if vim.snippet.active({ direction = 1 }) then
            vim.schedule(function()
              vim.snippet.jump(1)
            end)
            return
          end
          return "<Tab>"
        end,
        expr = true,
        silent = true,
        mode = "i",
      },
      {
        "<Tab>",
        function()
          vim.schedule(function()
            vim.snippet.jump(1)
          end)
        end,
        expr = true,
        silent = true,
        mode = "s",
      },
      {
        "<S-Tab>",
        function()
          if vim.snippet.active({ direction = -1 }) then
            vim.schedule(function()
              vim.snippet.jump(-1)
            end)
            return
          end
          return "<S-Tab>"
        end,
        expr = true,
        silent = true,
        mode = { "i", "s" },
      },
    },
  },
}
