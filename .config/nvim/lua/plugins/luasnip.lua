---@type LazySpec
local spec = {
  "L3MON4D3/LuaSnip",
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load {
      paths = { vim.env.VSNIP_DIR },
    }
    print "vsnip loaded"
  end,
}

return spec
