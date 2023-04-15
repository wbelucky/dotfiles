local M = {}

M.config = function()
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
  local servers = require('wbelucky.lsp_servers')
  local default = {
    capabilities = base.capabilities,
    on_attach = base.on_attach,
  }

  mason_lspconfig.setup_handlers({
    function(server)
      require("lspconfig")[server].setup(vim.tbl_extend("force", default, servers[server] or {}))
    end,
    ["tsserver"] = function(_)
      require("typescript").setup({
        disable_commands = false, -- prevent the plugin from creating Vim commands
        debug = false, -- enable debug logging for commands
        go_to_source_definition = {
          fallback = true, -- fall back to standard LSP definition on failure
        },
        server = vim.tbl_extend(
          "force",
          default,
          servers["tsserver"] or {}
        )
      })
    end,
  })

  -- ref: https://github.com/delphinus/dotfiles/blob/2c87826171d4397767e935e8db681aac4a6cff01/.config/nvim/lua/modules/lsp/config.lua#L47-L54
  require('lsp_lines').setup()
  vim.diagnostic.config({
    -- virtual_text = false -- or
    -- virtual_text = {
    --   format = function(d)
    --     return ("%s (%s: %s)"):format(d.message, d.source, d.code)
    --   end,
    -- },
    -- virtual_lines = { only_current_line = true },
  })

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
end

return M
