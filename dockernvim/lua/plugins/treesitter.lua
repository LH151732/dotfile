return {
  -- Treesitter 配置，添加对多种语言的支持
  {
    "nvim-treesitter/nvim-treesitter",
    tag = "v0.9.1",
    opts = {
      ensure_installed = {
        "javascript",
        "typescript",
        "css",
        "gitignore",
        "graphql",
        "http",
        "json",
        "scss",
        "sql",
        "vim",
        "lua",
        "markdown", -- 支持 Markdown
        "markdown_inline", -- 支持内联 Markdown
        "r", -- 支持 R 语言
        "java", -- 支持 Java
        "python", -- 支持 Python
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "markdown" }, -- 仅在 Markdown 中启用额外的高亮
      },
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      },
    },
    ft = { "markdown", "rmarkdown" }, -- 仅在 Markdown 和 R Markdown 文件中启用 Treesitter
  },
  -- Markdown 支持插件
  {
    "plasticboy/vim-markdown", -- 提供基本的 Markdown 支持
    ft = { "markdown", "rmarkdown" },
    config = function()
      vim.g.vim_markdown_folding_disabled = 1
      vim.g.vim_markdown_conceal = 0
    end,
  },
  -- Pandoc 语法支持插件
  {
    "vim-pandoc/vim-pandoc-syntax", -- 支持 Pandoc 扩展语法
    ft = { "markdown", "rmarkdown" },
  },
}
