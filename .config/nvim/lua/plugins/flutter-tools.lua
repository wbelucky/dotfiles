local M = {}

local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })
local enable_format_on_code_actions = function(bufnr)
  vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup_format,
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.code_action({ apply = true,
        context = { only = { 'source.fixAll' } },
      })
      vim.lsp.buf.format({ bufnr = bufnr })
    end,
  })
end

M.config = function()
  local base = require('wbelucky.lsp_base')
  -- ref: https://github.com/mj-hd/dotfiles/blob/afd71634e800a92ebf8f907ca11075b96475756c/nvim/autoload/plugins/nvim_lsp.vim#L143
  require("flutter-tools").setup {
    ui = {
      border = "none",
    },
    decorations = {
      statusline = {
        app_version = false,
        device = false,
      }
    },
    debugger = {
      enabled = false,
      run_via_dap = false,
    },
    fvm = true,
    widget_guides = {
      enabled = true,
    },
    closing_tags = {
      highlight = "ClosingTags",
      prefix = " ",
      enabled = true
    },
    dev_log = {
      enabled = true,
      open_cmd = "tabedit",
    },
    dev_tools = {
      autostart = false,
      auto_open_browser = false,
    },
    outline = {
      open_cmd = "30vnew",
      auto_open = false
    },
    lsp = {
      on_attach = function(client, bufnr)
        vim.cmd [[hi FlutterWidgetGuides ctermfg=237 guifg=#33374c]]
        vim.cmd [[hi ClosingTags ctermfg=244 guifg=#8389a3]]
        base.on_attach(client, bufnr)
        enable_format_on_code_actions(bufnr)
      end,
      capabilities = base.capabilities,
      settings = {
        showTodos = false,
        completeFunctionCalls = true,
        analysisExcludedFolders = {
          vim.fn.expand("$HOME/.pub-cache"),
          vim.fn.expand("$HOME/fvm"),
        }
      }
    }
  }
end

return M
