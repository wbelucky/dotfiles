---@type LazySpec
local spec = {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local branch_section = {
      {
        "branch",
      },
    }

    local fname_section = {
      {
        "filename",
        -- relative path
        path = 1,
        symbols = {
          modified = "",
          readonly = "󰷭",
          unnamed = "󰡯",
          newfile = "",
        },
        color = require("lualine.themes.auto").normal.b,
        separator = { right = "" },
      },
    }

    local diagnostic_section = {
      {
        "diagnostics",
        sources = { "nvim_workspace_diagnostic" },
        -- sections = { "error", "warn", "info", "hint" },
        -- diagnostics_color = {
        --   -- Same values as the general color option can be used here.
        --   error = "DiagnosticError", -- Changes diagnostics' error color.
        --   warn = "DiagnosticWarn", -- Changes diagnostics' warn color.
        --   info = "DiagnosticInfo", -- Changes diagnostics' info color.
        --   hint = "DiagnosticHint", -- Changes diagnostics' hint color.
        -- },
        -- symbols = { error = "E", warn = "W", info = "I", hint = "H" },
        -- colored = true, -- Displays diagnostics status in color if set to true.
        -- update_in_insert = false, -- Update diagnostics in insert mode.
        -- always_visible = false,
      },
    }

    require("lualine").setup {
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = false,
      },
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(str)
              return str:sub(1, 1)
            end,
          },
        },
        lualine_b = fname_section,
        lualine_c = diagnostic_section,
        lualine_x = branch_section,
        lualine_y = { "filetype" },
        lualine_z = { "progress" },
        -- lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = fname_section,
        lualine_c = {},
        lualine_x = branch_section,
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = {},
    }
  end,
}

return spec
