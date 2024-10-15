-- which-key 懒加载配置
return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy", -- 延迟加载
    config = function()
      local wk = require("which-key")
      wk.setup({})
    end,
  },

  -- Telekasten.nvim 懒加载配置
  {
    "renerocksai/telekasten.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = { "<leader>z" }, -- 当按下 <leader>z 时加载
    config = function()
      local telekasten = require("telekasten")
      local home = vim.fn.expand("~/zettelkasten")

      telekasten.setup({
        home = home,
        dailies = home .. "/daily",
        take_over_my_home = true,
        auto_set_filetype = true,
      })

      -- which-key 配置
      local wk = require("which-key")
      wk.add({
        { "<leader>z", name = "Telekasten" },
        { "<leader>zd", "<cmd>lua require('telekasten').find_daily_notes()<cr>", desc = "每日笔记", mode = "n" },
        { "<leader>zf", "<cmd>lua require('telekasten').find_notes()<cr>", desc = "查找笔记", mode = "n" },
        { "<leader>zg", "<cmd>lua require('telekasten').search_notes()<cr>", desc = "搜索笔记", mode = "n" },
        { "<leader>zl", "<cmd>lua require('telekasten').follow_link()<cr>", desc = "跟随链接", mode = "n" },
        { "<leader>zn", "<cmd>lua require('telekasten').new_note()<cr>", desc = "新建笔记", mode = "n" },
        { "<leader>zt", "<cmd>lua require('telekasten').show_tags()<cr>", desc = "标签", mode = "n" },
        { "<leader>zz", "<cmd>lua require('telekasten').new_daily()<cr>", desc = "创建每日任务", mode = "n" },
      })
    end,
  },
}
