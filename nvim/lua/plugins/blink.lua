return {
  -- 禁用原生 nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    enabled = false,
  },

  -- blink.cmp 配置
  {
    "saghen/blink.cmp",
    version = "*", -- 使用最新稳定版
    event = "InsertEnter",
    dependencies = {
      -- "rafamadriz/friendly", -- 代码片段（如需直接用，要配 LuaSnip）
      "L3MON4D3/LuaSnip",
      version = "v2.*",
    },
    opts = {
      -- ① 键位
      keymap = { preset = "enter" },

      -- ② 外观
      appearance = {
        nerd_font_variant = "mono",
      },

      -- ③ 补全行为
      completion = {
        documentation = { auto_show = true },
        ghost_text = { enabled = true },
      },

      snippets = {
        preset = "luasnip",
      },
      -- ⑤ 补全源
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },

      -- ⑥ 模糊匹配
      fuzzy = { implementation = "lua" },
    },
  },

  -- Catppuccin 主题集成
  {
    "catppuccin/nvim",
    optional = true,
    opts = function(_, opts)
      opts.integrations = opts.integrations or {}
      opts.integrations.blink_cmp = true
    end,
  },
}
