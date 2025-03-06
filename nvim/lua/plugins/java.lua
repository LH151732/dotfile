-- 专门的 Java LSP 配置文件
return {
  -- 确保已经导入 LazyVim 的 Java 支持模块
  {
    "LazyVim/LazyVim",
    optional = true,
    opts = {
      -- 确保 Java 扩展被激活
      spec = {
        { import = "lazyvim.plugins.extras.lang.java" }
      }
    }
  },
  
  -- 手动配置 jdtls 以修复与 VSCode 的集成问题
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    dependencies = {
      "williamboman/mason.nvim",
    },
    config = function()
      local ok, jdtls = pcall(require, "jdtls")
      if not ok then
        vim.notify("jdtls 未安装", vim.log.levels.ERROR)
        return
      end
      
      -- 自动启动 jdtls
      local function setup_jdtls()
        -- 设置 jdtls 参数
        local mason_registry = require("mason-registry")
        
        -- 确保使用 Mason 安装的 jdtls
        local jdtls_path
        if mason_registry.is_installed("jdtls") then
          jdtls_path = mason_registry.get_package("jdtls"):get_install_path()
        else
          vim.notify("请通过 Mason 安装 jdtls", vim.log.levels.ERROR)
          return
        end
        
        -- 项目根目录
        local root_markers = {
          ".git",
          "mvnw",
          "gradlew",
          "pom.xml",
          "build.gradle",
          ".project"
        }
        
        local root_dir = require("jdtls.setup").find_root(root_markers)
        if not root_dir then
          -- 移除警告消息，直接使用当前工作目录
          root_dir = vim.fn.getcwd()
        end
        
        -- 设置 jdtls 工作目录和配置目录
        local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
        local workspace_dir = vim.fn.expand("~/.cache/jdtls/workspace/" .. project_name)
        local config_dir = vim.fn.expand("~/.cache/jdtls/config/" .. project_name)
        
        -- 确保目录存在
        vim.fn.mkdir(workspace_dir, "p")
        vim.fn.mkdir(config_dir, "p")
        
        -- 配置 lombok 支持
        local lombok_jar = jdtls_path .. "/lombok.jar"
        
        -- 构建 jdtls 命令
        local cmd = {
          vim.fn.expand("~/.local/share/nvim/mason/bin/jdtls"),
          "--jvm-arg=-Xmx1G",
          "--jvm-arg=-Xms100m",
          "--jvm-arg=-javaagent:" .. lombok_jar,
          "-configuration", config_dir,
          "-data", workspace_dir,
        }
        
        -- 获取 Java 调试适配器包
        local bundles = {}
        local java_debug_path = vim.fn.expand("~/.local/share/nvim/mason/packages/java-debug-adapter")
        if vim.fn.isdirectory(java_debug_path) ~= 0 then
          local plugin_path = java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar"
          vim.list_extend(bundles, vim.split(vim.fn.glob(plugin_path), "\n"))
        end
        
        -- 获取 Java 测试包
        local java_test_path = vim.fn.expand("~/.local/share/nvim/mason/packages/java-test")
        if vim.fn.isdirectory(java_test_path) ~= 0 then
          local test_bundle_paths = {
            java_test_path .. "/extension/server/*.jar",
          }
          for _, path in ipairs(test_bundle_paths) do
            vim.list_extend(bundles, vim.split(vim.fn.glob(path), "\n"))
          end
        end
        
        -- jdtls 配置
        local config = {
          cmd = cmd,
          root_dir = root_dir,
          init_options = {
            bundles = bundles,
          },
          settings = {
            java = {
              signatureHelp = { enabled = true },
              contentProvider = { preferred = "fernflower" },
              completion = {
                favoriteStaticMembers = {
                  "org.junit.Assert.*",
                  "org.junit.Assume.*",
                  "org.junit.jupiter.api.Assertions.*",
                  "org.junit.jupiter.api.Assumptions.*",
                  "org.junit.jupiter.api.DynamicContainer.*",
                  "org.junit.jupiter.api.DynamicTest.*",
                  "org.hamcrest.MatcherAssert.assertThat",
                  "org.hamcrest.Matchers.*",
                  "org.hamcrest.CoreMatchers.*",
                },
                importOrder = {
                  "java",
                  "javax",
                  "com",
                  "org"
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
              configuration = {
                updateBuildConfiguration = "interactive",
                runtimes = {
                  {
                    name = "JavaSE-11",
                    path = vim.fn.expand("~/.sdkman/candidates/java/11.0."),
                  },
                  {
                    name = "JavaSE-17",
                    path = vim.fn.expand("~/.sdkman/candidates/java/17.0."),
                  },
                  {
                    name = "JavaSE-21",
                    path = vim.fn.expand("~/.sdkman/candidates/java/21.0."),
                  },
                },
              },
              maven = {
                downloadSources = true,
              },
              implementationsCodeLens = {
                enabled = true,
              },
              referencesCodeLens = {
                enabled = true,
              },
              references = {
                includeDecompiledSources = true,
              },
              inlayHints = {
                parameterNames = {
                  enabled = "all", -- literals, all, none
                },
              },
              format = {
                enabled = true,
              },
            },
          },
          flags = {
            allow_incremental_sync = true,
          },
          capabilities = {
            workspace = {
              configuration = true
            },
            textDocument = {
              completion = {
                completionItem = {
                  snippetSupport = true
                }
              }
            }
          },
        }
        
        -- 启动服务器
        require("jdtls").start_or_attach(config)
        
        -- 设置回调，用于处理 vscode.java.resolveMainClass 命令
        vim.api.nvim_create_autocmd("LspAttach", {
          callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client and client.name == "jdtls" then
              -- 设置键盘映射
              local opts = { noremap = true, silent = true, buffer = args.buf }
              vim.keymap.set("n", "<A-o>", jdtls.organize_imports, opts)
              vim.keymap.set("n", "<leader>jv", jdtls.extract_variable, opts)
              vim.keymap.set("n", "<leader>jc", jdtls.extract_constant, opts)
              vim.keymap.set("n", "<leader>jm", jdtls.extract_method, opts)
              
              -- 启用 Java 调试支持
              jdtls.setup_dap({ hotcodereplace = "auto" })
              
              -- 设置主类探测
              require("jdtls.dap").setup_dap_main_class_configs()
            end
          end,
        })
      end
      
      -- 当打开 Java 文件时自动启动 jdtls
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = setup_jdtls,
      })
      
      -- 如果当前文件是 Java 文件，立即设置 jdtls
      if vim.bo.filetype == "java" then
        setup_jdtls()
      end
    end,
  },
}
