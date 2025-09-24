return {
  "linux-cultist/venv-selector.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
  },
  ft = "python", -- 只在打开Python文件时加载
  keys = {
    { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "选择虚拟环境" },
  },
  opts = {
    search = {
      -- 自定义搜索配置（可选）
      uv_script = {
        command = "uv python find --script '$CURRENT_FILE'",
      },
    },
    options = {
      -- 启用虚拟环境缓存和自动激活
      enable_cached_venvs = true,
      cached_venv_automatic_activation = true,
      -- 在终端中激活虚拟环境
      activate_venv_in_terminal = true,
      -- 设置环境变量
      set_environment_variables = true,
      -- 激活时通知用户
      notify_user_on_venv_activation = true,
      -- 调试模式（可选）
      debug = false,
      -- 虚拟环境激活后的回调函数
      on_venv_activate_callback = function()
        -- 触发自定义事件，让其他插件（如DAP）知道虚拟环境已切换
        vim.api.nvim_exec_autocmds("User", { pattern = "VenvSelecterActivated" })
      end,
    },
  },
}