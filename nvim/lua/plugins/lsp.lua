-- ~/.config/nvim/lua/plugins/lsp.lua
return {
  -- Mason.nvim: 管理和安装 LSP 服务器及其他开发工具
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "luacheck",
        "shellcheck",
        "shfmt",
        "tailwindcss-language-server",
        "typescript-language-server",
        "css-lsp",
        "jdtls",
        "pyright",
        "rust-analyzer",
      })
    end,
  },

  -- Mason-lspconfig: 配合 Mason 管理 LSP 服务器
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    opts = {
      ensure_installed = {
        "pyright",
        "jdtls",
      },
      automatic_installation = true,
    },
  },

  -- nvim-lspconfig: 配置 LSP 服务器
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

      -- 设置全局诊断配置
      vim.diagnostic.config({
        virtual_text = not vim.g.vscode,
        signs = not vim.g.vscode,
        underline = not vim.g.vscode,
        update_in_insert = false,
        severity_sort = true,
      })

      -- 定义所有 LSP 服务器的配置
      local servers = {
        cssls = {},
        tailwindcss = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git")(...)
          end,
        },
        tsserver = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git")(...)
          end,
          single_file_support = false,
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "literal",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },
        html = {},
        lua_ls = {
          single_file_support = true,
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                workspaceWord = true,
                callSnippet = "Both",
              },
              misc = {
                parameters = {},
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
              doc = {
                privateName = { "^_" },
              },
              type = {
                castNumberToInteger = true,
              },
              diagnostics = {
                disable = { "incomplete-signature-doc", "trailing-space" },
                groupSeverity = {
                  strong = "Warning",
                  strict = "Warning",
                },
                groupFileStatus = {
                  ["ambiguity"] = "Opened",
                  ["await"] = "Opened",
                  ["codestyle"] = "None",
                  ["duplicate"] = "Opened",
                  ["global"] = "Opened",
                  ["luadoc"] = "Opened",
                  ["redefined"] = "Opened",
                  ["strict"] = "Opened",
                  ["strong"] = "Opened",
                  ["type-check"] = "Opened",
                  ["unbalanced"] = "Opened",
                  ["unused"] = "Opened",
                },
                unusedLocalExclude = { "_*" },
              },
              format = {
                enable = false,
                defaultConfig = {
                  indent_style = "space",
                  indent_size = "2",
                  continuation_indent_size = "2",
                },
              },
            },
          },
        },
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
              },
            },
          },
        },
        jdtls = {
          -- 只在非VSCode环境下启用jdtls
          autostart = not vim.g.vscode,
          cmd = { "jdtls" },
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git", "mvnw", "gradlew")(...)
          end,
          settings = {
            java = {
              -- 在 VSCode 中禁用诊断
              diagnostics = {
                enabled = not vim.g.vscode,
              },
              eclipse = {
                downloadSources = true,
              },
              configuration = {
                updateBuildConfiguration = "interactive",
                -- 在 VSCode 中禁用格式化
                format = {
                  enabled = not vim.g.vscode,
                },
              },
              maven = {
                downloadSources = true,
              },
              implementationsCodeLens = {
                enabled = not vim.g.vscode,
              },
              referencesCodeLens = {
                enabled = not vim.g.vscode,
              },
              references = {
                includeDecompiledSources = true,
              },
              format = {
                enabled = not vim.g.vscode,
              },
              -- 控制建议和补全
              completion = {
                enabled = not vim.g.vscode,
                postfix = {
                  enabled = not vim.g.vscode,
                },
              },
              signatureHelp = {
                enabled = not vim.g.vscode,
              },
            },
          },
          init_options = {
            bundles = {},
            workspaceFolders = vim.g.vscode and {} or nil,
          },
        },
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              checkOnSave = {
                command = "clippy",
              },
            },
          },
        },
      }

      -- 设置 LSP 服务器
      for server_name, config in pairs(servers) do
        config.capabilities = capabilities
        lspconfig[server_name].setup(config)
      end

      -- 配置 Mason LSP 自动安装和 setup handlers
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          if not servers[server_name] then
            lspconfig[server_name].setup({
              capabilities = capabilities,
            })
          end
        end,
      })
    end,
  },

  -- 补全插件: nvim-cmp 及其依赖
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      cmp.setup({
        enabled = function()
          -- 在VSCode中禁用nvim-cmp
          return not vim.g.vscode
        end,
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = {
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
          { name = "luasnip" },
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
          }),
        },
      })

      -- 为特定文件类型设置补全源
      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "cmp_git" },
        }, {
          { name = "buffer" },
        }),
      })

      -- 命令行模式补全
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },

  -- Snippets 插件
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  -- lspkind.nvim: 为补全项添加图标
  {
    "onsails/lspkind.nvim",
    config = function()
      require("lspkind").init({
        preset = "default",
      })
    end,
  },
}
