---@type LazySpec
local spec = {
  "neovim/nvim-lspconfig",
  init = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    -- change a keymap
    keys[#keys + 1] = { "gh", vim.lsp.buf.hover, desc = "Hover" }

    local rename_key = "<leader>n"
    -- https://github.com/LazyVim/LazyVim/blob/97480dc5d2dbb717b45a351e0b04835f138a9094/lua/lazyvim/plugins/lsp/keymaps.lua#L44C3-L57C6
    if LazyVim.has "inc-rename.nvim" then
      keys[#keys + 1] = {
        rename_key,
        function()
          local inc_rename = require "inc_rename"
          return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand "<cword>"
        end,
        expr = true,
        desc = "Rename",
        has = "rename",
      }
    else
      keys[#keys + 1] = { rename_key, vim.lsp.buf.rename, desc = "Rename", has = "rename" }
    end
    -- disable a keymap
    --keys[#keys + 1] = { "K", false }
    -- add a keymap
    --keys[#keys + 1] = { "H", "<cmd>echo 'hello'<cr>" }
  end,
}

return spec
