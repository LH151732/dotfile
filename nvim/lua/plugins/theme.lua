return {
  -- Highlight colors
  {
    "echasnovski/mini.hipatterns",
    event = "BufReadPre",
    opts = {},
  },

  -- Rose Pine theme
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    opts = {
      dark_variant = "main",
      bold_vert_split = false,
      dim_nc_background = false,
      disable_background = true,
      disable_float_background = true,
      disable_italics = true,

      -- 自定义高亮设置
      on_highlights = function(hl, c)
        -- 注释使用樱花粉色
        hl.Comment = { fg = "#FFB7C5", italic = true }

        -- 补全菜单样式
        hl.Pmenu = { bg = "#232136", blend = 15 }
        hl.PmenuSel = { bg = "#2a273f", blend = 15 }
        hl.PmenuSbar = { bg = "#232136" }
        hl.PmenuThumb = { bg = "#2a273f" }

        -- 状态栏样式
        hl.StatusLine = { fg = "#e0def4", bg = "#232136", blend = 15 }
        hl.StatusLineNC = { fg = "#6e6a86", bg = "#232136", blend = 15 }

        -- 浮动窗口样式
        hl.NormalFloat = { bg = "#232136", blend = 15 }
        hl.FloatBorder = { fg = "#FFC1E3", bg = "NONE" }

        -- 分割线样式
        hl.VertSplit = { fg = "#FFC1E3" }

        -- 搜索高亮
        hl.Search = { bg = "#2a273f", fg = "#e0def4" }
        hl.IncSearch = { bg = "#2a273f", fg = "#e0def4" }

        -- 选中文本样式
        hl.Visual = { bg = "#2a273f" }
      end,
    },
    config = function(_, opts)
      require("rose-pine").setup(opts)
      vim.cmd([[colorscheme rose-pine]])

      -- 设置终端颜色
      vim.g.terminal_color_0 = "#232136"
      vim.g.terminal_color_8 = "#6e6a86"
      vim.g.terminal_color_7 = "#e0def4"
      vim.g.terminal_color_15 = "#e0def4"
    end,
  },

  -- Telescope configuration
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      -- 移除背景颜色
      vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "NONE" })

      -- 设置边框为粉色
      vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "NONE", fg = "#FFC1E3" })
      vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = "NONE", fg = "#FFC1E3" })
      vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { bg = "NONE", fg = "#FFC1E3" })
      vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { bg = "NONE", fg = "#FFC1E3" })

      -- Telescope 配置
      require("telescope").setup({
        defaults = {
          prompt_prefix = "🔍 ",
          selection_caret = "❯ ",
          path_display = { "truncate" },
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
        },
      })
    end,
  },

  -- 其他可选的美化插件
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },
}
