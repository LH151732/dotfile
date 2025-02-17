return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui", -- UI 增强
      "theHamsta/nvim-dap-virtual-text", -- 在代码中显示调试变量
      "mfussenegger/nvim-dap-python", -- Python 调试适配器
      "mfussenegger/nvim-jdtls", -- Java 调试适配器
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- 配置调试断点的图标样式
      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
      vim.fn.sign_define(
        "DapBreakpointCondition",
        { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
      )
      vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })

      -- 配置 DAP UI
      dapui.setup({
        icons = { expanded = "▾", collapsed = "▸" }, -- 界面图标设定
        mappings = {
          expand = { "<CR>", "<2-LeftMouse>" },
        },
        layouts = {
          -- 第一块：底部面板
          {
            elements = {
              "scopes", -- 查看变量值
              "breakpoints", -- 显示断点
              "stacks", -- 调用栈
              "repl", -- 调试过程中的交互式控制台
              "watches", -- 自定义监视
            },
            size = 10, -- 设置底部面板高度
            position = "bottom",
          },
          -- 第二块：右侧面板
          {
            elements = {
              "console", -- 输出日志/信息
            },
            size = 30, -- 设置右侧面板宽度
            position = "right",
          },
        },
      })

      -- 自动打开/关闭 DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- 配置虚拟文本：调试变量值显示在代码旁
      require("nvim-dap-virtual-text").setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = true,
      })

      -- 定义常用调试快捷键
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Start/Continue Debugging" })
      vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step Over" })
      vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
      vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Terminate Debugging" })
      vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open REPL Console" })
    end,
  },

  -- Python 调试适配器
  {
    "mfussenegger/nvim-dap-python",
    ft = "python", -- 只在 Python 文件中加载
    config = function()
      require("dap-python").setup("/home/HL/.pyenv/versions/common/bin/python") -- 虚拟环境路径
      vim.keymap.set("n", "<leader>dP", function()
        require("dap-python").test_method()
      end, { desc = "Debug Python Method" })
    end,
  },
}
