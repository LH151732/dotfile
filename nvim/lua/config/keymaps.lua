local keymap = vim.keymap
local opts = { noremap = true, silent = true }

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

-- Tabs
--keymap.set("n", "te", ":tabedit<Return>")
--keymap.set("n", "<tab>", ":tabnext<Return>")
--keymap.set("n", "<s-tab>", ":tabprev<Return>")
--keymap.set("n", "tw", ":tabclose<Return>")
vim.keymap.set("i", "<C-Y>", function()
  return vim.fn["copilot#Accept"]("<CR>")
end, { silent = true, expr = true })

-- Split window
vim.keymap.set({ "n", "i" }, "<F2>", function()
  -- 打开 Glow 视图
  vim.cmd("Glow")

  -- 延迟切换焦点到 Glow 窗口，确保 Glow 视图完全加载
  vim.defer_fn(function()
    vim.cmd("wincmd p") -- 切换到上一个窗口（即 Glow 窗口）
  end, 50) -- 50 毫秒的延迟，可以根据需要调整
end, { noremap = true, silent = true })
keymap.set({ "n", "i" }, "<F3>", '<Cmd>exe winheight(0)/3 . "split" | term<CR>')
keymap.set({ "n", "i" }, "<F4>", '<Cmd>exe winwidth(0)/2 . "vsplit" | term<CR>')
keymap.set({ "n", "i" }, "<F5>", '<Cmd>exe winheight(0)/3 . "split" | term python %<CR>')
keymap.set({ "n", "i" }, "<F6>", '<Cmd>exe winwidth(0)/2 . "vsplit" | term python %<CR>')

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
