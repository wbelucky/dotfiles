local lsp_servers = {
  pyright = {
    filetypes = { "python", ".pyflyby" },
    -- https://www.reddit.com/r/neovim/comments/wls43h/pyright_lsp_configuration_for_python_poetry/
    before_init = function(_, config)
      local Path = require "plenary.path"
      local venv = Path:new((config.root_dir:gsub("/", Path.path.sep)), ".venv")
      if venv:joinpath("bin"):is_dir() then
        config.settings.python.pythonPath = tostring(venv:joinpath("bin", "python"))
      else
        config.settings.python.pythonPath = tostring(venv:joinpath("Scripts", "python.exe"))
      end
    end,
    -- on_new_config = function(config, root_dir)
    --   local env = vim.trim(vim.fn.system('cd "' .. root_dir .. '"; poetry env info -p 2>/dev/null'))
    --   if string.len(env) > 0 then
    --     config.settings.python.pythonPath = env .. "/bin/python"
    --   end
    -- end,
  },
  lua_ls = {
    -- on_attach = function(client, bufnr)
    --   local base = require "wbelucky.lsp_base"
    --   base.on_attach(client, bufnr)
    --   base.enable_format_on_save(client, bufnr)
    -- end,
    settings = {
      Lua = {
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim" },
        },

        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
      },
    },
  },
  gopls = {
    cmd = { "gopls", "serve" },
    filetypes = { "go", "gomod" },
    root_dir = require("lspconfig.util").root_pattern("go.work", "go.mod", ".git"),
    settings = {
      gopls = {
        analyses = {
          unusedparamas = true,
        },
        staticcheck = true,
      },
    },
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
          enable = true,
        },
      },
    },
  },
  jsonls = {
    -- https://github.com/b0o/schemastore.nvim
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  },
  vimls = {},
  clangd = {},
  denols = {
    root_dir = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc"),
  },
  tsserver = {
    root_dir = require("lspconfig.util").root_pattern "package.json",
  },
  terraformls = {
    -- disable terraform-vars because of https://github.com/neovim/neovim/issues/23184
    -- https://www.reddit.com/r/neovim/comments/125gctj/e5248_invalid_character_in_group_name_with/
    filetypes = { "terraform" },
  },
  tflint = {},
  kotlin_language_server = {
    settings = { kotlin = { compiler = { jvm = { target = "17" } } } },
  },
}

return lsp_servers
