return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    build = ":Copilot auth",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<Tab>",
          accept_word = false,
          accept_line = false,
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
        -- 可以在这里添加更多文件类型
      },
    },
    config = function(_, opts)
      require("copilot").setup(opts)
      -- 设置 Copilot 建议的颜色为灰色
      vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#777777" })
    end,
  },
  { "zbirenbaum/copilot-cmp", enabled = false },
}
