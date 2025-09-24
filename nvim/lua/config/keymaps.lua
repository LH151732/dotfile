-- API列表
-- Author: HL
-- Date: 12/05/2025
--
-- 功能键映射:
-- F1: 创建 ctags 并使用 Telescope 打开
-- Ctrl+F1: 在新标签页中创建 ctags 并使用 Telescope 打开
-- F2: 水平分割打开 claude
-- Shift+F2: 垂直分割打开 claude
-- Ctrl+F2: 在新标签页中打开 claude
-- F4: 水平分割打开终端
-- Shift+F4: 垂直分割打开终端
-- Ctrl+F4: 在新标签页中打开终端
--
-- 光标移动:
-- Ctrl+左/右: 在单词间跳转
-- Ctrl+E: 移动到行尾
-- 1: 跳转到行首第一个非空白字符
-- 0: 跳转到行尾
--
-- 窗口管理:
-- sh/sk/sj/sl: 在窗口间移动
-- Alt+Ctrl+左/右/上/下: 调整窗口大小 (n/i 模式)
--
-- 更多键位映射详见下文

--------------------------------------------------------------------------------
-- 基础设置
--------------------------------------------------------------------------------
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

--------------------------------------------------------------------------------
-- 辅助函数
--------------------------------------------------------------------------------

-- 获取Python解释器路径（支持虚拟环境）
local function get_python_interpreter()
  -- 使用激活的虚拟环境
  if vim.env.VIRTUAL_ENV then
    return vim.env.VIRTUAL_ENV .. "/bin/python"
  end

  -- 检查项目根目录的.venv
  local root_dir = vim.fn.getcwd()
  local venv_python = root_dir .. "/.venv/bin/python"
  if vim.fn.executable(venv_python) == 1 then
    return venv_python
  end

  -- 尝试使用uv python find
  local uv_python = vim.fn.system("uv python find 2>/dev/null"):gsub("\n", "")
  if vim.fn.executable(uv_python) == 1 then
    return uv_python
  end

  -- 默认系统Python
  return "python"
end

-- 执行当前文件
local function execute_file(split_type)
  local file_extension = vim.fn.expand("%:e")
  local commands = {
    java = "java",
    sh = "bash",
    py = get_python_interpreter(), -- 使用虚拟环境的Python
    md = "frogmouth",
    markdown = "frogmouth", -- 支持 .markdown 扩展名
  }
  local cmd = commands[file_extension]
  if cmd then
    local filename = vim.fn.expand("%:t")
    local split_cmd
    if split_type == "horizontal" then
      split_cmd = string.format("exe 'belowright ' . winheight(0)/3 . ' split'")
    elseif split_type == "vertical" then
      split_cmd = string.format("exe 'belowright ' . winwidth(0)/2 . ' vsplit'")
    else -- tab
      split_cmd = "tabnew"
    end
    vim.cmd(string.format("%s | terminal %s %s", split_cmd, cmd, filename))

    -- 只有 Markdown 文件（使用 frogmouth）时才自动关闭窗口
    if file_extension == "md" or file_extension == "markdown" then
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
    end

    -- 进入插入模式，让用户可以直接与程序交互
    vim.cmd("startinsert")
  else
    print("Unsupported file type")
  end
end

-- 删除 tags 文件
local function delete_tags_file()
  local tags_path = vim.fn.getcwd() .. "/tags"
  if vim.fn.filereadable(tags_path) == 1 then
    vim.fn.delete(tags_path)
    print("Deleted tags file: " .. tags_path)
  end
end

--------------------------------------------------------------------------------
-- 功能键映射 (F1-F4)
--------------------------------------------------------------------------------

-- F1: 创建 ctags 并使用 Telescope 打开标签
local builtin = require("telescope.builtin")
vim.api.nvim_set_keymap("n", "<F1>", ":!ctags -R --exclude=.venv --exclude=venv --exclude=node_modules --exclude=.git<CR>:Telescope tags<CR>", { noremap = true, silent = true })

-- Ctrl+F1: 在新标签页中创建 ctags 并使用 Telescope 打开
vim.api.nvim_set_keymap(
  "n",
  "<C-F1>",
  ":tabnew<CR>:!ctags -R --exclude=.venv --exclude=venv --exclude=node_modules --exclude=.git<CR>:Telescope tags<CR>",
  { noremap = true, silent = true }
)

-- F2: 开始/继续调试 (nvim-dap)
-- F3: PeekOpen 预览定义
keymap.set("n", "<F3>", function()
  require("telescope.builtin").lsp_definitions()
end, { desc = "PeekOpen" })

