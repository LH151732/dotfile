-- 检测是否在 VSCode 中运行 Neovim
local is_vscode = vim.g.vscode ~= nil

return {
  -- Dashboard 插件，仅在非 VSCode 环境中启用
  {
    "nvimdev/dashboard-nvim",
    enabled = not is_vscode,
  },
  -- Lualine 状态栏，仅在非 VSCode 环境中启用
  {
    "nvim-lualine/lualine.nvim",
    enabled = not is_vscode,
  },
  -- Noice 插件，用于消息、命令行和弹出菜单，仅在非 VSCode 环境中启用
  {
    "folke/noice.nvim",
    enabled = not is_vscode,
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })
      table.insert(opts.routes, 1, {
        filter = {
          cond = function()
            return not focused
          end,
        },
        view = "notify_send",
        opts = { stop = false },
      })
      opts.commands = {
        all = {
          -- 用于 :Noice 的消息历史记录的选项
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      }
      opts.presets.lsp_doc_border = true
    end,
  },
  -- Notify 插件，仅在非 VSCode 环境中启用
  {
    "rcarriga/nvim-notify",
    enabled = not is_vscode,
    opts = {
      timeout = 5000,
      background_colour = "#000000",
      render = "wrapped-compact",
    },
  },
  -- Bufferline 插件，仅在非 VSCode 环境中启用
  {
    "akinsho/bufferline.nvim",
    enabled = not is_vscode,
    event = "VeryLazy",
    keys = {
      { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "下一个标签" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "上一个标签" },
    },
    opts = {
      options = {
        mode = "tabs",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },
  -- Incline 插件，仅在非 VSCode 环境中启用
  {
    "b0o/incline.nvim",
    enabled = not is_vscode,
    dependencies = {},
    event = "BufReadPre",
    priority = 1200,
    config = function()
      local helpers = require("incline.helpers")
      require("incline").setup({
        window = {
          padding = 0,
          margin = { horizontal = 0 },
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
          local modified = vim.bo[props.buf].modified
          local buffer = {
            ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
            " ",
            { filename, gui = modified and "bold,italic" or "bold" },
            " ",
            guibg = "#363944",
          }
          return buffer
        end,
      })
    end,
  },
  -- LazyGit 集成，仅在非 VSCode 环境中启用
  {
    "kdheepak/lazygit.nvim",
    enabled = not is_vscode,
    keys = {
      {
        ";c",
        ":LazyGit<Return>",
        silent = true,
        noremap = true,
      },
    },
    -- 可选的浮动窗口边框装饰
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  -- Dadbod UI 插件，在 VSCode 中也启用
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- DBUI 配置
      vim.g.db_ui_use_nerd_fonts = 1
    end,
    keys = {
      {
        "<leader>d",
        "<cmd>NvimTreeClose<cr><cmd>tabnew<cr><bar><bar><cmd>DBUI<cr>",
      },
    },
  },
  -- Nvim-tree 插件，仅在非 VSCode 环境中启用
  {
    "nvim-tree/nvim-tree.lua",
    enabled = not is_vscode,
    config = function()
      require("nvim-tree").setup({
        on_attach = function(bufnr)
          local api = require("nvim-tree.api")
          local function opts(desc)
            return {
              desc = "nvim-tree: " .. desc,
              buffer = bufnr,
              noremap = true,
              silent = true,
              nowait = true,
            }
          end
          -- 默认映射
          api.config.mappings.default_on_attach(bufnr)
          -- 自定义映射
          vim.keymap.set("n", "t", api.node.open.tab, opts("新标签页打开"))
        end,
        actions = {
          open_file = {
            quit_on_open = true,
          },
        },
        sort = {
          sorter = "case_sensitive",
        },
        view = {
          width = 30,
          relativenumber = true,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = true,
          custom = {
            "node_modules/.*",
          },
        },
        log = {
          enable = true,
          truncate = true,
          types = {
            diagnostics = true,
            git = true,
            profile = true,
            watcher = true,
          },
        },
      })
      if vim.fn.argc(-1) == 0 then
        vim.cmd("NvimTreeFocus")
      end
    end,
  },
}
