-- 使用 LazyVim 安装 glow.nvim
return {
  {
    "ellisonleao/glow.nvim",
    config = function()
      require("glow").setup({
        border = "rounded", -- 可选: 设置预览窗口的边框样式
        width = 120, -- 可选: 设置预览窗口的宽度
        height = 80, -- 可选: 设置预览窗口的高度
        pager = false, -- 可选: 是否使用 Glow 的分页器
      })
    end,
    cmd = "Glow", -- 使用 Glow 命令来启动预览
  },
}
