# LSP 键位映射 (plugins/lsp-config.lua)

## 全局LSP诊断键位

| 键位        | 功能           | 说明                          |
| ----------- | -------------- | ----------------------------- |
| `<leader>e` | 显示当前行诊断 | 以浮动窗口显示错误详情        |
| `[d`        | 上一个诊断     | 跳转到上一个错误/警告         |
| `]d`        | 下一个诊断     | 跳转到下一个错误/警告         |
| `<leader>q` | 诊断列表       | 在location list中显示所有诊断 |

## 缓冲区级LSP键位 (LSP附加时自动生效)

### 导航相关

| 键位 | 功能     | 说明                       |
| ---- | -------- | -------------------------- |
| `gD` | 转到声明 | 跳转到符号的声明位置       |
| `gd` | 转到定义 | 跳转到符号的定义位置       |
| `gi` | 转到实现 | 跳转到接口或抽象方法的实现 |
| `gr` | 查找引用 | 显示所有引用该符号的位置   |

### 信息显示

| 键位    | 功能     | 说明                      |
| ------- | -------- | ------------------------- |
| `K`     | 显示文档 | 显示光标下符号的hover文档 |
| `<C-k>` | 签名帮助 | 显示函数签名信息          |

### 代码操作

| 键位         | 功能     | 说明                   |
| ------------ | -------- | ---------------------- |
| `<leader>rn` | 重命名   | 重命名光标下的符号     |
| `<leader>ca` | 代码操作 | 显示可用的代码操作菜单 |
| `<leader>f`  | 格式化   | 格式化当前缓冲区       |

## LSP服务器配置

### Python (Ruff + Pyright)

- **Ruff LSP**: 提供快速linting和代码修复
- **Pyright**: 提供类型检查和智能补全
- **虚拟环境支持**: 自动检测uv、venv、pyenv环境

#### Python环境检测优先级

1. `$VIRTUAL_ENV` 环境变量
2. 项目根目录的 `.venv/bin/python`
3. `uv python find` 命令结果
4. `pyenv which python` 命令结果
5. 系统默认Python

### Lua (lua_ls)

- **补全**: 设置为 `Replace` 模式
- **Neovim**: 自动配置Neovim API支持

### JavaScript/TypeScript

- **ESLint**: 代码检查和修复
- **TypeScript Server**: 类型检查和补全
- **Tailwind CSS**: CSS类名补全

### JSON

- **JSON LSP**: JSON文件的语法检查和格式化

### Java (JDTLS)

- **自动配置**: 基于项目类型(Maven/Gradle)自动配置
- **工作空间**: 为每个项目创建独立的工作空间
- **依赖管理**: 自动下载和管理项目依赖

#### Java项目检测

- 检测 `.git`, `mvnw`, `gradlew`, `pom.xml`, `build.gradle` 等标记文件
- 自动配置Eclipse JDT配置目录
- 支持代码镜头(Code Lens)功能

## Mason集成

### 自动安装的工具

| 工具                        | 类型                    | 用途                            |
| --------------------------- | ----------------------- | ------------------------------- |
| ruff                        | Python linter/formatter | Python代码检查和格式化          |
| pyright                     | Python LSP              | Python类型检查                  |
| jdtls                       | Java LSP                | Java语言服务器                  |
| lua-language-server         | Lua LSP                 | Lua语言服务器                   |
| typescript-language-server  | TS/JS LSP               | TypeScript/JavaScript语言服务器 |
| eslint-lsp                  | JS/TS Linter            | ESLint语言服务器                |
| json-lsp                    | JSON LSP                | JSON语言服务器                  |
| tailwindcss-language-server | CSS LSP                 | Tailwind CSS语言服务器          |
| stylua                      | Lua formatter           | Lua代码格式化器                 |
| shfmt                       | Shell formatter         | Shell脚本格式化器               |
| prettier                    | JS/TS formatter         | JavaScript/TypeScript格式化器   |

### Mason命令

| 键位         | 功能      | 说明                |
| ------------ | --------- | ------------------- |
| `<leader>cm` | 打开Mason | 管理LSP服务器和工具 |

## Treesitter集成

### 支持的语言

- lua, python, java
- javascript, typescript, tsx
- json, yaml, html, css
- bash, markdown, vim, vimdoc

### 功能

- **语法高亮**: 基于AST的精准高亮
- **自动缩进**: 智能代码缩进
- **增量解析**: 提高性能

