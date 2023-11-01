---@type LazySpec
local spec = {
  "jay-babu/mason-null-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "jose-elias-alvarez/null-ls.nvim",
    "jose-elias-alvarez/typescript.nvim",
  },
  config = function()
    local null_ls = require "null-ls"
    require("mason-null-ls").setup {
      ensure_installed = {
        "prettierd",
        "markdownlint",
        "eslint_d",
        "fish",
        "fish_indent",
        "stylua",
        "golangci_lint",
      },
      automatic_installation = false,
      handlers = {
        prettierd = function(source_name, method)
          null_ls.register(null_ls.builtins.formatting.prettierd.with {
            disabled_filetypes = { "markdown" },
          })
        end,
      },
    }
    local augroup = vim.api.nvim_create_augroup("FormatOnSave", {})

    local formatfunc = function(_, bufnr)
      -- neovim v0.8.0~ it was ng in my env because of bugs of rpc
      -- ref: https://github.com/neovim/nvim-lspconfig/wiki/Multiple-language-servers-FAQ#i-see-multiple-formatting-options-and-i-want-a-single-server-to-format-how-do-i-do-this
      -- local util = require 'vim.lsp.util'
      -- local params = util.make_formatting_params({})
      -- client.request('textDocument/formatting', params, nil, bufnr)
      return function()
        vim.lsp.buf.format {
          filter = function(c)
            return c.name == "null-ls"
          end,
          bufnr = bufnr,
        }
      end
    end

    null_ls.setup {
      sources = {
        null_ls.builtins.formatting.pyflyby,
        -- null_ls.builtins.formatting.prettierd.with {
        --   disabled_filetypes = { "markdown" },
        -- },
        -- null_ls.builtins.diagnostics.eslint_d.with {
        --   diagnostics_format = "[eslint] #{m}\n(#{c})",
        -- },
        -- null_ls.builtins.diagnostics.markdownlint,
        -- null_ls.builtins.formatting.markdownlint,
        -- null_ls.builtins.formatting.eslint_d,
        -- null_ls.builtins.code_actions.eslint_d,
        -- null_ls.builtins.diagnostics.fish,
        -- null_ls.builtins.formatting.fish_indent,
        -- null_ls.builtins.diagnostics.golangci_lint,
        -- null_ls.builtins.formatting.stylua,
        require "typescript.extensions.null-ls.code-actions",
      },
      on_attach = function(client, bufnr)
        if client.supports_method "textDocument/formatting" then
          vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = formatfunc(client, bufnr),
          })

          vim.keymap.set("n", "<leader>f", formatfunc(client, bufnr), { noremap = true, silent = true, buffer = bufnr })
        end
      end,
    }
  end,
}
return spec
