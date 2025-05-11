-- API列表
-- Author: HL
-- Date: 12/05/2025
--
-- 调试功能:
-- F5: 开始/继续调试
-- Shift+F5: 重新开始调试
-- Ctrl+F5: 停止/终止调试
-- F6: 单步跳过
-- F7: 单步进入
-- F8: 切换调试UI
-- Enter: 切换断点
-- <leader>B: 设置条件断点
-- <leader>do: 单步退出
-- <leader>dr: 打开REPL
-- 更多快捷键详见下文

return {
  -- nvim-dap 核心插件
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- 调试UI界面
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",

      -- 在代码中显示变量值
      "theHamsta/nvim-dap-virtual-text",

      -- Mason集成，自动安装调试器
      "jay-babu/mason-nvim-dap.nvim",

      -- 语言特定的配置
      "mfussenegger/nvim-dap-python", -- Python调试
      "leoluz/nvim-dap-go", -- Go调试
    },

    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      local dap_virtual_text = require("nvim-dap-virtual-text")

      --------------------------------------------------------------------------------
      -- nvim-dap-ui 配置
      --------------------------------------------------------------------------------
      dapui.setup({
        icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
        mappings = {
          -- 使用表格来自定义UI中的快捷键
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          edit = "e",
          repl = "r",
          toggle = "t",
        },
        -- 使用浮动窗口
        floating = {
          max_height = 0.9,
          max_width = 0.9,
          border = "rounded",
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
        -- UI布局
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.25 },
              { id = "breakpoints", size = 0.25 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            size = 40,
            position = "right", -- 改为右侧
          },
          {
            elements = {
              { id = "repl", size = 0.5 },
              { id = "console", size = 0.5 },
            },
            size = 10,
            position = "bottom",
          },
        },
      })

      --------------------------------------------------------------------------------
      -- nvim-dap-virtual-text 配置
      --------------------------------------------------------------------------------
      dap_virtual_text.setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        commented = false,
        only_first_definition = true,
        all_references = false,
        filter_references_pattern = "<module",
        virt_text_pos = "eol",
        all_frames = false,
        virt_lines = false,
        virt_text_win_col = nil,
      })

      --------------------------------------------------------------------------------
      -- Mason-nvim-dap 配置
      --------------------------------------------------------------------------------
      require("mason-nvim-dap").setup({
        ensure_installed = { "python", "delve", "js-debug-adapter", "codelldb" },
        automatic_setup = true,
      })

      --------------------------------------------------------------------------------
      -- 语言特定配置
      --------------------------------------------------------------------------------

      -- Python
      require("dap-python").setup("python")
      table.insert(dap.configurations.python, {
        type = "python",
        request = "launch",
        name = "Launch file with arguments",
        program = "${file}",
        args = function()
          local args_string = vim.fn.input("Arguments: ")
          return vim.split(args_string, " +")
        end,
      })

      -- Go
      require("dap-go").setup()

      -- JavaScript/TypeScript (通过 Mason 安装调试器)
      -- 配置适配器
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
            "${port}",
          },
        },
      }

      -- JavaScript/TypeScript 配置
      for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
        }
      end

      -- C/C++/Rust
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb",
          args = { "--port", "${port}" },
        },
      }

      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }

      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp

      --------------------------------------------------------------------------------
      -- UI自动开关
      --------------------------------------------------------------------------------
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      --------------------------------------------------------------------------------
      -- 断点样式
      --------------------------------------------------------------------------------
      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "◐", texthl = "DapBreakpoint", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DapBreakpoint", linehl = "", numhl = "" })
      vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
      vim.fn.sign_define(
        "DapStopped",
        { text = "▶", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
      )
    end,

    --------------------------------------------------------------------------------
    -- 快捷键映射
    --------------------------------------------------------------------------------
    keys = {
      -- 基础调试操作 - 使用连续的功能键
      {
        "<F5>",
        function()
          require("dap").continue()
        end,
        desc = "Debug: Start/Continue",
      },
      {
        "<S-F5>",
        function()
          require("dap").restart()
        end,
        desc = "Debug: Restart",
      },
      {
        "<C-F5>",
        function()
          require("dap").terminate()
        end,
        desc = "Debug: Stop/Terminate",
      },
      {
        "<F6>",
        function()
          require("dap").step_over()
        end,
        desc = "Debug: Step Over",
      },
      {
        "<F7>",
        function()
          require("dap").step_into()
        end,
        desc = "Debug: Step Into",
      },
      {
        "<F8>",
        function()
          require("dapui").toggle()
        end,
        desc = "Debug: Toggle UI",
      },

      -- 断点管理 - 使用 Enter 设置断点
      {
        "<CR>",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Debug: Toggle Breakpoint",
        mode = "n",
      },
      -- Telescope集成
      {
        "<leader>dbc",
        function()
          require("telescope").extensions.dap.commands()
        end,
        desc = "Debug: Commands",
      },
      {
        "<leader>dbb",
        function()
          require("telescope").extensions.dap.list_breakpoints()
        end,
        desc = "Debug: List Breakpoints",
      },
      {
        "<leader>dbv",
        function()
          require("telescope").extensions.dap.variables()
        end,
        desc = "Debug: Variables",
      },
      {
        "<leader>dbf",
        function()
          require("telescope").extensions.dap.frames()
        end,
        desc = "Debug: Frames",
      },
    },
  },

  -- Telescope DAP 扩展
  {
    "nvim-telescope/telescope-dap.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "mfussenegger/nvim-dap",
    },
    config = function()
      require("telescope").load_extension("dap")
    end,
  },
}
