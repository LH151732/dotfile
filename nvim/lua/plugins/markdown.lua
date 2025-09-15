return {
  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    ft = { "markdown" },
    config = function()
      require("peek").setup({
        theme = "dark",
        -- 先用系统浏览器打开，绕过 webview 依赖
        app = "browser", -- 等会儿可以改成具体浏览器，比如 "firefox" 或 {"chromium","--new-window"}
        -- app = "webview", -- 想用嵌入式预览再改回这行
      })
      vim.api.nvim_create_user_command("PeekOpen", function()
        require("peek").open()
      end, {})
      vim.api.nvim_create_user_command("PeekClose", function()
        require("peek").close()
      end, {})
    end,
  },
  -- For `plugins/markview.lua` users.
  "OXY2DEV/markview.nvim",
  lazy = false,
  priority = 49,
  opts = {
    experimental = {
      check_rtp_message = false,
    },
  },
}
