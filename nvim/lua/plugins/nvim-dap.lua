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
-- F2: 开始/继续调试
-- F5: 单步跳过
-- F6: 单步进入
-- F7: 切换调试UI
-- Enter: 切换断点
-- <leader>B: 设置条件断点
-- <leader>do: 单步退出
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
      "mfussenegger/nvim-jdtls", -- Java调试和LSP
    },

    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      local dap_virtual_text = require("nvim-dap-virtual-text")

      --------------------------------------------------------------------------------
      -- 项目类型检测工具函数
      --------------------------------------------------------------------------------
      local function file_exists(path)
        local file = io.open(path, "r")
        if file then
          file:close()
          return true
        end
        return false
      end

      local function is_uv_project()
        return file_exists("pyproject.toml") and file_exists(".venv/pyvenv.cfg")
      end

      local function is_gradle_project()
        return file_exists("build.gradle") or file_exists("build.gradle.kts") or file_exists("gradlew")
      end

      local function get_uv_python_path()
        -- 优先使用激活的虚拟环境
        if vim.env.VIRTUAL_ENV then
          local venv_python = vim.env.VIRTUAL_ENV .. "/bin/python"
          if vim.fn.executable(venv_python) == 1 then
            return venv_python
          end
        end

        -- 检查项目根目录的.venv
        local venv_python = vim.fn.getcwd() .. "/.venv/bin/python"
        if vim.fn.executable(venv_python) == 1 then
          return venv_python
        end

        -- 使用 uv python find 查找
        local uv_python = vim.fn.system("uv python find 2>/dev/null"):gsub("\n", "")
        if vim.fn.executable(uv_python) == 1 then
          return uv_python
        end

        -- 使用 pyenv common 环境
        local pyenv_common = os.getenv("HOME") .. "/.pyenv/versions/common/bin/python"
        if vim.fn.executable(pyenv_common) == 1 then
          return pyenv_common
        end

        -- 最后回退到系统 Python
        return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
      end

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
              { id = "scopes", size = 0.35 }, -- 变量作用域（增大）
              { id = "breakpoints", size = 0.30 }, -- 断点列表
              -- { id = "stacks", size = 0.25 },    -- 调用栈（注释掉）
              { id = "watches", size = 0.35 }, -- 监视表达式（增大）
            },
            size = 40,
            position = "right", -- 改为右侧
          },
          {
            elements = {
              -- 只保留终端输出，移除REPL
              { id = "console", size = 1.0 }, -- 终端占满整个底部
            },
            size = 18, -- 增大底部面板高度（从10改到18）
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
        ensure_installed = { "python", "delve", "js-debug-adapter", "codelldb", "java-debug-adapter", "java-test" },
        automatic_setup = true,
      })

      --------------------------------------------------------------------------------
      -- 语言特定配置
      --------------------------------------------------------------------------------

      -- Python - 智能检测 uv 环境
      require("dap-python").setup(get_uv_python_path())

      -- 添加自动更新调试器路径的功能（与 venv-selector 集成）
      local function update_dap_python_path()
        local new_python_path = get_uv_python_path()
        require("dap-python").setup(new_python_path)
        vim.notify("DAP Python path updated to: " .. new_python_path, vim.log.levels.INFO)
      end

      -- 监听虚拟环境变化（当VIRTUAL_ENV环境变量改变时）
      vim.api.nvim_create_autocmd("User", {
        pattern = "VenvSelecterActivated",
        callback = function()
          update_dap_python_path()
        end,
      })

      -- 清空默认配置，使用自定义配置
      dap.configurations.python = {}

      -- uv 项目配置
      if is_uv_project() then
        local python_path = get_uv_python_path()
        table.insert(dap.configurations.python, {
          type = "python",
          request = "launch",
          name = "Launch file (uv)",
          program = "${file}",
          pythonPath = python_path,
          stopOnEntry = false,
          console = "integratedTerminal",
          -- 程序完成后不自动退出调试会话
          autoReload = {
            enable = true,
          },
        })
        table.insert(dap.configurations.python, {
          type = "python",
          request = "launch",
          name = "Launch file with arguments (uv)",
          program = "${file}",
          pythonPath = python_path,
          stopOnEntry = false,
          console = "integratedTerminal",
          args = function()
            local args_string = vim.fn.input("Arguments: ")
            return vim.split(args_string, " +")
          end,
          autoReload = {
            enable = true,
          },
        })
        table.insert(dap.configurations.python, {
          type = "python",
          request = "launch",
          name = "Run pytest (uv)",
          module = "pytest",
          pythonPath = python_path,
          args = { "${workspaceFolder}" },
          stopOnEntry = false,
          console = "integratedTerminal",
          autoReload = {
            enable = true,
          },
        })
      else
        -- 普通 Python 项目配置
        table.insert(dap.configurations.python, {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          stopOnEntry = false,
          console = "integratedTerminal",
          autoReload = {
            enable = true,
          },
        })
        table.insert(dap.configurations.python, {
          type = "python",
          request = "launch",
          name = "Launch file with arguments",
          program = "${file}",
          stopOnEntry = false,
          console = "integratedTerminal",
          args = function()
            local args_string = vim.fn.input("Arguments: ")
            return vim.split(args_string, " +")
          end,
          autoReload = {
            enable = true,
          },
        })
      end

      -- Go
      require("dap-go").setup()

      -- Java - 配置调试适配器
      dap.adapters.java = {
        type = "executable",
        command = vim.fn.stdpath("data")
          .. "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
        args = {},
      }

      -- Java - 调试配置
      dap.configurations.java = {}

      if is_gradle_project() then
        -- Gradle 项目配置
        table.insert(dap.configurations.java, {
          type = "java",
          request = "attach",
          name = "Debug (Attach) - Remote Gradle",
          hostName = "127.0.0.1",
          port = 5005,
        })
        table.insert(dap.configurations.java, {
          type = "java",
          request = "launch",
          name = "Launch Gradle Application",
          mainClass = function()
            return vim.fn.input("Main class: ", "")
          end,
          projectName = vim.fn.fnamemodify(vim.fn.getcwd(), ":t"),
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
        })
        table.insert(dap.configurations.java, {
          type = "java",
          request = "launch",
          name = "Launch Gradle Test",
          mainClass = function()
            return vim.fn.input("Test class: ", "")
          end,
          projectName = vim.fn.fnamemodify(vim.fn.getcwd(), ":t"),
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
          args = "--tests",
        })
      else
        -- 普通 Java 项目配置
        table.insert(dap.configurations.java, {
          type = "java",
          request = "launch",
          name = "Launch Java Application",
          mainClass = function()
            return vim.fn.input("Main class: ", "")
          end,
          projectName = vim.fn.fnamemodify(vim.fn.getcwd(), ":t"),
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
        })
        table.insert(dap.configurations.java, {
          type = "java",
          request = "attach",
          name = "Debug (Attach)",
          hostName = "127.0.0.1",
          port = 5005,
        })
      end

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
        -- 程序终止时，延迟3秒后关闭UI（让用户有时间查看结果）
        vim.notify("调试结束，3秒后自动关闭面板...", vim.log.levels.INFO)
        vim.defer_fn(function()
          dapui.close()
        end, 3000) -- 3000毫秒 = 3秒
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        -- 程序退出时，延迟3秒后关闭UI
        vim.notify("程序退出，3秒后自动关闭面板...", vim.log.levels.INFO)
        vim.defer_fn(function()
          dapui.close()
        end, 3000) -- 3000毫秒 = 3秒
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
      -- 基础调试操作
      {
        "<F2>",
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
        "<F5>",
        function()
          require("dap").step_over()
        end,
        desc = "Debug: Step Over",
      },
      {
        "<F6>",
        function()
          require("dap").step_into()
        end,
        desc = "Debug: Step Into",
      },
      {
        "<F7>",
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
      -- 智能调试启动
      {
        "<leader>ds",
        function()
          local ft = vim.bo.filetype
          if ft == "python" then
            if is_uv_project() then
              vim.notify("Starting debug with uv environment")
            else
              vim.notify("Starting debug with standard Python")
            end
          elseif ft == "java" then
            if is_gradle_project() then
              vim.notify("Starting debug with Gradle project")
            else
              vim.notify("Starting debug with standard Java project")
            end
          end
          require("dap").continue()
        end,
        desc = "Debug: Smart Start",
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

      -- 项目特定的调试快捷键
      {
        "<leader>dp",
        function()
          if vim.bo.filetype == "python" and is_uv_project() then
            -- 选择 uv 项目特定的调试配置
            local configs = {}
            for _, config in ipairs(dap.configurations.python) do
              if string.find(config.name, "uv") then
                table.insert(configs, config)
              end
            end
            if #configs > 0 then
              dap.run(configs[1])
            end
          elseif vim.bo.filetype == "java" and is_gradle_project() then
            -- 选择 Gradle 项目特定的调试配置
            local configs = {}
            for _, config in ipairs(dap.configurations.java) do
              if string.find(config.name, "Gradle") then
                table.insert(configs, config)
              end
            end
            if #configs > 0 then
              dap.run(configs[1])
            end
          else
            dap.continue()
          end
        end,
        desc = "Debug: Project-specific Start",
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
