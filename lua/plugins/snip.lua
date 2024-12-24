return {
  "L3MON4D3/LuaSnip",
  config = function()
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node

    -- Thêm snippet cho C#
    ls.add_snippets("cs", {
      s("summary", {
        t("/// <summary>"),
        t({ "", "/// " }),
        i(1, "Description of the method/class."),
        t({ "", "/// </summary>" }),
        t({ "", "" }),
        i(0),
      }),
    })
  end,
}
