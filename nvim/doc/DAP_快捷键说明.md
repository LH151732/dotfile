# Neovim DAP 调试快捷键说明

## 基础调试操作

### 启动和控制

- **F2** - 开始/继续调试 (Start/Continue)
- **Shift+F5** - 重新开始调试 (Restart)
- **Ctrl+F5** - 停止/终止调试 (Stop/Terminate)
- **\<leader\>ds** - 智能调试启动 (Smart Debug Start)

### 步进调试

- **F5** - 单步跳过 (Step Over) - 执行当前行，不进入函数内部
- **F6** - 单步进入 (Step Into) - 进入函数内部执行
- **F7** - 切换调试UI (Toggle Debug UI)

## 断点管理

### 断点操作

- **Enter** - 切换断点 (Toggle Breakpoint) - 在当前行设置或取消断点
- **\<leader\>B** - 设置条件断点 (Conditional Breakpoint)
- **\<leader\>lp** - 设置日志点 (Log Point)

## 调试界面和信息

### UI 控制

- **F8** - 切换调试UI显示/隐藏
- **\<leader\>dr** - 打开REPL交互窗口
- **\<leader\>dl** - 运行到光标位置 (Run to Cursor)

### Telescope 集成

- **\<leader\>dbc** - 显示调试命令 (Debug Commands)
- **\<leader\>dbb** - 显示断点列表 (Breakpoints List)
- **\<leader\>dbv** - 显示变量列表 (Variables List)
- **\<leader\>dbf** - 显示调用栈 (Frames List)

## 调试配置说明

### Python 项目调试配置

1. **Launch file (uv)** - 使用 uv 环境运行当前文件
2. **Launch file with arguments (uv)** - 使用 uv 环境运行当前文件并提供参数
3. **Run pytest (uv)** - 使用 uv 环境运行 pytest 测试

### 特殊配置

- 所有配置都设置了 `console = "integratedTerminal"` - 使用集成终端显示输出
- 设置了 `stopOnEntry = false` - 不在程序入口自动暂停
- 程序运行完成后**不会自动退出**调试会话，需要手动关闭

## 调试流程建议

### 基本调试流程

1. 在代码中设置断点：将光标放在目标行，按 **Enter**
2. 启动调试：按 **F2**
3. 程序会在断点处暂停，此时可以：
   - 查看变量值（在调试UI中）
   - 单步执行：**F5** (跳过) 或 **F6** (进入)
   - 继续执行：再按 **F2**
4. 调试完成后手动停止：**Ctrl+F5**

### 虚拟环境集成

- 系统会自动检测并使用项目的虚拟环境
- 支持 uv 项目自动识别
- 与 venv-selector 插件集成，切换虚拟环境时会自动更新调试配置

## 注意事项

1. **断点设置**：确保在有效的代码行设置断点，注释行和空行不会触发断点
2. **虚拟环境**：如果使用虚拟环境，确保已正确激活或配置
3. **debugpy 依赖**：Python 调试需要安装 debugpy 包
4. **程序不会自动退出**：调试会话在程序完成后会保持活跃状态，需要手动终止

## 故障排除

### 常见问题

- **调试无法启动**：检查是否安装了 debugpy (`sudo pacman -S python-debugpy`)
- **断点不生效**：确保断点设置在可执行的代码行上
- **找不到Python解释器**：检查虚拟环境配置或使用 `\<leader\>vs` 选择虚拟环境

### 日志和诊断

- 使用 `:DapShowLog` 查看调试日志
- 检查 `:checkhealth` 中的 DAP 相关信息

