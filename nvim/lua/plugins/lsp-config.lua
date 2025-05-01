return {
  -- LSP配置
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      -- 获取blink.cmp的LSP能力配置
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      
      -- 设置服务器
      local lspconfig = require("lspconfig")
      
      -- Python - ruff
      lspconfig.ruff_lsp.setup({
        capabilities = capabilities,
        settings = {
          ruff = {
            enableCompletion = true,
          },
        },
      })
      
      -- 其他LSP服务器
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      })
      
      -- 其他服务器
      lspconfig.eslint.setup({capabilities = capabilities})
      lspconfig.tsserver.setup({capabilities = capabilities})
      lspconfig.tailwindcss.setup({capabilities = capabilities})
      lspconfig.jsonls.setup({capabilities = capabilities})
    end,
  },
  
  -- LSP进度提示
  {
    "j-hui/fidget.nvim",
    enabled = false, -- 可选的进度提示，如果不需要可以禁用
    opts = {},
  },
  
  -- Mason配置
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        "ruff",             -- Python linter/formatter
        "ruff-lsp",         -- Python LSP based on ruff
        "jdtls",            -- Java
        "lua-language-server", -- Lua
        "typescript-language-server", -- TypeScript
        "eslint-lsp",       -- ESLint
        "json-lsp",         -- JSON
        "tailwindcss-language-server",  -- Tailwind CSS
        "stylua",           -- Lua formatter
        "shfmt",            -- Shell formatter
        "prettier",         -- JavaScript/TypeScript formatter
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      
      -- 确保安装Mason商店里的工具
      local mr = require("mason-registry")
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
  
  -- 集成mason和lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      -- 自动设置mason安装的LSP
      automatic_installation = true,
    },
  },
  
  -- 特殊Java配置
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    config = function()
      -- 在Java文件开启时启动jdtls
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = function()
          local jdtls = require("jdtls")
          local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
          local root_dir = require("jdtls.setup").find_root(root_markers)
          local home = os.getenv("HOME")
          
          -- 获取Mason安装的jdtls路径
          local mason_registry = require("mason-registry")
          local jdtls_pkg = mason_registry.get_package("jdtls")
          local jdtls_path = jdtls_pkg:get_install_path()
          
          -- 设置jdtls的命令和参数
          local os_config = "linux"
          if vim.fn.has("mac") == 1 then
            os_config = "mac"
          elseif vim.fn.has("win32") == 1 then
            os_config = "win"
          end
          
          local cmd = {
            "java",
            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
            "-Dosgi.bundles.defaultStartLevel=4",
            "-Declipse.product=org.eclipse.jdt.ls.core.product",
            "-Dlog.protocol=true",
            "-Dlog.level=ALL",
            "-Xmx1g",
            "--add-modules=ALL-SYSTEM",
            "--add-opens", "java.base/java.util=ALL-UNNAMED",
            "--add-opens", "java.base/java.lang=ALL-UNNAMED",
            "-jar", vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
            "-configuration", jdtls_path .. "/config_" .. os_config,
            "-data", home .. "/.cache/jdtls-workspace/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
          }
          
          -- 获取blink.cmp的LSP能力配置
          local capabilities = require("blink.cmp").get_lsp_capabilities()
          
          -- 启动jdtls
          jdtls.start_or_attach({
            cmd = cmd,
            root_dir = root_dir,
            capabilities = capabilities,
            settings = {
              java = {
                signatureHelp = { enabled = true },
                contentProvider = { preferred = "fernflower" },
                completion = {
                  favoriteStaticMembers = {
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.junit.Assert.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                  },
                },
                sources = {
                  organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                  },
                },
                codeGeneration = {
                  toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                  },
                  useBlocks = true,
                },
                format = { enabled = true },
              },
            },
            init_options = {
              bundles = {}
            },
          })
        end,
      })
    end,
  },
  
  -- LSP自动命令
  {
    "neovim/nvim-lspconfig",
    init = function()
      -- 创建一些有用的全局键位映射
      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "显示当前行诊断" })
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "上一个诊断" })
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "下一个诊断" })
      vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "诊断列表" })
      
      -- LSP附加时的按键映射
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          
          -- 更多的缓冲区本地键位映射
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "转到声明" })
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "转到定义" })
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "显示文档" })
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "转到实现" })
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "签名帮助" })
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "重命名" })
          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "代码操作" })
          vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "查找引用" })
          vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, { buffer = bufnr, desc = "格式化" })
        end,
      })
    end,
  },
  
  -- 添加Treesitter支持
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
        ensure_installed = {
          "lua", "python", "java", "javascript", "typescript", 
          "json", "yaml", "html", "css", "bash", "markdown",
          "tsx", "vim", "vimdoc"
        },
      })
    end,
  },
}