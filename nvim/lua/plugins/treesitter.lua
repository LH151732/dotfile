return {
  -- Treesitter 配置，添加对多种语言的支持
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "OXY2DEV/markview.nvim" },
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    main = "nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
        "python",
        "java",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "yaml",
        "html",
        "css",
        "scss",
        "bash",
        "markdown",
        "markdown_inline",
        "vim",
        "vimdoc",
        "gitignore",
        "graphql",
        "http",
        "sql",
        "r",
        "svelte", -- Svelte (包含嵌入的 HTML/CSS/JS)
        "rust", -- Rust
        "toml", -- Cargo.toml
        "go", -- Go
        "gomod", -- go.mod
        "gosum", -- go.sum
        "gowork", -- go.work
        "cpp", -- C++
        "c", -- C
        "cmake", -- CMakeLists.txt
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "markdown" },
      },
      indent = { enable = true },
    },
    priority = 100,
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
