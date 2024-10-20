return {
  {
    "nvimdev/dashboard-nvim",
    enabled = true,
    config = function()
      require('dashboard').setup({
        -- 这里可以自定义你的 dashboard 设置
        theme = 'doom',  -- 使用 'doom' 主题
        config = {
          header = {
            "Welcome to Neovim Dashboard", -- 自定义的头部信息
          },
          center = {
            {
              icon = "  ",
              desc = "Recent sessions",
              action = "SessionLoad",
            },
            {
              icon = "  ",
              desc = "Recently opened files",
              action = "Telescope oldfiles",
            },
            {
              icon = "  ",
              desc = "Find file",
              action = "Telescope find_files",
            },
          },
        },
      })

      -- 自动进入 dashboard 如果没有传入文件或参数
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          if vim.fn.argc() == 0 then  -- 检查没有传入参数
            vim.cmd("Dashboard")  -- 进入 dashboard
          end
        end,
      })
    end,
  },
}

