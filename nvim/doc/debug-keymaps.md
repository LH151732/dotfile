# 调试键位映射 (plugins/nvim-dap.lua)

## 基础调试操作

| 键位       | 功能          | 说明                               |
| ---------- | ------------- | ---------------------------------- |
| `F2`       | 开始/继续调试 | 启动调试或继续执行                 |
| `Shift+F5` | 重新启动调试  | 重启当前调试会话                   |
| `Ctrl+F5`  | 停止/终止调试 | 终止调试会话                       |
| `F5`       | 单步跳过      | Step Over - 执行下一行但不进入函数 |
| `F6`       | 单步进入      | Step Into - 进入函数内部           |
| `F7`       | 切换调试UI    | 打开/关闭调试界面                  |

## 断点管理

| 键位        | 功能         | 说明                  |
| ----------- | ------------ | --------------------- |
| `Enter`     | 切换断点     | 在当前行设置/取消断点 |
| `<leader>B` | 设置条件断点 | 设置带条件的断点      |

## 高级调试功能

### Leader键组合

| 键位         | 功能         | 说明                               |
| ------------ | ------------ | ---------------------------------- |
| `<leader>ds` | 智能启动调试 | 根据文件类型和项目类型智能选择配置 |
| `<leader>dp` | 项目特定调试 | 使用项目特定的调试配置             |
| `<leader>do` | 单步退出     | Step Out - 跳出当前函数            |
| `<leader>dr` | 打开REPL     | 打开调试REPL控制台                 |

### Telescope集成

| 键位          | 功能     | 说明                      |
| ------------- | -------- | ------------------------- |
| `<leader>dbc` | 调试命令 | 通过Telescope选择调试命令 |
| `<leader>dbb` | 断点列表 | 查看所有断点              |
| `<leader>dbv` | 变量查看 | 查看调试变量              |
| `<leader>dbf` | 调用栈   | 查看调用栈帧              |

## 语言特定配置

### Python调试

#### 支持的项目类型

- **uv项目**: 自动检测 `pyproject.toml` + `.venv/pyvenv.cfg`
- **标准Python项目**: 使用系统或虚拟环境Python

#### Python调试配置

1. **Launch file (uv)**: 使用uv环境运行当前文件
2. **Launch file with arguments (uv)**: 带参数运行当前文件
3. **Run pytest (uv)**: 运行pytest测试
4. **Launch file**: 标准Python文件运行
5. **Launch file with arguments**: 带参数的标准运行

### Java调试

#### 支持的项目类型

- **Gradle项目**: 检测 `build.gradle`, `build.gradle.kts`, `gradlew`
- **Maven项目**: 检测 `pom.xml`
- **标准Java项目**: 普通Java项目

#### Java调试配置

- **Gradle项目**:
  - Debug (Attach) - Remote Gradle: 远程附加调试(端口5005)
  - Launch Gradle Application: 启动Gradle应用
  - Launch Gradle Test: 运行Gradle测试
- **标准Java项目**:
  - Launch Java Application: 启动Java应用
  - Debug (Attach): 附加调试(端口5005)

### JavaScript/TypeScript调试

支持的调试配置:

1. **Launch file**: 启动当前文件
2. **Attach**: 附加到正在运行的进程

### C/C++/Rust调试

使用CodeLLDB适配器:

1. **Launch file**: 启动编译后的可执行文件

## 调试界面配置

### UI布局

- **右侧面板**: 变量作用域、断点、调用栈、监视
- **底部面板**: REPL控制台、控制台输出

### 浮动窗口

- **最大高度**: 90%
- **最大宽度**: 90%
- **边框**: 圆角
- **关闭键**: `q`, `Esc`

### 断点标记

| 符号 | 含义         |
| ---- | ------------ |
| `●`  | 普通断点     |
| `◐`  | 条件断点     |
| `○`  | 被拒绝的断点 |
| `◆`  | 日志断点     |
| `▶` | 当前执行位置 |

## 自动功能

### 智能检测

- **环境检测**: 自动检测Python虚拟环境
- **项目类型**: 自动识别uv、Gradle、Maven项目
- **适配器安装**: 通过Mason自动安装调试适配器

### UI自动化

- **调试开始**: 自动打开调试UI
- **调试结束**: 自动关闭调试UI
- **虚拟文本**: 显示变量值在代码行内

### Mason集成的调试器

| 调试器             | 支持语言              |
| ------------------ | --------------------- |
| python             | Python                |
| delve              | Go                    |
| js-debug-adapter   | JavaScript/TypeScript |
| codelldb           | C/C++/Rust            |
| java-debug-adapter | Java                  |
| java-test          | Java单元测试          |

## 项目特定功能

### 虚拟环境集成

- 与venv-selector插件集成
- 环境切换时自动更新调试器配置
- 支持监听虚拟环境变化事件

### 智能通知

调试启动时显示项目类型信息:

- "Starting debug with uv environment"
- "Starting debug with Gradle project"
- "Starting debug with standard Python"

