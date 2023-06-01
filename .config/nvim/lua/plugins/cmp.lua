local M = {
  "hrsh7th/nvim-cmp",
  module = { "cmp" },
  requires = {
    { "hrsh7th/cmp-nvim-lsp", event = { "InsertEnter" } },
    { "hrsh7th/cmp-buffer",   event = { "InsertEnter" } },
    { "hrsh7th/cmp-emoji",    event = { "InsertEnter" } },
    { "hrsh7th/cmp-path",     event = { "InsertEnter" } },
    { "hrsh7th/cmp-vsnip",    event = { "InsertEnter" } },
    { "hrsh7th/cmp-cmdline",  event = { "CmdlineEnter" } },
    { "hrsh7th/vim-vsnip",    event = { "InsertEnter" } },
  },
}

M.config = function()
  local cmp = require "cmp"
  if cmp == nil then
    return
  end

  vim.g.vsnip_snippet_dir = vim.env.VSNIP_DIR

  local lspkind = require "lspkind"
  cmp.setup {
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    mapping = cmp.mapping.preset.insert {
      ["<C-u>"] = cmp.mapping.scroll_docs(-4),
      ["<C-d>"] = cmp.mapping.scroll_docs(4),
      ["<C-j>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
    },
    sources = cmp.config.sources({
      {
        name = "vsnip",
      },
      {
        name = "nvim_lsp",
        keyword_length = 3,
      }, -- { name = 'cmp_tabnine' },
      {
        name = "path",
      },
      {
        name = "emoji",
      },
    }, {
      {
        name = "buffer",
      },
    }),
    formatting = {
      format = lspkind.cmp_format { with_text = false, maxwidth = 50 },
    },
  }

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      {
        name = "cmdline",
        option = {
          ignore_cmds = { "Man", "!", "'<,'>!" },
        },
        keyword_length = 4,
      },
    }),
  })

  vim.cmd [[
    set completeopt=menuone,noinsert,noselect
    highlight! default link CmpItemKind CmpItemMenuDefault
  ]]
end

return M
