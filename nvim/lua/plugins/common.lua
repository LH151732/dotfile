return {
  -- 注释插件配置
  {
    "numToStr/Comment.nvim",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    opts = {
      -- 启用额外的键映射
      mappings = {
        -- 行注释
        basic = true,
        -- 块注释
        extra = true,
      },
      -- 启用上下文感知的注释（如在JSX中）
      pre_hook = function(ctx)
        local U = require("Comment.utils")

        -- 检测是否有treesitter支持
        local location = nil
        if vim.treesitter.get_node then
          location = vim.treesitter.get_node()
        end

        -- 如果有treesitter支持，使用上下文感知的注释
        if location and vim.bo.filetype == "typescriptreact" or vim.bo.filetype == "javascriptreact" then
          local ts_context = require("ts_context_commentstring.utils").get_cursor_context(ctx.ctype)
          if ts_context == "jsx_element" or ts_context == "jsx_attribute" or ts_context == "jsx_fragment" then
            return require("ts_context_commentstring.internal").calculate_commentstring()
          end
        end
      end,
    },
  },
  -- 在SSH会话中复制到系统剪贴板
  {
    "ojroques/nvim-osc52",
    config = function()
      require("osc52").setup({
        max_length = 0, -- 0为无限制
        silent = true,
        trim = false,
      })

      local function copy(lines, _)
        require("osc52").copy(table.concat(lines, "\n"))
      end

      local function paste()
        return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
      end

      vim.keymap.set("n", "<leader>c", copy, { desc = "OSC52 Copy" })

      vim.g.clipboard = {
        name = "osc52",
        copy = { ["+"] = copy, ["*"] = copy },
        paste = { ["+"] = paste, ["*"] = paste },
      }
    end,
  },

  -- 自动保存文件
  {
    "Pocco81/auto-save.nvim",
    opts = {
      execution_message = {
        message = function()
          return "" -- 静默保存，不显示消息
        end,
      },
      trigger_events = { "InsertLeave", "TextChanged" },
      condition = function(buf)
        local fn = vim.fn
        -- 不自动保存大文件
        if fn.getfsize(fn.expand("%:p")) > 100000 then
          return false
        end
        return true
      end,
    },
  },

  -- 项目范围内的搜索和替换
  {
    "nvim-pack/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<leader>sr",
        function()
          require("spectre").open()
        end,
        desc = "Replace in files (Spectre)",
      },
    },
    opts = {
      open_cmd = "noswapfile vnew",
      live_update = true,
      mapping = {
        ["toggle_line"] = {
          map = "t",
          cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
          desc = "toggle current item",
        },
        ["replace_cmd"] = {
          map = "c",
          cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
          desc = "input replace command",
        },
        ["run_current_replace"] = {
          map = "C",
          cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
          desc = "replace current line",
        },
        ["run_replace"] = {
          map = "R",
          cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
          desc = "replace all",
        },
      },
    },
  },

  -- 专注模式
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    keys = {
      {
        "<leader>z",
        function()
          require("zen-mode").toggle()
        end,
        desc = "专注模式",
      },
    },
    opts = {
      window = {
        width = 0.85, -- 窗口宽度占比
        options = {
          number = false, -- 禁用行号
          relativenumber = false,
          signcolumn = "no", -- 禁用标记列
          cursorline = false, -- 禁用当前行高亮
          cursorcolumn = false, -- 禁用当前列高亮
          foldcolumn = "0", -- 禁用折叠列
          list = false, -- 禁用不可见字符显示
        },
      },
      plugins = {
        gitsigns = { enabled = false }, -- 禁用git标记
        tmux = { enabled = false }, -- 如果用tmux，可以考虑启用
        twilight = { enabled = true }, -- 启用暗淡非活动代码
      },
      -- 进入zen模式时的钩子
      on_open = function()
        vim.g.zen_mode_active = true
      end,
      -- 退出zen模式时的钩子
      on_close = function()
        vim.g.zen_mode_active = false
      end,
    },
  },

  -- 增强代码折叠功能
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
      "nvim-treesitter/nvim-treesitter",
    },
    event = "BufReadPost",
    keys = {
      {
        "zR",
        function()
          require("ufo").openAllFolds()
        end,
        desc = "打开所有折叠",
      },
      {
        "zM",
        function()
          require("ufo").closeAllFolds()
        end,
        desc = "关闭所有折叠",
      },
      {
        "zr",
        function()
          require("ufo").openFoldsExceptKinds()
        end,
        desc = "打开部分折叠",
      },
      {
        "zm",
        function()
          require("ufo").closeFoldsWith()
        end,
        desc = "关闭部分折叠",
      },
      {
        "zp",
        function()
          require("ufo").peekFoldedLinesUnderCursor()
        end,
        desc = "预览折叠内容",
      },
    },
    config = function()
      -- 折叠相关选项设置
      vim.o.foldcolumn = "1" -- 显示折叠列
      vim.o.foldlevel = 99 -- 默认不折叠
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      -- 使用Treesitter作为主要折叠提供者，LSP作为备用
      require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { "treesitter", "indent" }
        end,
        -- 自定义折叠文本显示
        fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
          local newVirtText = {}
          local suffix = (" 󰁂 %d 行"):format(endLnum - lnum)
          local sufWidth = vim.fn.strdisplaywidth(suffix)
          local targetWidth = width - sufWidth
          local curWidth = 0

          for _, chunk in ipairs(virtText) do
            local chunkText = chunk[1]
            local chunkWidth = vim.fn.strdisplaywidth(chunkText)

            if targetWidth > curWidth + chunkWidth then
              table.insert(newVirtText, chunk)
            else
              chunkText = truncate(chunkText, targetWidth - curWidth)
              local hlGroup = chunk[2]
              table.insert(newVirtText, { chunkText, hlGroup })
              chunkWidth = vim.fn.strdisplaywidth(chunkText)

              if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
              end
              break
            end

            curWidth = curWidth + chunkWidth
          end

          table.insert(newVirtText, { suffix, "MoreMsg" })
          return newVirtText
        end,
        -- 启用预览
        preview = {
          win_config = {
            border = "rounded",
            winhighlight = "Normal:Normal",
            winblend = 0,
          },
          mappings = {
            scrollU = "<C-u>",
            scrollD = "<C-d>",
            closeOnBufLeave = true,
          },
        },
      })

      -- 禁用标准折叠方法，使用ufo管理
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function()
          vim.opt_local.foldmethod = "manual"
        end,
      })
    end,
  },
}
