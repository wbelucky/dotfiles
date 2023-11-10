---@type LazySpec
local spec = {
  "wbelucky/md-link-title.vim",
  dev = true,
  ft = "markdown",
  init = function()
    -- command! -nargs=0 -range MdLinkTitle <line1>,<line2>call md_link_title#replace()
    vim.cmd [[command! -nargs=0 -range Link <line1>,<line2>call md_link_title#replace()]]
  end,
  dependencies = { "vim-denops/denops.vim" },
}

return spec
