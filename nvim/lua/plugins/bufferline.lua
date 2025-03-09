return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  event = "VeryLazy",
  opts = {
    options = {
      -- 设置为 "tabs" 模式，管理标签页而不是缓冲区
      mode = "tabs",
      -- 使用默认的分隔符样式
      separator_style = "thin",
      -- 启用鼠标操作
      close_command = function(n) vim.cmd("tabclose " .. n) end,
      right_mouse_command = function(n) vim.cmd("tabclose " .. n) end,
      left_mouse_command = function(n) vim.cmd("tabn " .. n) end,
      -- 基本设置
      show_buffer_icons = true,
      show_buffer_close_icons = true,
      show_close_icon = true,
      show_tab_indicators = true,
      always_show_bufferline = true,
      diagnostics = "nvim_lsp",
    },
  },
  config = function(_, opts)
    -- 确保启用标签行显示
    vim.opt.showtabline = 2
    require("bufferline").setup(opts)
    
    -- 使用 Tab 键在普通模式下切换到下一个标签页
    vim.keymap.set("n", "<Tab>", "<cmd>tabnext<CR>", { desc = "下一个标签页" })
    vim.keymap.set("n", "<S-Tab>", "<cmd>tabprevious<CR>", { desc = "上一个标签页" })
    
    -- 使用 Ctrl + 数字键切换标签页
    vim.keymap.set("n", "<C-1>", "<cmd>tabn 1<CR>", { desc = "转到标签页 1" })
    vim.keymap.set("n", "<C-2>", "<cmd>tabn 2<CR>", { desc = "转到标签页 2" })
    vim.keymap.set("n", "<C-3>", "<cmd>tabn 3<CR>", { desc = "转到标签页 3" })
    vim.keymap.set("n", "<C-4>", "<cmd>tabn 4<CR>", { desc = "转到标签页 4" })
    vim.keymap.set("n", "<C-5>", "<cmd>tabn 5<CR>", { desc = "转到标签页 5" })
    vim.keymap.set("n", "<C-6>", "<cmd>tabn 6<CR>", { desc = "转到标签页 6" })
    vim.keymap.set("n", "<C-7>", "<cmd>tabn 7<CR>", { desc = "转到标签页 7" })
    vim.keymap.set("n", "<C-8>", "<cmd>tabn 8<CR>", { desc = "转到标签页 8" })
    vim.keymap.set("n", "<C-9>", "<cmd>tabn 9<CR>", { desc = "转到标签页 9" })
    
    -- 添加其他有用的标签页管理快捷键
    vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "新建标签页" })
    vim.keymap.set("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "关闭当前标签页" })
    vim.keymap.set("n", "<leader>to", "<cmd>tabonly<CR>", { desc = "关闭其他标签页" })
    vim.keymap.set("n", "<leader>tp", "<cmd>tabprevious<CR>", { desc = "前一个标签页" })
    vim.keymap.set("n", "<leader>tn", "<cmd>tabnext<CR>", { desc = "后一个标签页" })
    vim.keymap.set("n", "<leader>tf", "<cmd>tabfirst<CR>", { desc = "第一个标签页" })
    vim.keymap.set("n", "<leader>tl", "<cmd>tablast<CR>", { desc = "最后一个标签页" })
    vim.keymap.set("n", "<leader>tm", "<cmd>tabmove<CR>", { desc = "移动标签页" })
  end,
}
