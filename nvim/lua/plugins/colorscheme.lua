return {
  -- 主题插件集合
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  
  -- 默认主题设置
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        -- 使用已经设置的主题，避免覆盖
        local theme = vim.g.colors_name
        if theme then
          vim.cmd("colorscheme " .. theme)
        end
      end,
    },
  },
}
