---@type LazySpec
local spec = {
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  config = function()
    local lsp_lines = require "lsp_lines"
    lsp_lines.setup()
    vim.diagnostic.config {
      virtual_text = false,
    }
    vim.api.nvim_create_user_command("LspLinesToggle", function()
      lsp_lines.toggle()
    end, { nargs = 0 })
  end,
}

return spec
