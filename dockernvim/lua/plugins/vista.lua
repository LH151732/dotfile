return {
  {
    "liuchengxu/vista.vim",
    cmd = { "Vista" }, -- 只有在执行 :Vista 命令时加载插件
    config = function()
      vim.g.vista_default_executive = "ctags"
      vim.g.vista_sidebar_width = 30
    end,
  },
}