-- F4: 打开终端
keymap.set("n", "<F4>", '<Cmd>exe winheight(0)/3 . "split" | term<CR>')
keymap.set("n", "<S-F4>", '<Cmd>exe winwidth(0)/2 . "vsplit" | term<CR>')

-- Ctrl+F4: 在新标签页中打开终端
keymap.set("n", "<C-F4>", "<Cmd>tabnew | term<CR>")

--------------------------------------------------------------------------------
-- 窗口管理
--------------------------------------------------------------------------------

-- Alt+Ctrl+方向键调整窗口大小 (normal 和 insert 模式)
keymap.set("n", "<M-C-Left>", "<C-w>>", opts)
keymap.set("n", "<M-C-Right>", "<C-w><", opts)
keymap.set("n", "<M-C-Up>", "<C-w>+", opts)
keymap.set("n", "<M-C-Down>", "<C-w>-", opts)

keymap.set("i", "<M-C-Left>", "<C-o><C-w>>", opts)
keymap.set("i", "<M-C-Right>", "<C-o><C-w><", opts)
keymap.set("i", "<M-C-Up>", "<C-o><C-w>+", opts)
keymap.set("i", "<M-C-Down>", "<C-o><C-w>-", opts)

--------------------------------------------------------------------------------
-- 光标移动和编辑
--------------------------------------------------------------------------------

-- 行首行尾跳转
vim.api.nvim_set_keymap("n", "1", "^", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "1", "^", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "0", "$", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "0", "$", { noremap = true, silent = true })

-- 移动到行尾
keymap.set("n", "<C-e>", "$", opts)
keymap.set("v", "<C-e>", "$", opts)
keymap.set("i", "<C-e>", "<C-o>$", opts)

-- 在单词间跳转
keymap.set("n", "<C-Left>", "b", opts) -- 向后跳转一个单词
keymap.set("n", "<C-Right>", "w", opts) -- 向前跳转一个单词

-- 删除但不保存到寄存器
keymap.set("n", "x", '"_x')

-- 全选
keymap.set("n", "<C-a>", "gg<S-v>G")

-- 删除从光标到行尾
keymap.set("i", "<C-k>", "<C-o>D", opts)

-- 增减数字
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

--------------------------------------------------------------------------------
-- 搜索相关
--------------------------------------------------------------------------------

-- 向前向后查找
keymap.set("n", "<C-f>", "/", opts)
keymap.set("i", "<C-f>", "<C-o>/", opts)
keymap.set("n", "<C-b>", "?", opts)
keymap.set("i", "<C-b>", "<C-o>?", opts)

-- 搜索结果导航
keymap.set("n", "<C-n>", "n", opts)
keymap.set("i", "<C-n>", "<C-o>n", opts)
keymap.set("n", "<C-p>", "N", opts)
keymap.set("i", "<C-p>", "<C-o>N", opts)

--------------------------------------------------------------------------------
-- 滚动
--------------------------------------------------------------------------------

-- 半页滚动
keymap.set("n", "<C-d>", "<C-d>", opts)
keymap.set("i", "<C-d>", "<C-o><C-d>", opts)
keymap.set("n", "<C-u>", "<C-u>", opts)
keymap.set("i", "<C-u>", "<C-o><C-u>", opts)

--------------------------------------------------------------------------------
-- 插入模式映射
--------------------------------------------------------------------------------

-- 光标移到行首
keymap.set("i", "<C-a>", "<C-o>^", opts)

-- 在当前行下方插入新行
keymap.set("i", "<C-l>", "<C-o>o", opts)

-- 删除操作
keymap.set("i", "<C-w>", "<C-\\><C-o>db", opts) -- 删除光标前的一个单词
keymap.set("i", "<C-u>", "<C-\\><C-o>d0", opts) -- 删除光标前的整行内容
keymap.set("i", "<C-h>", "<BS>", opts) -- 删除光标前的一个字符

-- Tab缩进
keymap.set("i", "<C-t>", "<C-\\><C-o>>>", opts) -- 增加缩进
-- keymap.set("i", "<C-d>", "<C-\\><C-o><<", opts)   -- 减少缩进(与滚动半页冲突)

--------------------------------------------------------------------------------
-- 文件和会话管理
--------------------------------------------------------------------------------

-- 保存和退出
keymap.set("n", "<Leader>w", ":update<Return>", opts)
keymap.set("n", "<Leader>q", ":quit<Return>", opts)
keymap.set("n", "<Leader>Q", ":qa<Return>", opts)

--------------------------------------------------------------------------------
-- 自动命令
--------------------------------------------------------------------------------

-- 退出 Neovim 时删除 tags 文件
vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    delete_tags_file()
  end,
})
