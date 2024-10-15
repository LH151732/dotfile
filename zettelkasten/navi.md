#tool #TUI

# Navi

Navi is a command-line bookmark manager that saves your bookmarks in a plain text file. It's a simple and easy-to-use alternative to browser bookmark managers like Pocket, Raindrop, etc.

## Features

- Search bookmarks with regex
- Import bookmarks from browsers
- Import and export bookmarks from/to Netscape HTML file
- Import and export bookmarks from/to Markdown file
- Import and export bookmarks from/to JSON file
- Import and export bookmarks from/to TSV file
- Import and export bookmarks from/to YAML file
- Import and export bookmarks from/to Readability file
- Import and export bookmarks from/to Pocket file
- Import and export bookmarks from/to Instapaper file
- Import and export bookmarks from/to Pinboard file
- Import and export bookmarks from/to Shaarli file
- Import and export bookmarks from/to browser files
- Import and export bookmarks from/to Google Chrome files


使用 Navi

Navi 可以在终端中交互式地提供常见命令的提示，并自动替换命令中的参数。
1. 使用 Cheatsheet

启动 Navi，默认情况下它会加载你本地的 cheatsheet：

sh

navi

此时，Navi 会打开一个交互界面，你可以通过关键字进行搜索，例如搜索 "grep" 或 "ffmpeg" 等你需要的命令。
2. 结合命令使用

你还可以将 Navi 集成到其他命令中，以获得更便捷的命令补全和参数替换。

例如，你可以使用 navi 来选择一个命令，并将其结果传递给 shell：

sh

navi | sh

这样，当你从 navi 中选择好命令后，它会直接在 shell 中执行。
3. 快速查找某个命令

你可以使用 navi 来查找某个特定的命令，通过 navi --query 选项来进行搜索：

sh

navi --query 'grep'

这将会显示所有和 grep 相关的命令条目。
4. 使用热键快速调用 Navi

为了更方便的使用，你可以为 navi 配置一个热键，以便快速调用它并查找命令。这可以通过在你的 bash 或 zsh 配置文件（例如 .bashrc 或 .zshrc）中添加以下内容来实现：

sh

# 使用 Ctrl-G 启动 Navi
bind -x '"\C-g": "navi"'

添加上述内容后，重新加载配置文件，然后按 Ctrl-G 就可以快速启动 navi。
5. 使用外部 cheatsheet

Navi 支持加载你自定义的 cheatsheet 或从外部来源加载。

添加你自己的 cheatsheet：

    将你的 .cheat 文件路径添加到 NAVI_PATH 环境变量中：

    sh

    export NAVI_PATH=/path/to/your/cheatsheets

使用 GitHub 上的公开 cheatsheet：

    你可以通过以下命令来浏览 GitHub 上公开的 cheatsheet：

    sh

    navi repo browse

    然后选择一个你感兴趣的 cheatsheet 来使用。

常见操作

    查找命令：启动 navi，输入关键字找到你需要的命令。
    运行命令：选中命令后，它会在终端中提示你输入需要的参数。
    保存新命令：如果你有常用命令，可以将它们写入 .cheat 文件中，以便以后通过 navi 快速查找和使用。

举个例子

假设你有一个 my_commands.cheat 文件，其中包含以下内容：

markdown

# 服务器操作相关命令

## 重启 nginx 服务器
sudo systemctl restart nginx

## 查找进程占用的端口
sudo lsof -i :{{端口号}}

当你运行 navi 并搜索 "nginx" 时，你将看到重启 nginx 的命令，当选择这个命令时，它会直接输出命令并可以运行。而如果你选择了查找端口占用的命令，它会提示你输入端口号，然后生成完整的命令。
