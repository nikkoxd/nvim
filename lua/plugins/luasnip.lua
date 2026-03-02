return {
  "L3MON4D3/LuaSnip",
  config = function()
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node

    ls.add_snippets("markdown", {
      s("meta", {
        t({ "---", "" }),
        t("title: "),
        i(1, "Title"),
        t({ "", "lang: ru", "geometry: margin=2cm", "mainfont: Liberation Sans", "---" }),
      }),
    })
  end,
}
