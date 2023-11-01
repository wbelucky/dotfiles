--@type LazySpec
local spec = {
  "nvim-treesitter/nvim-treesitter",
  event = "VeryLazy",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup {
      highlight = {
        enable = true,
        disable = {},
      },
      indent = {
        enable = true,
        disable = { "dart" },
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn", -- set to `false` to disable one of the mappings
          node_incremental = "af",
          scope_incremental = "as",
          node_decremental = "if",
        },
      },
      ensure_installed = {
        "cpp",
        "markdown",
        "markdown_inline",
        "go",
        "python",
        "tsx",
        "toml",
        "fish",
        "json",
        "yaml",
        "css",
        "html",
        "lua",
        "vim",
        "dart",
        "hcl",
      },
      autotag = {
        enable = true,
      },
    }

    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
  end,
}

return spec
