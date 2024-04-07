---@type LazySpec
local spec = {
  "wbelucky/md-link-title.vim",
  lazy = false,
  dev = true,
  ft = "markdown",
  init = function(spec)
    if spec.dev then
      vim.g["denops#debug"] = 1
    end

    -- vim.cmd [[command! -nargs=0 -range Link <line1>,<line2>call md_link_title#replace()]]
    vim.api.nvim_create_user_command("Link", [[<line1>,<line2>MdLinkTitle]], { nargs = 0, range = true })

    local augroup = vim.api.nvim_create_augroup("MdLinkTitle", { clear = true })

    vim.api.nvim_create_autocmd("InsertLeave", {
      group = augroup,
      pattern = "*.md",
      callback = function()
        local firstline = vim.fn.line "'["
        local lastline = vim.fn.line "']"
        vim.fn["denops#notify"]("md-link-title", "replace", { firstline, lastline })
      end,
    })

    vim.api.nvim_create_user_command("MdLinkTitleDisableAutoModify", function()
      vim.api.nvim_clear_autocmds { group = augroup }
    end, { nargs = 0 })
  end,
  dependencies = { "vim-denops/denops.vim" },
}

return spec
