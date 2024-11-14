-- set leader
vim.g.mapleader = ","

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- 启用鼠标支持
vim.o.mouse = "a"

-- 设置长行截断显示
vim.o.wrap = true
vim.o.linebreak = true
vim.o.showbreak = ">"

vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
vim.cmd("highlight FloatBorder guibg=NONE ctermbg=NONE")
vim.cmd("highlight TelescopeNormal guibg=NONE")
vim.cmd("highlight TelescopeBorder guibg=NONE")

local ls = require("luasnip")

-- 加载 `snippets` 文件夹中的所有 Lua 文件
local snippet_path = vim.fn.stdpath("config") .. "/lua/snippets/"
for _, file in ipairs(vim.fn.readdir(snippet_path)) do
  local lang = file:match("(.+)%.lua$")
  if lang then
    ls.add_snippets(lang, dofile(snippet_path .. file))
  end
end
