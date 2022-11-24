local status, null_ls = pcall(require, "null-ls")
if (not status) then return end

local util = require 'vim.lsp.util'
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local lsp_formatting = function(client, bufnr)
  -- ref: https://github.com/neovim/nvim-lspconfig/wiki/Multiple-language-servers-FAQ#i-see-multiple-formatting-options-and-i-want-a-single-server-to-format-how-do-i-do-this
  local params = util.make_formatting_params({})
  client.request('textDocument/formatting', params, nil, bufnr)
  -- TODO: neovim v0.8.0~ it was ng in my env because of bugs of rpc
  -- vim.lsp.buf.formatting({
  --   filter = function(client)
  --     return client.name == "null-ls"
  --   end,
  --   bufnr = bufnr,
  -- })
end

null_ls.setup {
  sources = {
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.diagnostics.eslint_d.with({
      diagnostics_format = '[eslint] #{m}\n(#{c})'
    }),
    null_ls.builtins.diagnostics.fish
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          lsp_formatting(client, bufnr)
        end,
      })
    end
  end
}

vim.api.nvim_create_user_command(
  'DisableLspFormatting',
  function()
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
  end,
  { nargs = 0 }
)
