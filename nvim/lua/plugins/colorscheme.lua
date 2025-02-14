return {
  -- 使用 Mini Hipatterns，高亮颜色示例
  {
    "echasnovski/mini.hipatterns",
    event = "BufReadPre",
    opts = {},
  },
  {
    "catppuccin/nvim", -- 插件路径
    name = "catppuccin",
    lazy = false,
    priority = 1000, -- 保证 Catppuccin 优先加载
    opts = {
      flavour = "mocha", -- 可选主题风格: latte, frappe, macchiato, mocha
      transparent_background = true, -- 背景透明
      term_colors = true, -- 终端的颜色与当前主题匹配
      integrations = {
        treesitter = true, -- 支持treesitter的语法高亮
        nvimtree = true, -- 集成nvim-tree
        cmp = true, -- 集成 nvim-cmp 的补全
        gitsigns = true, -- 集成gitsigns
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts) -- 加载带 opts 的设置
      vim.cmd([[colorscheme catppuccin]]) -- 应用 colorscheme
    end,
  },
  -- Your existing Telescope configuration
  {
    "telescope.nvim",
    -- ... (rest of your Telescope configuration)
  },
}
