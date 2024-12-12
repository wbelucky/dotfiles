local cmp_nvim_lsp = require "cmp_nvim_lsp"

local lsp_base = {}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
lsp_base.on_attach = function(_, bufnr)
  --Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local nmappings = {
    ["gD"] = "<Cmd>lua vim.lsp.buf.declaration()<CR>",
    ["gd"] = "<Cmd>lua vim.lsp.buf.definition()<CR>",
    ["gi"] = "<Cmd>lua vim.lsp.buf.implementation()<CR>",
    ["<C-k>"] = "<Cmd>lua vim.lsp.buf.signature_help()<CR>",
    ["gh"] = "<Cmd>lua vim.lsp.buf.hover()<CR>",
    ["gr"] = "<Cmd>lua vim.lsp.buf.references()<CR>",
    ["<F2>"] = "<Cmd>lua vim.lsp.buf.rename()<CR>",
    ["<leader>n"] = "<Cmd>lua vim.lsp.buf.rename()<CR>",
    ["<leader>a"] = "<Cmd>lua vim.lsp.buf.code_action()<CR>",
    ["<leader>f"] = function()
      vim.lsp.buf.format {
        bufnr = bufnr,
        async = true,
      }
    end, -- '<Cmd>lua vim.lsp.buf.format { async = true }<CR>',
  }
  for k, v in pairs(nmappings) do
    vim.keymap.set("n", k, v, { noremap = true, silent = true, buffer = bufnr })
  end
  -- buf_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
end

-- Set up completion using nvim_cmp with LSP source
lsp_base.capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

local augroup_format = vim.api.nvim_create_augroup("FormatOnSave", { clear = true })
lsp_base.enable_format_on_save = function(_, bufnr)
  -- if client.server_capabilities.documentFormattingProvider then
  vim.api.nvim_clear_autocmds { group = augroup_format, buffer = bufnr }
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup_format,
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format {
        bufnr = bufnr,
      }
    end,
  })

  vim.api.nvim_create_user_command("DisableLspFormatting", function()
    vim.api.nvim_clear_autocmds { group = augroup_format, buffer = 0 }
  end, { nargs = 0 })
end

return lsp_base
