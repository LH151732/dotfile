" 测试脚本用于诊断 JDTLS 问题
" 在 Neovim 中执行: :source ~/.config/nvim/test_jdtls.vim

function! TestJDTLS()
  echo "=== JDTLS 诊断信息 ==="
  echo ""
  
  " 1. 检查 Mason 是否安装了 jdtls
  echo "1. 检查 Mason 安装状态:"
  let mason_registry = luaeval("require('mason-registry')")
  if luaeval("require('mason-registry').is_installed('jdtls')")
    echo "   ✓ JDTLS 已通过 Mason 安装"
    let jdtls_path = luaeval("require('mason-registry').get_package('jdtls'):get_install_path()")
    echo "   路径: " . jdtls_path
  else
    echo "   ✗ JDTLS 未通过 Mason 安装"
  endif
  echo ""
  
  " 2. 检查二进制文件
  echo "2. 检查二进制文件:"
  let binary_path = expand("~/.local/share/nvim/mason/bin/jdtls")
  if filereadable(binary_path)
    echo "   ✓ 二进制文件存在: " . binary_path
  else
    echo "   ✗ 二进制文件不存在"
  endif
  echo ""
  
  " 3. 检查当前文件类型
  echo "3. 当前文件信息:"
  echo "   文件类型: " . &filetype
  echo "   文件路径: " . expand("%:p")
  echo ""
  
  " 4. 检查 LSP 状态
  echo "4. LSP 客户端信息:"
  let clients = luaeval("vim.lsp.get_active_clients()")
  if empty(clients)
    echo "   没有活动的 LSP 客户端"
  else
    for client in clients
      echo "   - " . client.name . " (id: " . client.id . ")"
    endfor
  endif
  echo ""
  
  " 5. 检查 Java 运行时
  echo "5. Java 环境:"
  let java_version = system("java -version 2>&1")
  echo "   " . substitute(java_version, '\n', '\n   ', 'g')
  echo ""
  
  " 6. 显示最近的错误消息
  echo "6. 最近的消息:"
  let messages = execute('messages')
  let lines = split(messages, '\n')
  let recent_messages = lines[-min([10, len(lines)]):]
  for msg in recent_messages
    echo "   " . msg
  endfor
endfunction

" 执行测试
call TestJDTLS()