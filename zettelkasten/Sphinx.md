#Python #Tool #Doc #HTML

# Sphinx
  Sphinx 是一个基于Python的文档生成工具，类似于Java里面的Javac，可以生成HTML,PDF,LateX等格式的文档。


# Usage
  1. 创建项目：
    ```bash
    sphinx-quickstart
    ```
  2. 编辑配置文件：
    ```bash
    vim conf.py
    ```
  3. 编辑文档：
    ```bash
    vim index.rst
    ```
  4. 生成文档：
    ```bash
    make html
    ```
  5. 查看文档：
    ```bash
    firefox build/html/index.html
    ```
  6. 清理文档：
    ```bash
    make clean
    ```
  7. 生成PDF文档：
    ```bash
    make latexpdf
    ```
  8. 生成Epub文档：
    ```bash
    make epub
    ```
  9. 生成单个文档：
    ```bash
    sphinx-build -b html source build
    ```

# Example
  使用 Sphinx 生成文档

      初始化 Sphinx 项目： 在你的项目根目录中运行以下命令来初始化一个 Sphinx 项目：


  sphinx-quickstart

  这会生成一些必要的文件，包括 conf.py 和 index.rst，这些文件用来配置和定义文档的内容结构。

  自动生成代码注释文档：

      首先，你需要使用 sphinx-apidoc 从 Python 源代码中提取注释，生成文档：

      sh

      sphinx-apidoc -o docs/ your_project/

      这会生成一些 .rst 文件，这些文件包含项目代码的结构和注释。

  编译文档：

      在 docs/ 目录中，运行以下命令生成 HTML 格式的文档：

      sh

          make html

          生成的 HTML 文档会位于 docs/_build/html/ 目录下，你可以用浏览器打开查看。

  自动提取 Docstring

  Sphinx 支持自动提取 Python 代码中的 docstring（文档字符串），这使得你可以像 Java 使用 Javadoc 那样，只需在代码中添加注释，Sphinx 就可以自动生成 API 文档。

  例如，Python 代码中的函数：

  python

  def greet(name):
      """
      Greet a person by their name.

      :param name: The name of the person to greet.
      :type name: str
      """
      print(f"Hello, {name}!")

  Sphinx 会自动解析这些文档字符串，并生成对应的 API 文档。
