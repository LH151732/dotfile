return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 2000,
    config = true,
    opts = {
      transparent_mode = true, -- 启用透明背景
      contrast = "hard", -- 可选: "hard", "soft", ""
      italic = {
        strings = false,
        comments = true,
        operators = false,
        folds = true,
      },
    },
  },
}
