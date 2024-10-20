return {
  -- Highlight colors
  {
    "echasnovski/mini.hipatterns",
    event = "BufReadPre",
    opts = {},
  },
  -- Rose Pine theme
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false, -- 立即加载
    priority = 1000, -- 确保优先应用
    opts = {
      dark_variant = "main", -- 可选: 'main', 'moon', 'dawn'
      bold_vert_split = false,
      dim_nc_background = false,
      disable_background = true, -- 启用透明背景
      disable_float_background = true,
      disable_italics = true,
      -- 自定义高亮设置
      on_highlights = function(hl, c)
        hl.Comment = { fg = "#FFB7C5", italic = true } -- 樱花粉注释
      end,
    },
    config = function(_, opts)
      require("rose-pine").setup(opts)
      vim.cmd([[colorscheme rose-pine]]) -- 设置为 Rose Pine 主题
    end,
  },
  -- Telescope configuration
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      -- 移除背景颜色
      vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "NONE" })
      -- 设置边框为白色
      vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "NONE", fg = "#ffffff" })

      -- 这里是你的 Telescope 其他配置
      require("telescope").setup({
        defaults = {
          -- 你的其他设置
        },
      })
    end,
  },
}
