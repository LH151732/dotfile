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
  -- blink
  {
    "saghen/blink.cmp",
    -- use a release tag to download pre-built binaries
    version = "*",
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- See the full "keymap" documentation for information on defining your own keymap.
      keymap = {
        -- set to 'none' to disable the 'default' preset
        preset = "default",

        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },

        -- disable a keymap from the preset
        ["<C-e>"] = {},

        ["<Tab>"] = {
          function(cmp)
            cmp.accept()
          end,
        },

        -- show with a list of providers
        ["<C-space>"] = {
          function(cmp)
            cmp.show({ providers = { "snippets" } })
          end,
        },

        -- control whether the next command will be run when using a function
        ["<C-n>"] = {
          function(cmp)
            if some_condition then
              return
            end -- runs the next command
            return true -- doesn't run the next command
          end,
          "select_next",
        },
        -- optionally, separate cmdline keymaps
        -- cmdline = {}
      },
      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- Will be removed in a future release
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
    },
    opts_extend = { "sources.default" },
  },
}
