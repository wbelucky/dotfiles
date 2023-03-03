local M = {}


M.config = function()
  local null_ls = require('null-ls')
  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

  local formatfunc = function(_, bufnr)
    -- neovim v0.8.0~ it was ng in my env because of bugs of rpc
    -- ref: https://github.com/neovim/nvim-lspconfig/wiki/Multiple-language-servers-FAQ#i-see-multiple-formatting-options-and-i-want-a-single-server-to-format-how-do-i-do-this
    -- local util = require 'vim.lsp.util'
    -- local params = util.make_formatting_params({})
    -- client.request('textDocument/formatting', params, nil, bufnr)

    vim.lsp.buf.format({
      filter = function(c)
        return c.name == "null-ls"
      end,
      bufnr = bufnr,
    })
  end

  null_ls.setup {
    sources = {
      null_ls.builtins.formatting.prettierd,
      null_ls.builtins.diagnostics.eslint_d.with({
        diagnostics_format = '[eslint] #{m}\n(#{c})'
      }),
      null_ls.builtins.formatting.eslint_d,
      null_ls.builtins.code_actions.eslint_d,
      null_ls.builtins.diagnostics.fish,
      null_ls.builtins.diagnostics.golangci_lint,
      require("typescript.extensions.null-ls.code-actions"),
    },
    on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            formatfunc(client, bufnr)
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
end

return M
