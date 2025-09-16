return {
  -- Claude Code AI 助手集成
  {
    "greggh/claude-code.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Git 操作依赖
    },
    event = "VeryLazy", -- 延迟加载以提高启动速度
    keys = {
      {
        "<leader>cc",
        function()
          require("claude-code").toggle()
        end,
        desc = "切换 Claude Code",
      },
      {
        "<leader>cf",
        function()
          require("claude-code").toggle_float()
        end,
        desc = "Claude Code 浮动窗口",
      },
      {
        "<leader>cs",
        function()
          require("claude-code").toggle_split()
        end,
        desc = "Claude Code 分割窗口",
      },
      {
        "<leader>cr",
        function()
          require("claude-code").reload_buffer()
        end,
        desc = "重载当前缓冲区",
      },
    },
    opts = {
      window = {
        -- 分割窗口配置
        split_ratio = 0.35, -- 窗口占比
        position = "botright", -- 位置：右下
        enter_insert = true, -- 自动进入插入模式
        hide_numbers = true, -- 隐藏行号
        hide_signcolumn = true, -- 隐藏标记列

        -- 浮动窗口配置
        float = {
          width = "85%", -- 窗口宽度
          height = "80%", -- 窗口高度
          row = "center", -- 垂直居中
          col = "center", -- 水平居中
          relative = "editor", -- 相对编辑器
          border = "rounded", -- 圆角边框
          title = " Claude Code AI ", -- 窗口标题
          title_pos = "center", -- 标题居中
        },
      },

      -- 自动刷新配置
      refresh = {
        enabled = true, -- 启用自动刷新
        interval = 500, -- 检查间隔（毫秒）
        on_save = true, -- 保存时刷新
        on_focus = true, -- 焦点变化时刷新
      },

      -- Git 集成
      git = {
        enabled = true, -- 启用 Git 集成
        auto_commit = false, -- 不自动提交
        show_diff = true, -- 显示差异
      },

      -- Shell 配置
      shell = {
        shell = vim.o.shell or "bash", -- 使用的 shell
        args = {}, -- shell 参数
      },

      -- Claude Code 命令配置
      commands = {
        claude_code = "claude-code", -- Claude Code CLI 命令
        args = {}, -- 默认参数
        custom_variants = {
          -- 自定义变体，可以添加常用的 Claude Code 命令组合
          continue = { "--continue" },
          review = { "--review" },
          test = { "--test" },
        },
      },

      -- 文件监控
      file_watcher = {
        enabled = true, -- 启用文件监控
        events = { "BufWritePost", "FocusGained" }, -- 监控事件
        ignore_patterns = { -- 忽略的文件模式
          "%.git/.*",
          "node_modules/.*",
          "%.pyc$",
          "__pycache__/.*",
        },
      },

      -- 高亮配置
      highlights = {
        FloatBorder = "TelescopeBorder", -- 浮动窗口边框
        FloatTitle = "TelescopeTitle", -- 浮动窗口标题
      },
    },

    config = function(_, opts)
      require("claude-code").setup(opts)

      -- 设置自动命令组
      local augroup = vim.api.nvim_create_augroup("ClaudeCode", { clear = true })

      -- 当 Claude Code 修改文件时自动重载
      vim.api.nvim_create_autocmd("FileChangedShellPost", {
        group = augroup,
        callback = function(args)
          local bufnr = args.buf
          local filename = vim.api.nvim_buf_get_name(bufnr)

          -- 通知用户文件已被外部修改
          vim.notify(
            string.format("文件 '%s' 已被 Claude Code 修改并重载", vim.fn.fnamemodify(filename, ":t")),
            vim.log.levels.INFO,
            { title = "Claude Code" }
          )
        end,
      })

      -- 检测缓冲区变化并提供重载选项
      vim.api.nvim_create_autocmd("FileChangedShell", {
        group = augroup,
        callback = function(args)
          local bufnr = args.buf
          local choice = vim.fn.confirm(
            "文件已被外部修改（可能是 Claude Code），要重载吗？",
            "&是\n&否\n&查看差异",
            1
          )

          if choice == 1 then
            vim.cmd("checktime")
          elseif choice == 3 then
            vim.cmd("DiffOrig")
          end
        end,
      })

      -- 添加用户命令
      vim.api.nvim_create_user_command("ClaudeCode", function(args)
        if args.args == "" then
          require("claude-code").toggle()
        else
          require("claude-code").run_command(args.args)
        end
      end, {
        nargs = "*",
        complete = function()
          return { "continue", "review", "test", "help" }
        end,
        desc = "运行 Claude Code 命令",
      })

      vim.api.nvim_create_user_command("ClaudeCodeFloat", function()
        require("claude-code").toggle_float()
      end, { desc = "打开 Claude Code 浮动窗口" })

      vim.api.nvim_create_user_command("ClaudeCodeReload", function()
        require("claude-code").reload_buffer()
      end, { desc = "重载当前缓冲区" })
    end,
  },
}