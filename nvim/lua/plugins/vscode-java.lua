-- VSCode-Neovim 与 Java LSP 集成配置
return {
  -- 确保在 VSCode 环境中能正确处理 Java LSP 请求
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mfussenegger/nvim-jdtls",
    },
    config = function()
      -- 检测是否在 VSCode 环境中
      if vim.g.vscode then
        -- 处理 "vscode.java.resolveMainClass" 命令
        vim.api.nvim_create_autocmd("LspAttach", {
          callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client and client.name == "jdtls" then
              -- 添加一个特殊的处理程序来响应 vscode.java.resolveMainClass
              client.handlers = client.handlers or {}
              client.handlers["vscode.java.resolveMainClass"] = function(err, result, ctx, config)
                if err then
                  vim.notify("获取 Java 主类失败: " .. vim.inspect(err), vim.log.levels.ERROR)
                  return
                end
                
                -- 返回结果给 VSCode
                return result
              end
              
              -- 定义用于 VSCode 通信的命令
              vim.api.nvim_buf_create_user_command(args.buf, "JavaResolveMainClass", function()
                client.request("vscode.java.resolveMainClass", {}, function(err, result)
                  if err then
                    vim.notify("获取 Java 主类失败: " .. vim.inspect(err), vim.log.levels.ERROR)
                    return
                  end
                  
                  vim.notify("发现 Java 主类: " .. vim.inspect(result), vim.log.levels.INFO)
                end)
              end, {})
            end
          end,
        })
      end
    end,
  },
  
  -- LSP 状态显示增强
  {
    "nvim-lua/lsp-status.nvim",
    config = function()
      local lsp_status = require("lsp-status")
      lsp_status.register_progress()
      
      -- 配置 LSP 状态组件
      lsp_status.config({
        indicator_errors = "E",
        indicator_warnings = "W",
        indicator_info = "I",
        indicator_hint = "H",
        indicator_ok = "✓",
        status_symbol = "LSP",
      })
      
      -- 显示 LSP 状态的函数，可以用于状态栏
      function _G.getLspStatus()
        if #vim.lsp.get_active_clients() > 0 then
          return lsp_status.status()
        end
        return ""
      end
      
      -- 注册到 LSP 回调
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client then
            lsp_status.on_attach(client)
            
            -- 向用户显示 LSP 已连接的通知
            vim.notify("LSP: " .. client.name .. " 已连接", vim.log.levels.INFO)
          end
        end,
      })
    end,
  },
}
