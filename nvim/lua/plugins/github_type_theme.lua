return {
  -- Install without configuration
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
  },

  -- Or with configuration
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 2000, -- make sure to load this before all the other start plugins
    config = function()
      require("github-theme").setup({
        options = {
          transparent = true, -- 启用透明背景
          darken = {
            floats = false, -- 浮动窗口不使用暗色背景
          },
        },
      })
      
      -- 不再直接设置 colorscheme，由主题管理器负责
    end,
  },
}
