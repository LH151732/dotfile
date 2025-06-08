return {
  -- 添加一些基本的LSP设置
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
          "lua",
          "python",
          "java",
          "javascript",
          "typescript",
          "json",
          "yaml",
          "html",
          "css",
          "bash",
          "markdown",
          "tsx",
          "vim",
          "vimdoc",
        },
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
          local client = vim.lsp.get_client_by_id(args.data.client_id)

          -- 更多的缓冲区本地键位映射
          local opts = { buffer = bufnr }
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "转到声明" })
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "转到定义" })
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "显示文档" })
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "转到实现" })
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "签名帮助" })
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "重命名" })
          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "代码操作" })
          vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "查找引用" })
          vim.keymap.set("n", "<leader>f", function()
            vim.lsp.buf.format({ async = true })
          end, { buffer = bufnr, desc = "格式化" })

          -- 特殊处理Python文件和ruff_lsp
          if client.name == "ruff_lsp" and vim.bo[bufnr].filetype == "python" then
            -- 确保ruff作为补全源
          end

          -- 特殊处理Java文件和jdtls
          if client.name == "jdtls" and vim.bo[bufnr].filetype == "java" then
          end
        end,
      })
    end,
  },
}

