require "wbelucky.base"
require "wbelucky.maps"

local packerGrp = vim.api.nvim_create_augroup("PackerUserConfig", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*/lua/wbelucky/plugins.lua" },
  command = "PackerCompile",
  group = packerGrp,
})

-- Commands
local create_cmd = vim.api.nvim_create_user_command
create_cmd("PackerInstall", function()
  require("wbelucky.plugins").install()
end, {})
create_cmd("PackerStatus", function()
  require("wbelucky.plugins").status()
end, {})
create_cmd("PackerUpdate", function()
  require("wbelucky.plugins").update()
end, {})
create_cmd("PackerSync", function()
  require("wbelucky.plugins").sync()
end, {})
create_cmd("PackerClean", function()
  require("wbelucky.plugins").clean()
end, {})
create_cmd("PackerCompile", function()
  require("wbelucky.plugins").compile()
end, {})
create_cmd("WbDebug", function()
  require("wbelucky.util").print_debug()
end, {})

local status, private_init = pcall(require, "private.init")
if status then
  private_init.setup()
end
