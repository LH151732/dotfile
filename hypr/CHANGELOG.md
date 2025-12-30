# Hyprland 配置更新日志

## 2025-11-06 - iPad 风格触摸手势支持

### 新增功能

#### 平板模式切换
- **快捷键**: `Super+Ctrl+T`
- **功能**: 一键切换平板模式,启用/禁用触摸手势
- **状态指示**: 通过通知显示当前模式和可用手势

#### iPad 风格多指触摸手势
使用 `lisgd` (Libinput Synthetic Gesture Daemon) 实现触摸屏手势支持:

| 手势 | 功能 | 说明 |
|------|------|------|
| 三指上滑 | 多任务/窗口选择器 | 打开 Rofi 窗口切换器 |
| 三指下滑 | 应用启动器 | 打开 Rofi 应用启动器 |
| 三指左滑 | 上一个工作区 | 循环切换到前一个工作区 |
| 三指右滑 | 下一个工作区 | 循环切换到后一个工作区 |
| 双指上滑 | 全屏切换 | 切换当前窗口全屏状态 |
| 双指下滑 | 全屏切换 | 切换当前窗口全屏状态 |
| 底部边缘单指上滑 | 虚拟键盘 | 显示/隐藏 wvkbd 虚拟键盘 |

#### 屏幕旋转与触摸设备同步
- **快捷键**: `Super+R`
- **功能**:
  - 屏幕旋转 0° → 90° → 180° → 270° → 0° 循环切换
  - 触摸设备自动同步旋转角度
  - 支持通知提示当前旋转角度
- **实现**: 使用 `input:touchdevice:transform` 关键字同步触摸输入方向

### 修改文件

#### 新增文件
1. **`~/.local/share/bin/lisgd-gestures.sh`**
   - iPad 风格手势配置脚本
   - 自动检测屏幕旋转角度
   - 配置所有多指触摸手势

2. **`CHANGELOG.md`** (本文件)
   - 配置更新日志记录

#### 修改文件
1. **`~/.local/share/bin/tablet_mode.sh`**
   - 新增 lisgd 手势监听启动/停止逻辑
   - 优化平板模式进入/退出通知
   - 添加手势提示说明

2. **`~/.local/share/bin/rotate_screen.sh`**
   - 修复触摸设备旋转同步
   - 使用 `input:touchdevice:transform` 替代设备特定配置
   - 添加旋转状态通知

3. **`~/.config/hypr/hyprland.conf`**
   - 注释自动启动 lisgd 的配置
   - 触摸手势现由平板模式脚本控制
   - 保留原有快捷键配置

4. **`~/.config/hypr/keybindings.conf`**
   - 已有 `Super+Ctrl+T` 平板模式切换绑定
   - 已有 `Super+R` 屏幕旋转绑定
   - 保持所有原有快捷键不变

### 技术细节

#### lisgd 配置参数
- **设备路径**: `/dev/input/event17` (ELAN9008:00 04F3:43C7)
- **滑动阈值**: 200 像素
- **旋转同步**: 自动读取 Hyprland 屏幕旋转角度
- **手势格式**: `"手指数,方向,边缘,距离,命令"`

#### 依赖项
- `lisgd`: 触摸屏手势守护进程
- `wvkbd-mobintl`: Wayland 虚拟键盘
- `hyprctl`: Hyprland IPC 控制工具
- `jq`: JSON 处理工具 (用于解析 Hyprland 状态)

### 使用说明

#### 启用平板模式
1. 按 `Super+Ctrl+T` 进入平板模式
2. 系统通知会显示手势提示
3. 开始使用多指触摸手势

#### 禁用平板模式
1. 再次按 `Super+Ctrl+T` 退出平板模式
2. 所有触摸手势将被禁用
3. 虚拟键盘自动关闭

#### 屏幕旋转
1. 按 `Super+R` 旋转屏幕
2. 触摸输入自动同步旋转
3. lisgd 手势方向自动适配

### 已知问题与限制

1. **lisgd 不支持点击手势**
   - 无法实现双击/长按等点击类手势
   - 只支持滑动方向手势

2. **滑动距离调整**
   - 当前阈值为 200 像素
   - 可通过修改 `-t` 参数调整灵敏度
   - 位置: `lisgd-gestures.sh` 第 22 行

3. **手势冲突**
   - 平板模式会禁用触控板打字时禁用功能
   - 避免虚拟键盘与触控板输入冲突

### 兼容性

- **测试设备**: ROG Z13 2025
- **触摸屏**: ELAN9008:00 04F3:43C7
- **Hyprland 版本**: 支持 `input:touchdevice:transform` 的版本
- **系统**: Arch Linux

### 调试信息

#### 查看触摸设备
```bash
libinput debug-events --show-keycodes
```

#### 查看 lisgd 进程
```bash
ps aux | grep lisgd
```

#### 手动测试手势
```bash
~/.local/share/bin/lisgd-gestures.sh
```

#### 查看 Hyprland 配置
```bash
hyprctl monitors -j
hyprctl devices -j
```

### 未来改进

- [ ] 支持自定义手势配置 UI
- [ ] 添加手势灵敏度调节选项
- [ ] 实现手势训练模式
- [ ] 支持更多边缘手势
- [ ] 添加手势可视化反馈

---

**作者**: HL
**日期**: 2025-11-06
**版本**: 1.0.0
