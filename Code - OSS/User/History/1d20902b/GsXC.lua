return {
  {
    "nvim-tree/nvim-tree.lua",
    optional = true,
    opts = {
      auto_open = false,
      open_on_setup = false,
      open_on_setup_file = false,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      -- 禁用自动打开文件树
      autocmds = {
        open_tree = false,
      },
    },
  },
}
