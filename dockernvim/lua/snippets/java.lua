-- ~/.config/nvim/lua/snippets/java.lua

-- 首先，导入 LuaSnip 和 snippet 函数
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- 接下来，返回具体的片段
return {
  s("sysf", {
    t("System.out.printf("),
    i(1), -- 第一占位符
    t(");"),
  }),
}
