return {
  -- 先加载 LuaSnip 和 friendly-snippets
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      -- 自动加载friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      local luasnip = require("luasnip")

      -- 设置 <Tab> 跳转到下一个占位符或展开片段
      vim.keymap.set({ "i", "s" }, "<Tab>", function()
        if luasnip.expand_or_jumpable() then
          return "<Plug>luasnip-expand-or-jump"
        else
          return "<Tab>"
        end
      end, { silent = true, noremap = true, expr = true })

      -- 设置 <S-Tab> 跳转到上一个占位符
      vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
        if luasnip.jumpable(-1) then
          return "<Plug>luasnip-jump-prev"
        else
          return "<S-Tab>"
        end
      end, { silent = true, noremap = true, expr = true })
    end,
  },

  -- 然后加载 blink 配置，不影响之前的设定
  {
    "saghen/blink.cmp",
    version = "v0.*",
    dependencies = {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
    },
    opts = {
      snippets = {
        expand = function(snippet)
          require("luasnip").lsp_expand(snippet)
        end,
        active = function(filter)
          if filter and filter.direction then
            return require("luasnip").jumpable(filter.direction)
          end
          return require("luasnip").in_snippet()
        end,
        jump = function(direction)
          require("luasnip").jump(direction)
        end,
      },
      sources = {
        default = { "lsp", "path", "luasnip", "buffer" },
      },
    },
  },
}
