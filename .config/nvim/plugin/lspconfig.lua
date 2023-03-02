--vim.lsp.set_log_level("debug")

local global_opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', global_opts)
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', global_opts)
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', global_opts)
-- also use telescope.diagnostics
vim.keymap.set('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', global_opts)

require("mason").setup {}
local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup {
  automatic_installation = true,
}

local base = require('wbelucky.lsp_base')
mason_lspconfig.setup_handlers({
  function(server)
    local servers = require('wbelucky.lsp_servers')
    local default = {
      capabilities = base.capabilities,
      on_attach = base.on_attach,
    }
    require("lspconfig")[server].setup(vim.tbl_extend("force", default, servers[server] or {}))
  end,
  ["tsserver"] = function()
    require("typescript").setup({
      disable_commands = false, -- prevent the plugin from creating Vim commands
      debug = false, -- enable debug logging for commands
      go_to_source_definition = {
        fallback = true, -- fall back to standard LSP definition on failure
      },
      server = { -- pass options to lspconfig's setup method
        on_attach = base.on_attach,
        filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
        cmd = { "typescript-language-server", "--stdio" },
        capabilities = base.capabilities
      },
    })
  end,
})

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

--protocol.SymbolKind = { }
require('vim.lsp.protocol').CompletionItemKind = {
  '', -- Text
  '', -- Method
  '', -- Function
  '', -- Constructor
  '', -- Field
  '', -- Variable
  '', -- Class
  'ﰮ', -- Interface
  '', -- Module
  '', -- Property
  '', -- Unit
  '', -- Value
  '', -- Enum
  '', -- Keyword
  '﬌', -- Snippet
  '', -- Color
  '', -- File
  '', -- Reference
  '', -- Folder
  '', -- EnumMember
  '', -- Constant
  '', -- Struct
  '', -- Event
  'ﬦ', -- Operator
  '', -- TypeParameter
}

-- icon
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  -- This sets the spacing and the prefix, obviously.
  virtual_text = {
    spacing = 4,
    prefix = ''
  }
}
)
