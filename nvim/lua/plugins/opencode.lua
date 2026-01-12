return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    { "folke/snacks.nvim" },
  },
  event = "VeryLazy",
  keys = {
    { "<leader>oa", function() require("opencode").ask("@this: ") end, desc = "OpenCode Ask" },
    { "<leader>os", function() require("opencode").select() end, desc = "OpenCode Select" },
    { "<leader>ot", function() require("opencode").toggle() end, desc = "OpenCode Toggle" },
    { "<leader>op", function() require("opencode").prompt() end, desc = "OpenCode Prompt" },
    { "go", function() require("opencode").operator() end, mode = { "n", "v" }, desc = "OpenCode Operator" },
  },
  config = function()
    vim.g.opencode_opts = {}
    vim.o.autoread = true
  end,
}
