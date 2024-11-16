-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd({ "TermOpen", "WinEnter" }, {
  callback = function()
    if vim.opt.buftype:get() == "terminal" then
      vim.cmd("set nonu")
      vim.cmd("set norelativenumber")
      vim.cmd("startinsert")
    end
  end,
})
