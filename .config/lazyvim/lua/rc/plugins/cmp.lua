---@type LazySpec
local spec = {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    {
      "onsails/lspkind-nvim",
      config = function()
        require("lspkind").init {
          -- enables text annotations
          --
          -- default: true
          mode = "symbol",

          -- default symbol map
          -- can be either 'default' (requires nerd-fonts font) or
          -- 'codicons' for codicon preset (requires vscode-codicons font)
          --
          -- default: 'default'
          preset = "codicons",

          -- override preset symbols
          --
          -- default: {}
          symbol_map = {
            Text = "󰉿",
            Method = "󰆧",
            Function = "󰊕",
            Constructor = "",
            Field = "󰜢",
            Variable = "󰀫",
            Class = "󰠱",
            Interface = "",
            Module = "",
            Property = "󰜢",
            Unit = "󰑭",
            Value = "󰎠",
            Enum = "",
            Keyword = "󰌋",
            Snippet = "",
            Color = "󰏘",
            File = "󰈙",
            Reference = "󰈇",
            Folder = "󰉋",
            EnumMember = "",
            Constant = "󰏿",
            Struct = "󰙅",
            Event = "",
            Operator = "󰆕",
            TypeParameter = "",
          },
        }
      end,
    },
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-emoji",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-vsnip",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/vim-vsnip",
  },
  config = function()
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
  end,
}

return spec
