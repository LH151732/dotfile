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
