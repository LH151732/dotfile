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

-- 引入 LuaSnip 插件
local luasnip = require("luasnip")

-- 加载自定义 Snippets 文件
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/my_snippets/" })
