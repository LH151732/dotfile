return {
  -- 其他插件配置
  {
    "wfxr/minimap.vim",
    build = "cargo install --locked code-minimap", -- 安装 code-minimap 依赖
    cmd = { "Minimap", "MinimapToggle" }, -- 当执行这些命令时加载插件
    config = function()
      vim.g.minimap_width = 10 -- 设置 Minimap 的宽度
      vim.g.minimap_auto_start = 1 -- 启动 Neovim 时自动开启 Minimap
      vim.g.minimap_auto_start_win_enter = 1 -- 切换窗口时也自动开启 Minimap
      vim.g.minimap_highlight_range = 1
      vim.g.minimap_base_cmd = "code-minimap --horizontal-scale 2.0 --vertical-scale 1.5 --padding 2"
    end,
  },
  -- 其他插件配置
}
