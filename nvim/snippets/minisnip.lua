return {
  {
    "saghen/blink.cmp",
    dependencies = "echasnovski/mini.snippets",
    opts = {
      snippets = { preset = "mini_snippets" },
      -- ensure you have the `snippets` source (enabled by default)
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
    },
  },
}
