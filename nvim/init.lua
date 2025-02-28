-- 主题管理器
local theme_file = vim.fn.stdpath("data") .. "/theme.txt"

-- 保存当前主题到文件
local function save_theme()
  local current_theme = vim.g.colors_name
  if current_theme then
    local file = io.open(theme_file, "w")
    if file then
      file:write(current_theme)
      file:close()
    end
  end
end

-- 加载保存的主题
local function load_theme()
  local file = io.open(theme_file, "r")
  if file then
    local theme = file:read("*all")
    file:close()
    if theme and theme ~= "" then
      -- 设置默认主题，避免闪烁
      vim.g.colors_name = theme
      -- 设置 LazyVim 的默认主题
      vim.g.default_colorscheme = theme
      -- 创建自动命令，确保在所有插件加载后应用主题
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyDone",
        callback = function()
          vim.cmd("colorscheme " .. theme)
        end,
        once = true,
      })
    end
  end
end

-- 立即加载主题
load_theme()

-- 在 Neovim 退出时保存当前主题
vim.api.nvim_create_autocmd("VimLeavePre", {
  pattern = "*",
  callback = function()
    save_theme()
  end,
})

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
