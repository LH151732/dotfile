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
