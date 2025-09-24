return {
  -- 颜色高亮插件
  {
    "nvim-mini/mini.hipatterns",
    event = "BufReadPre",
    opts = {},
  },

  -- Tokyo Night 主题
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },

  -- Catppuccin 主题
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "mocha",
      transparent_background = true,
      term_colors = true,
      integrations = {
        treesitter = true,
        nvimtree = true,
        cmp = true,
        gitsigns = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
    end,
  },

  -- Rose Pine 主题
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
      on_highlights = function(hl, c)
        hl.Comment = { fg = "#FFB7C5", italic = true }
        hl.Pmenu = { bg = "#232136", blend = 15 }
        hl.PmenuSel = { bg = "#2a273f", blend = 15 }
        hl.PmenuSbar = { bg = "#232136" }
        hl.PmenuThumb = { bg = "#2a273f" }
        hl.StatusLine = { fg = "#e0def4", bg = "#232136", blend = 15 }
        hl.StatusLineNC = { fg = "#6e6a86", bg = "#232136", blend = 15 }
        hl.NormalFloat = { bg = "#232136", blend = 15 }
        hl.FloatBorder = { fg = "#FFC1E3", bg = "NONE" }
        hl.VertSplit = { fg = "#FFC1E3" }
        hl.Search = { bg = "#2a273f", fg = "#e0def4" }
        hl.IncSearch = { bg = "#2a273f", fg = "#e0def4" }
        hl.Visual = { bg = "#2a273f" }
      end,
    },
    config = function(_, opts)
      require("rose-pine").setup(opts)
      vim.g.terminal_color_0 = "#232136"
      vim.g.terminal_color_8 = "#6e6a86"
      vim.g.terminal_color_7 = "#e0def4"
      vim.g.terminal_color_15 = "#e0def4"
    end,
  },

  -- Gruvbox 主题
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = true,
    opts = {
      transparent_mode = true,
      contrast = "hard",
      italic = {
        strings = false,
        comments = true,
        operators = false,
        folds = true,
      },
    },
  },

  -- GitHub 主题
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false,
    priority = 1000,
    config = function()
      require("github-theme").setup({
        options = {
          transparent = true,
          darken = {
            floats = false,
          },
        },
      })
    end,
  },

  -- Melange 主题
  {
    "savq/melange-nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true

      -- 创建一个函数来设置透明背景
      local function set_melange_transparent()
        vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "Folded", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "FoldColumn", { bg = "NONE" })
      end

      -- 在 ColorScheme 事件时设置
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "melange",
        callback = set_melange_transparent,
      })

      -- 在 VimEnter 和 BufEnter 时也设置，确保透明效果持续
      vim.api.nvim_create_autocmd({ "VimEnter", "BufEnter" }, {
        callback = function()
          if vim.g.colors_name == "melange" then
            set_melange_transparent()
          end
        end,
      })
    end,
  },

  -- SpaceDuck 主题
  {
    "spaceduck-theme/nvim",
    name = "spaceduck",
    lazy = false,
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true

      local function set_spaceduck_transparent()
        vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "Folded", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "FoldColumn", { bg = "NONE" })
      end

      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "spaceduck",
        callback = set_spaceduck_transparent,
      })

      vim.api.nvim_create_autocmd({ "VimEnter", "BufEnter" }, {
        callback = function()
          if vim.g.colors_name == "spaceduck" then
            set_spaceduck_transparent()
          end
        end,
      })
    end,
  },

  -- Boo 主题
  {
    "rockerBOO/boo-colorscheme-nvim",
    lazy = false,
    priority = 1000,
    opts = {
      italic = true,
      theme = "boo", -- 可选: sunset_cloud, radioactive_waste, forest_stream, crimson_moonlight
    },
    config = function(_, opts)
      vim.opt.termguicolors = true
      require("boo-colorscheme").use(opts)

      local function set_boo_transparent()
        vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "Folded", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "FoldColumn", { bg = "NONE" })
      end

      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "boo",
        callback = set_boo_transparent,
      })

      vim.api.nvim_create_autocmd({ "VimEnter", "BufEnter" }, {
        callback = function()
          if vim.g.colors_name == "boo" then
            set_boo_transparent()
          end
        end,
      })
    end,
  },

  -- Zenbones 主题集合
  {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true
      local themes = {
        "zenbones", "zenwritten", "neobones", "vimbones",
        "rosebones", "forestbones", "nordbones", "tokyobones",
        "seoulbones", "duckbones", "zenburned", "kanagawabones", "randombones"
      }
      for _, theme in ipairs(themes) do
        vim.api.nvim_create_autocmd("ColorScheme", {
          pattern = theme,
          callback = function()
            vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
            vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
            vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })
            vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
            vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE" })
            vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
            vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE" })
            vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE" })
            vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "NONE" })
            vim.api.nvim_set_hl(0, "Folded", { bg = "NONE" })
            vim.api.nvim_set_hl(0, "FoldColumn", { bg = "NONE" })
          end,
        })
      end
    end,
  },

  -- Telescope 配置（来自 Rose Pine）
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "NONE", fg = "#FFC1E3" })
      vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = "NONE", fg = "#FFC1E3" })
      vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { bg = "NONE", fg = "#FFC1E3" })
      vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { bg = "NONE", fg = "#FFC1E3" })

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

  -- 默认主题设置
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        local theme = vim.g.colors_name
        if theme then
          vim.cmd("colorscheme " .. theme)
        end
      end,
    },
  },
}