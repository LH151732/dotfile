local ls = require("luasnip") -- 加载 LuaSnip 模块
local s = ls.snippet -- 编写快捷方式 `s`，代表 `snippet`
local i = ls.insert_node -- 插入节点 `i` 表示可编辑位置
local t = ls.text_node -- 插入文本 `t`

-- 定义 Java 语言的 Snippet
ls.add_snippets("java", {
  -- Snippet: 当触发 `sysf` 时插入 `System.out.printf();` 这个模板
  s("sysf", {
    t("System.out.printf("), -- 插入文本 "System.out.printf("
    i(1, ""), -- 第一个可编辑位置，比如格式字符串
    t(");"), -- 插入文本 ");"
  }),
})
