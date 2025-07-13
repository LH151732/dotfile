return {
  {
    "folke/twilight.nvim",
    opts = {
      -- 以下是所有可用的配置选项及默认值
      dimming = {
        alpha = 0.25, -- 变暗程度，范围 0-1（0 完全透明，1 不变暗）
        -- 尝试从高亮组获取前景色，如果失败则使用备用颜色
        color = { "Normal", "#ffffff" },
        term_bg = "#000000", -- 如果 guibg=NONE，这将用于计算文本颜色
        inactive = false, -- 为 true 时，其他窗口将完全变暗（除非它们包含相同的缓冲区）
      },
      context = 10, -- 尝试在当前行周围显示的行数
      treesitter = true, -- 当文件类型可用时使用 treesitter
      -- treesitter 用于自动展开可见文本，
      -- 但你可以进一步控制应该始终完全展开的节点类型
      expand = { -- 对于 treesitter，总是尝试展开到具有这些类型的最顶层祖先节点
        "function",
        "method",
        "table",
        "if_statement",
      },
      exclude = {}, -- 排除这些文件类型，例如 {"markdown", "json"}
    },
    -- 配置快捷键
    keys = {
      { "<leader>tw", "<cmd>Twilight<cr>", desc = "Toggle Twilight" },
    },
    -- 或者使用 config 函数进行更复杂的设置
    -- config = function()
    --   require("twilight").setup({
    --     -- 你的配置
    --   })
    -- end,
  },
}
