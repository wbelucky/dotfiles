-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.spelllang = { "en", "cjk" }

vim.opt.scrolloff = 999
vim.opt.sidescrolloff = 999

vim.opt.swapfile = false

vim.opt.shell = "fish"
vim.opt.clipboard = "unnamedplus"

local status, private_init = pcall(require, "private.init")
if status then
  private_init.setup()
end
