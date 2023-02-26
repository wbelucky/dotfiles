local util = require('lspconfig.util')
local base = require('wbelucky.lsp_base')

local lsp_servers = {
  pyright = {
    filetypes = { "python" }
  },
  flow = {
    filetypes = { "javascript", "javascriptreact", "javascript.jsx" },
  },
  lua_ls = {

    on_attach = function(client, bufnr)
      base.on_attach(client, bufnr)
      base.enable_format_on_save(client, bufnr)
    end,
    settings = {
      Lua = {
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { 'vim' },
        },

        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false
        },
      },
    },
  },
  gopls = {
    cmd = { "gopls", "serve" },
    filetypes = { "go", "gomod" },
    root_dir = util.root_pattern("go.work", "go.mod", ".git"),
    settings = {
      gopls = {
        analyses = {
          unusedparamas = true,
        },
        staticcheck = true,
      }
    }
  },
  yamlls = {

    -- https://www.reddit.com/r/neovim/comments/pta1ka/unable_to_configure_yamllanguageserver/
    settings = {
      yaml = {
        schemaStore = {
          url = "https://www.schemastore.org/api/json/catalog.json",
          enable = true,
        },
        hover = true,
        completion = true,
        validate = true,
        format = {
          enable = true
        }
      }
    }
  },
  jsonls = {
    -- https://github.com/b0o/schemastore.nvim
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
        validate = { enable = true },
      }
    }
  },
  vimls = {},
  clangd = {},
}

return lsp_servers