---@type LazySpec
local spec = {
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  config = function()
    local lsp_lines = require "lsp_lines"
    lsp_lines.setup()
    vim.diagnostic.config {
      virtual_text = false,
      signs = false,
    }
    vim.api.nvim_create_user_command("LspLinesToggle", function()
      local state = lsp_lines.toggle()
      vim.diagnostic.config {
        virtual_text = not state,
        signs = not state,
      }
    end, { nargs = 0 })
  end,
}

return spec
