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

-- 设置 F5 快捷键（水平分割）
keymap.set("n", "<F5>", function()
  execute_file("horizontal")
end, opts)
-- 设置 F6 快捷键（垂直分割）
keymap.set("n", "<F6>", function()
  execute_file("vertical")
end, opts)

-- 创建 ctags 并使用 Telescope 打开标签
vim.api.nvim_set_keymap("n", "<F1>", ":!ctags -R<CR>:Telescope tags<CR>", { noremap = true, silent = true })

keymap.set("n", "x", '"_x')
-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")
-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")
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

-- Tabs
keymap.set("n", "te", ":tabedit<Return>")
keymap.set("n", "<tab>", ":tabnext<Return>")
keymap.set("n", "<s-tab>", ":tabprev<Return>")
keymap.set("n", "tw", ":tabclose<Return>")

-- Split window
vim.keymap.set({ "n", "i" }, "<F2>", function()
  -- 打开 Glow 视图
  vim.cmd("Glow")
  -- 延迟切换焦点到 Glow 窗口，确保 Glow 视图完全加载
  vim.defer_fn(function()
    vim.cmd("wincmd p") -- 切换到上一个窗口（即 Glow 窗口）
  end, 50) -- 50 毫秒的延迟，可以根据需要调整
end, opts)

-- Split window
keymap.set({ "n", "i" }, "<F3>", '<Cmd>exe winheight(0)/3 . "split" | term<CR>')
keymap.set({ "n", "i" }, "<F4>", '<Cmd>exe winwidth(0)/2 . "vsplit" | term<CR>')

-- 跳转到有字的行首 (第一个非空白字符)
vim.api.nvim_set_keymap("n", "1", "^", { noremap = true, silent = true })

-- 跳转到行尾
vim.api.nvim_set_keymap("n", "0", "$", { noremap = true, silent = true })

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

-- Diagnostics
keymap.set("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end, opts)
