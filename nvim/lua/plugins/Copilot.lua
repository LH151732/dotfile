return {
  -- Copilot 插件配置
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = true, -- 启用 Copilot 建议
        auto_trigger = false, -- 禁用自动触发补全
        debounce = 150, -- 设置建议更新的延迟
        keymap = {
          accept = false, -- 禁用 <Tab> 键接受建议
        },
      },
      panel = {
        enabled = false, -- 禁用 Copilot 面板弹窗
      },
    },
  },

  -- 禁用 copilot-cmp 插件
  {
    "zbirenbaum/copilot-cmp",
    enabled = false,
  },
}
