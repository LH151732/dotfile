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
        icons = { expanded = "▾", collapsed = "▸" },
        mappings = {
          -- 修改导航映射键：左键返回上一步，📧(右键)继续下一步
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          edit = "e",
          repl = "r",
          toggle = "t",
        },
        -- 自定义按键导航
        expand_lines = vim.fn.has("nvim-0.7") == 1,
        layouts = {
          {
            elements = {
              "scopes", -- 查看变量值
              "breakpoints", -- 显示断点
              "stacks", -- 调用栈
              "watches", -- 自定义监视
            },
            size = 10, -- 设置底部面板高度
            position = "bottom",
          },
          {
            elements = {
              "repl", -- 交互式控制台
              "console", -- 输出日志/信息
            },
            size = 60,
            position = "right",
          },
        },
        controls = {
          -- 启用这些图标
          icons = {
            pause = "⏸",
            play = "▶",
            step_into = "⏎",
            step_over = "⏭",
            step_out = "⏮",
            step_back = "←",
            run_last = "↻",
            terminate = "⏹",
            disconnect = "⏏",
          },
        },
        floating = {
          max_height = nil,
          max_width = nil,
          border = "single",
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
        windows = { indent = 1 },
        render = {
          max_type_length = nil,
          max_value_lines = 100,
        },
      })

      -- 自动打开 DAP UI，但不在会话结束时自动关闭，并设置自动聚焦到 UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
        -- 自动聚焦到 DAP UI 窗口
        vim.defer_fn(function()
          vim.cmd("wincmd p") -- 跳转到上一个窗口
          vim.cmd("wincmd p") -- 跳回来，这样就聚焦到了 DAPUI
        end, 100)
      end
      -- 下面两个事件监听器被注释掉，以防止自动关闭调试界面
      -- dap.listeners.before.event_terminated["dapui_config"] = function()
      --   dapui.close()
      -- end
      -- dap.listeners.before.event_exited["dapui_config"] = function()
      --   dapui.close()
      -- end
      
      -- 基本 DAP UI 快捷键
      vim.keymap.set("n", "<leader>du", dapui.close, { desc = "Close Debug UI" })
      
      -- 创建交互式调试控制面板，确保操作可用性
      local function create_debug_menu()
        -- 首先检查调试会话是否活动
        if not dap.session() then
          vim.notify("没有活动的调试会话", vim.log.levels.WARN)
          return
        end
        
        -- 定义操作并检查它们的可用性
        local menu_items = {
          { 
            name = "继续运行", 
            icon = "▶", 
            action = function() 
              pcall(dap.continue) 
            end 
          },
          { 
            name = "单步执行", 
            icon = "⏭", 
            action = function() 
              pcall(dap.step_over) 
            end 
          },
          { 
            name = "步入函数", 
            icon = "⏎", 
            action = function() 
              pcall(dap.step_into) 
            end 
          },
          { 
            name = "步出函数", 
            icon = "⏮", 
            action = function() 
              pcall(dap.step_out) 
            end 
          },
          { 
            name = "停止调试", 
            icon = "⏹", 
            action = function() 
              pcall(dap.terminate) 
            end 
          },
        }
        
        -- 创建菜单缓冲区
        local buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
        
        -- 创建菜单内容
        local width = 40
        local menu_text = {}
        for i, item in ipairs(menu_items) do
          local text = string.format(" %s %s ", item.icon, item.name)
          table.insert(menu_text, text)
        end
        
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, menu_text)
        
        -- 创建窗口
        local win_height = #menu_items
        local win_width = width
        
        local win = vim.api.nvim_open_win(buf, true, {
          relative = "editor",
          width = win_width,
          height = win_height,
          row = 3,
          col = 10,
          style = "minimal",
          border = "rounded",
        })
        
        -- 设置高亮
        vim.api.nvim_win_set_option(win, "winhl", "Normal:Normal")
        
        -- 设置当前选择项
        local current_item = 1
        local function highlight_current_item()
          vim.api.nvim_buf_clear_namespace(buf, -1, 0, -1)
          vim.api.nvim_buf_add_highlight(buf, 0, "IncSearch", current_item - 1, 0, -1)
        end
        
        highlight_current_item()
        
        -- 设置快捷键
        local opts = { buffer = buf, noremap = true, silent = true }
        
        -- 左右键导航
        vim.keymap.set("n", "<Left>", function()
          current_item = ((current_item - 2) % #menu_items) + 1
          highlight_current_item()
        end, opts)
        
        vim.keymap.set("n", "<Right>", function()
          current_item = (current_item % #menu_items) + 1
          highlight_current_item()
        end, opts)
        
        -- 回车键确认选择
        vim.keymap.set("n", "<CR>", function()
          local selected = menu_items[current_item]
          vim.api.nvim_win_close(win, true)
          if selected and selected.action then
            selected.action()
          end
        end, opts)
        
        -- Esc 键关闭菜单
        vim.keymap.set("n", "<Esc>", function()
          vim.api.nvim_win_close(win, true)
        end, opts)
      end
      
      -- 添加显示调试菜单的快捷键
      vim.keymap.set("n", "<leader>dm", create_debug_menu, { desc = "显示调试菜单" })
      
      -- 修复调试初始化和聚焦
      dap.listeners.after.event_initialized["focus_code"] = function()
        dapui.open()
        vim.defer_fn(function()
          -- 尝试聚焦到代码窗口
          vim.cmd("wincmd k")
          
          -- 为 REPL 和控制台窗口设置更好的按键映射
          local wins = vim.api.nvim_list_wins()
          for _, win in ipairs(wins) do
            local buf = vim.api.nvim_win_get_buf(win)
            local buf_name = vim.api.nvim_buf_get_name(buf)
            
            if buf_name:match("DAP REP") or buf_name:match("DAP Console") then
              local opts = { buffer = buf, noremap = true, silent = true }
              vim.api.nvim_buf_set_keymap(buf, "n", "o", "", {
                callback = function() 
                  vim.notify("请使用 <leader>dm 打开调试菜单", vim.log.levels.INFO)
                end,
                noremap = true,
                silent = true,
              })
            end
          end
        end, 100)
      end
      
      -- 添加调试运行错误处理
      dap.listeners.after.event_output["handle_output"] = function(_, body)
        if body and body.output and body.output:match("No action possible") then
          vim.defer_fn(function()
            vim.notify("请使用 <leader>dm 打开调试菜单", vim.log.levels.INFO)
          end, 100)
        end
      end

      -- 配置虚拟文本: 调试变量值显示在代码旁
      require("nvim-dap-virtual-text").setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = true,
      })

      -- 定义常用调试快捷键（包括 n 模式下 CR 设置断点）
      vim.keymap.set("n", "<CR>", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" }) -- 将 `CR` 映射为切换断点
      vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Start/Continue Debugging" })
      vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step Over" })
      vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
      vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Terminate Debugging" })
      vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open REPL Console" })

      -- ****IMPORTANT: 设置 jdtls 的 DAP 支持 ****
      -- 注意：此处不需要显式调用 require("jdtls").setup_dap()
      -- 因为 LazyVim 的 java.lua 模块已经配置了这部分
    end,
  },
  -- Python 调试适配器
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    config = function()
      require("dap-python").setup("/home/HL/.pyenv/versions/common/bin/python") -- 虚拟环境路径
      vim.keymap.set("n", "<leader>dP", function()
        require("dap-python").test_method()
      end, { desc = "Debug Python Method" })
    end,
  },
  -- 注意：Java LSP 和 DAP 配置现在由 LazyVim 的 extras/lang/java 模块处理
}
