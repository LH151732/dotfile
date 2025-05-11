-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

local function execute_file(split_type)
  local file_extension = vim.fn.expand("%:e")
  local commands = {
    java = "java",
    sh = "bash",
    py = "python",
  }
  local cmd = commands[file_extension]
  if cmd then
    local filename = vim.fn.expand("%:t")
    local split_cmd
    if split_type == "horizontal" then
      split_cmd = string.format("exe 'belowright ' . winheight(0)/3 . ' split'")
    else
      split_cmd = string.format("exe 'belowright ' . winwidth(0)/2 . ' vsplit'")
    end
    vim.cmd(string.format("%s | terminal %s %s", split_cmd, cmd, filename))
  else
    print("Unsupported file type")
  end
end

-- 设置 F2 快捷键
keymap.set("n", "<F2>", function()
  execute_file("horizontal")
end, opts)
-- 设置 F2 快捷键
keymap.set("n", "<S-F2>", function()
  execute_file("vertical")
end, opts)

-- Split window
keymap.set({ "n", "i" }, "<F3>", '<Cmd>exe winheight(0)/3 . "split" | term<CR>')
keymap.set({ "n", "i" }, "<S-F3>", '<Cmd>exe winwidth(0)/2 . "vsplit" | term<CR>')

-- 创建 ctags 并使用 Telescope 打开标签
-- 定义快捷键，创建 ctags 并使用 Telescope 打开标签

local builtin = require("telescope.builtin")

vim.api.nvim_set_keymap("n", "<F1>", ":!ctags -R<CR>:Telescope tags<CR>", { noremap = true, silent = true })

-- 定义一个函数用于删除 tags 文件
local function delete_tags_file()
  local tags_path = vim.fn.getcwd() .. "/tags"
  if vim.fn.filereadable(tags_path) == 1 then
    vim.fn.delete(tags_path)
    print("Deleted tags file: " .. tags_path)
  end
end
-- 使用 autocmd 在退出 Neovim 时删除 tags 文件
vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    delete_tags_file()
  end,
})
keymap.set("n", "x", '"_x')
-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")
-- Select all (保留原有的全选功能)
keymap.set("n", "<C-a>", "gg<S-v>G")
-- 插入模式下，将光标移到行首
keymap.set("i", "<C-a>", "<C-o>^", opts)
-- Save file and quit
keymap.set("n", "<Leader>w", ":update<Return>", opts)
keymap.set("n", "<Leader>q", ":quit<Return>", opts)
keymap.set("n", "<Leader>Q", ":qa<Return>", opts)

-- Lua function to jump backwards to the end of the previous word
local function backward_to_word_end()
  local current_pos = vim.fn.col(".")
  vim.cmd("normal! ge")
  if vim.fn.col(".") >= current_pos then
    vim.cmd("normal! b")
  end
end

-- Map 'q' to the custom function
vim.api.nvim_set_keymap("n", "q", "", { noremap = true, callback = backward_to_word_end, silent = true })
vim.api.nvim_set_keymap("v", "q", "", { noremap = true, callback = backward_to_word_end, silent = true })

-- 跳转到有字的行首 (第一个非空白字符)
vim.api.nvim_set_keymap("n", "1", "^", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "1", "^", { noremap = true, silent = true })

-- 跳转到行尾
vim.api.nvim_set_keymap("n", "0", "$", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "0", "$", { noremap = true, silent = true })

-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-S-h>", "<C-w><")
keymap.set("n", "<C-S-l>", "<C-w>>")
keymap.set("n", "<C-S-k>", "<C-w>+")
keymap.set("n", "<C-S-j>", "<C-w>-")

-- 光标移动控制键
-- Move to end of line with Ctrl+E (移动到行尾)
keymap.set("n", "<C-e>", "$", opts)
keymap.set("v", "<C-e>", "$", opts)
keymap.set("i", "<C-e>", "<C-o>$", opts)

-- 其他常用控制键
-- Ctrl+F (向前查找)
keymap.set("n", "<C-f>", "/", opts)
keymap.set("i", "<C-f>", "<C-o>/", opts)

-- Ctrl+B (向后查找)
keymap.set("n", "<C-b>", "?", opts)
keymap.set("i", "<C-b>", "<C-o>?", opts)

-- Ctrl+D (向下滚动半页)
keymap.set("n", "<C-d>", "<C-d>", opts)
keymap.set("i", "<C-d>", "<C-o><C-d>", opts)

-- Ctrl+U (向上滚动半页)
keymap.set("n", "<C-u>", "<C-u>", opts)
keymap.set("i", "<C-u>", "<C-o><C-u>", opts)

-- Ctrl+K (删除从光标到行尾)
keymap.set("n", "<C-k>", "D", opts)
keymap.set("i", "<C-k>", "<C-o>D", opts)

-- Ctrl+N (下一个搜索结果)
keymap.set("n", "<C-n>", "n", opts)
keymap.set("i", "<C-n>", "<C-o>n", opts)

-- Ctrl+P (上一个搜索结果)
keymap.set("n", "<C-p>", "N", opts)
keymap.set("i", "<C-p>", "<C-o>N", opts)

-- Diagnostics
keymap.set("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end, opts)

-- 插入模式下的快捷键
-- Ctrl-l: 在当前行下方插入新行（相当于n模式下的o命令）
keymap.set("i", "<C-l>", "<C-o>o", opts)

-- Ctrl-w: 删除光标前的一个单词
keymap.set("i", "<C-w>", "<C-\\><C-o>db", opts)

-- Ctrl-u: 删除光标前的整行内容（到行首）
keymap.set("i", "<C-u>", "<C-\\><C-o>d0", opts)

-- Ctrl-h: 删除光标前的一个字符（相当于退格键）
keymap.set("i", "<C-h>", "<BS>", opts)

-- Ctrl-t: 增加当前光标所在位置的Tab缩进
keymap.set("i", "<C-t>", "<C-\\><C-o>>>", opts)

-- Ctrl-d: 减少当前光标所在位置的Tab缩进
keymap.set("i", "<C-d>", "<C-\\><C-o><<", opts)

-- F4: 水平打开 claude 进程
keymap.set("n", "<F4>", function()
  -- 计算窗口高度的1/3作为新窗口的高度
  local height = vim.fn.winheight(0) / 3
  -- 在下方创建一个新的水平分割窗口并运行 claude
  vim.cmd(string.format("belowright %d split | terminal claude", height))
  -- 设置当终端进程退出时自动关闭窗口
  vim.opt_local.bufhidden = "wipe"
  -- 使用 TermClose 事件在终端关闭时自动关闭窗口
  vim.api.nvim_create_autocmd("TermClose", {
    buffer = 0,
    callback = function()
      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(0) then
          vim.cmd("close")
        end
      end)
    end,
  })
  -- 进入插入模式，让用户可以直接与 claude 交互
  vim.cmd("startinsert")
end, { desc = "Open claude in horizontal split" })
