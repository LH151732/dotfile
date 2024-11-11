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
        gitcommit = true,
        yaml = true,
        -- 一些常用的文件类型
        ["*"] = true, -- 在所有文件类型中启用
      },
      -- 添加复制保护
      copilot_node_command = "node", -- Node.js 版本
      server_opts_overrides = {
        trace = "verbose",
        settings = {
          advanced = {
            listCount = 10, -- 建议列表数量
            inlineSuggestCount = 3, -- 内联建议数量
          },
        },
      },
    },
    config = function(_, opts)
      require("copilot").setup(opts)
      -- 设置 Copilot 建议的颜色为灰色
      vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#777777" })

      -- 添加一些有用的命令
      vim.api.nvim_create_user_command("CopilotToggle", function()
        local enabled = require("copilot.client").is_enabled()
        if enabled then
          vim.cmd("Copilot disable")
          print("Copilot disabled")
        else
          vim.cmd("Copilot enable")
          print("Copilot enabled")
        end
      end, {})
    end,
  },
  { "zbirenbaum/copilot-cmp", enabled = false },
}
