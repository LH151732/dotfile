return {
  -- Highlight colors
  {
    "echasnovski/mini.hipatterns",
    event = "BufReadPre",
    opts = {},
  },
  -- Tokyo Night theme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "storm", -- 其他选项: "night", "moon", "day"
      transparent = true, -- 启用透明背景
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
      },
      -- 自定义高亮设置
      on_highlights = function(hl, c)
        hl.Comment = { fg = "#FFB7C5", italic = true } -- 樱粉色注释
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  -- Your existing Telescope configuration
  {
    "telescope.nvim",
    -- ... (rest of your Telescope configuration)
  },
}
