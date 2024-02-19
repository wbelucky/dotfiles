---@type LazySpec
local spec = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "LspInfo", "LspStart", "LspInstall", "LspUninstall" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "b0o/schemastore.nvim",
    "cmp-nvim-lsp",
    { "folke/neodev.nvim" },
  },
  config = function()
    local global_opts = { noremap = true, silent = true }
    vim.keymap.set("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", global_opts)
    vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", global_opts)
    vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", global_opts)
    -- also use telescope.diagnostics
    vim.keymap.set("n", "<leader>Q", "<cmd>lua vim.diagnostic.setloclist()<CR>", global_opts)

    -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
    require("neodev").setup {
      library = {
        plugins = "lsp_lines.nvim",
      },
      -- add any options here, or leave empty to use the default settings
    }

    local servers = require "rc.plugins.lsp.lsp_servers"
    local mason_lspconfig = require "mason-lspconfig"
    mason_lspconfig.setup {
      ensure_installed = vim.tbl_filter(function(v)
        -- exclude them
        return not vim.tbl_contains({
          "clangd",
          -- "denols"
        }, v)
      end, vim.tbl_keys(servers)),
      automatic_installation = true,
    }

    local base = require "rc.plugins.lsp.lsp_base"
    local default = {
      capabilities = base.capabilities,
      on_attach = base.on_attach,
    }

    mason_lspconfig.setup_handlers {
      function(server)
        local conf = vim.tbl_deep_extend("force", default, servers[server] or {})
        require("lspconfig")[server].setup(conf)
      end,
      --- ["tsserver"] = function(_)
      ---   require("typescript").setup {
      ---     disable_commands = false, -- prevent the plugin from creating Vim commands
      ---     debug = false, -- enable debug logging for commands
      ---     go_to_source_definition = {
      ---       fallback = true, -- fall back to standard LSP definition on failure
      ---     },
      ---     server = vim.tbl_extend("force", default, servers["tsserver"] or {}),
      ---   }
      --- end,
    }

    --protocol.SymbolKind = { }
    -- require("vim.lsp.protocol").CompletionItemKind = {
    --   "󰉿", -- Text
    --   "󰆧", -- Method
    --   "󰊕", -- Function
    --   "", -- Constructor
    --   "󰜢", -- Field
    --   "󰀫", -- Variable
    --   "󰠱", -- Class
    --   "", -- Interface
    --   "", -- Module
    --   "󰜢", -- Property
    --   "󰑭", -- Unit
    --   "󰎠", -- Value
    --   "", -- Enum
    --   "󰌋", -- Keyword
    --   "", -- Snippet
    --   "", -- Color
    --   "", -- File
    --   "󰈇", -- Reference
    --   "", -- Folder
    --   "", -- EnumMember
    --   "󰏿", -- Constant
    --   "󰙅", -- Struct
    --   "", -- Event
    --   "󰆕", -- Operator
    --   "", -- TypeParameter
    -- }
  end,
}
return spec
