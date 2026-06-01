local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

ls.add_snippets("cs", {
  s("log", {
    t("Console.WriteLine("),
    i(1, '""'),
    t(");"),
  }),
})
