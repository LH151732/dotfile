-- JDTLS 调试脚本
local M = {}

function M.debug_jdtls()
  print("=== JDTLS 调试信息 ===\n")
  
  -- 1. 检查 Mason 安装
  local ok, mason_registry = pcall(require, "mason-registry")
  if ok then
    print("1. Mason 状态:")
    if mason_registry.is_installed("jdtls") then
      local jdtls_pkg = mason_registry.get_package("jdtls")
      print("   ✓ JDTLS 已安装")
      print("   路径: " .. jdtls_pkg:get_install_path())
    else
      print("   ✗ JDTLS 未安装")
    end
  else
    print("   ✗ Mason Registry 加载失败")
  end
  print("")
  
  -- 2. 检查 nvim-jdtls 插件
  print("2. nvim-jdtls 插件:")
  local ok_jdtls, jdtls = pcall(require, "jdtls")
  if ok_jdtls then
    print("   ✓ nvim-jdtls 已加载")
  else
    print("   ✗ nvim-jdtls 加载失败: " .. tostring(jdtls))
  end
  print("")
  
  -- 3. 检查文件路径
  print("3. 文件路径:")
  local binary = vim.fn.expand("~/.local/share/nvim/mason/bin/jdtls")
  print("   二进制文件: " .. binary)
  print("   存在: " .. (vim.fn.filereadable(binary) == 1 and "✓" or "✗"))
  
  local jdtls_py = vim.fn.expand("~/.local/share/nvim/mason/packages/jdtls/bin/jdtls.py")
  print("   Python 脚本: " .. jdtls_py)
  print("   存在: " .. (vim.fn.filereadable(jdtls_py) == 1 and "✓" or "✗"))
  print("")
  
  -- 4. 检查 Python
  print("4. Python 环境:")
  local python_version = vim.fn.system("python3 --version 2>&1")
  print("   " .. vim.trim(python_version))
  print("")
  
  -- 5. 尝试手动运行 jdtls
  print("5. 测试 JDTLS 命令:")
  local test_cmd = vim.fn.expand("~/.local/share/nvim/mason/bin/jdtls") .. " --version"
  local result = vim.fn.system(test_cmd .. " 2>&1")
  print("   命令: " .. test_cmd)
  print("   输出: " .. vim.trim(result or "无输出"))
  print("")
  
  -- 6. 检查当前 LSP 客户端
  print("6. 当前 LSP 客户端:")
  local clients = vim.lsp.get_active_clients()
  if #clients == 0 then
    print("   没有活动的 LSP 客户端")
  else
    for _, client in ipairs(clients) do
      print("   - " .. client.name .. " (ID: " .. client.id .. ")")
    end
  end
  print("")
  
  -- 7. 检查错误日志
  print("7. LSP 日志级别:")
  print("   当前级别: " .. vim.lsp.get_log_level())
  print("   日志文件: " .. vim.lsp.get_log_path())
end

-- 创建命令
vim.api.nvim_create_user_command("JdtlsDebug", function()
  M.debug_jdtls()
end, {})

return M