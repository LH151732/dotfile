-- ~/.config/nvim/lua/plugins/latex.lua
return {
  {
    "lervag/vimtex",
    ft = { "tex", "latex" }, -- 只在打开 tex 或 latex 文件时加载插件
    config = function()
      -- 设置 VimTeX 使用 Zathura 作为 PDF 查看器（编译时使用）
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_compiler_method = "latexmk" -- 使用 latexmk 进行编译

      -- 设置自定义快捷键，使用 macOS 默认应用程序打开 PDF
      vim.keymap.set("n", "<leader>ll", "<Cmd>VimtexCompile<CR>", { desc = "Compile LaTeX" })
      vim.keymap.set("n", "<leader>lv", function()
        local pdf_path = vim.fn.expand("%:r") .. ".pdf" -- 获取当前 tex 文件的 PDF 路径
        vim.fn.jobstart({ "open", pdf_path }, { detach = true }) -- 使用 open 命令打开 PDF
      end, { desc = "Open PDF with default viewer" })
    end,
  },
}
