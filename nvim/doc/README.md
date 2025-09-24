# Neovim 键位映射文档

这个目录包含了完整的 Neovim 配置键位映射文档，涵盖了所有主要功能和插件的快捷键。

## 文档结构

### 📋 [basic-keymaps.md](./basic-keymaps.md)

**基础键位映射** - 核心的编辑和导航功能

- 功能键映射 (F1-F4)
- 光标移动和编辑操作
- 窗口管理
- 搜索和滚动
- 文件管理
- 智能文件执行

### 🔧 [lsp-keymaps.md](./lsp-keymaps.md)

**LSP 语言服务器** - 代码智能功能

- 全局LSP诊断
- 代码导航 (定义、引用、实现)
- 代码操作 (重命名、格式化、代码修复)
- 多语言支持 (Python, Java, JavaScript, Lua等)
- Mason工具管理

### 🐛 [debug-keymaps.md](./debug-keymaps.md)

**调试功能** - nvim-dap调试器

- 基础调试操作 (启动、停止、单步执行)
- 断点管理
- Telescope集成
- 多语言调试配置
- 智能项目检测
- UI和界面控制

### 🔌 [plugins-keymaps.md](./plugins-keymaps.md)

**插件功能** - 各种插件的键位映射

- 标签页管理 (Bufferline)
- 代码注释 (Comment.nvim)
- 搜索替换 (Spectre)
- 专注模式 (Zen Mode)
- 代码折叠 (nvim-ufo)
- 重构工具 (Refactoring)
- 测试框架 (Neotest)
- 代码大纲 (Outline)
- 虚拟环境 (Venv Selector)
- AI助手 (Claude Code)

## 快速查找

### 🎯 常用功能快捷键

| 功能类别     | 主要键位                      | 说明                 |
| ------------ | ----------------------------- | -------------------- |
| **文件操作** | `<Leader>w`, `<Leader>q`      | 保存、退出           |
| **标签页**   | `Tab`/`Shift+Tab`, `Ctrl+1-9` | 标签页切换           |
| **调试**     | `F2`, `F5-F7`, `Enter`        | 调试控制、断点       |
| **代码导航** | `gd`, `gr`, `K`               | 定义、引用、文档     |
| **搜索**     | `Ctrl+f`, `<leader>sr`        | 文件内搜索、项目搜索 |
| **终端**     | `F4`, `Shift+F4`              | 打开终端             |
| **AI助手**   | `<leader>cc`, `<leader>cf`    | Claude Code          |

### 📂 文件类型支持

| 语言              | LSP               | 调试            | 特殊功能         |
| ----------------- | ----------------- | --------------- | ---------------- |
| **Python**        | Ruff + Pyright    | ✅ uv/venv支持  | 虚拟环境自动检测 |
| **Java**          | JDTLS             | ✅ Maven/Gradle | 项目类型自动识别 |
| **JavaScript/TS** | ESLint + TSServer | ✅ Node.js      | Tailwind CSS支持 |
| **Lua**           | lua_ls            | ❌              | Neovim API支持   |
| **C/C++/Rust**    | ❌                | ✅ CodeLLDB     |                  |

### 🛠 开发工作流

1. **项目启动**: `F1` (生成tags) → `<leader>cc` (启动AI助手)
2. **代码编写**: `gd` (跳转定义) → `K` (查看文档) → `<leader>rn` (重命名)
3. **代码调试**: `Enter` (设置断点) → `F2` (启动调试) → `F5/F6` (单步执行)
4. **代码测试**: `<leader>tt` (运行测试) → `<leader>to` (查看输出)
5. **代码提交**: `<leader>sr` (搜索替换) → `<leader>f` (格式化)

## 配置文件位置

所有键位映射的源代码位于：

- **基础配置**: `lua/config/keymaps.lua`
- **LSP配置**: `lua/plugins/lsp-config.lua`
- **调试配置**: `lua/plugins/nvim-dap.lua`
- **插件配置**: `lua/plugins/` 目录下的各个插件文件

## 自定义说明

- `<Leader>` 键默认为空格键
- 所有键位映射支持 `noremap` 和 `silent` 选项
- 插件键位映射采用延迟加载，只有在使用插件时才会生效
- 支持多种操作模式：normal、insert、visual、terminal

## 环境依赖

确保已安装以下外部工具以获得最佳体验：

- **ctags**: 用于代码标签生成
- **frogmouth**: 用于Markdown文件预览
- **uv**: Python项目和环境管理
- **ripgrep**: 高性能文本搜索
- **fd**: 快速文件查找

---

**提示**: 使用 `:help <键位>` 命令可以查看Vim原生键位的详细说明，使用 `:WhichKey` 可以查看当前模式下的可用键位映射。

