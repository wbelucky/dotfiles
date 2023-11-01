vim.cmd "autocmd!"

vim.g.mapleader = " "

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- Don't redraw while executing macros (good performance config)
vim.opt.lazyredraw = true
vim.opt.termguicolors = true

vim.opt.shell = "fish"

-- editor view
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false --no wrap lines
vim.opt.cursorline = true
-- 行頭にいるとき以外常にカーソルを水平中央に表示
vim.opt.scrolloff = 999
vim.opt.sidescrolloff = 999

-- file
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.autoread = true -- autoread if the file edited out of the vim.
vim.opt.hidden = true -- can open another file if the buffer is not saved

-- space by tab
vim.opt.tabstop = 2
vim.opt.expandtab = true --insert [softtabstop] spaces by tab key
vim.opt.softtabstop = -1 -- spaces to insert or delete by tab or delete, -1 means same with tabstop

-- replace special charactor
vim.opt.list = true
vim.opt.listchars = {
  tab = "»-",
  trail = "-",
  extends = "»",
  precedes = "«",
  nbsp = "%",
}

-- indent

vim.opt.smarttab = true --insert indent with tab key at the begining of line
vim.opt.shiftwidth = 0 --自動インデントでずれる値 0 means same as tabstop
vim.opt.autoindent = true --indent following previous line

-- search
vim.opt.ignorecase = true --大文字や小文字の区別なく検索
vim.opt.smartcase = true --大文字が含まれていた場合は区別する
vim.opt.hlsearch = true --add highlight to search result
vim.opt.incsearch = true --search string before confirm
vim.opt.inccommand = "split"

-- status and command line
vim.opt.laststatus = 2 -- print some status
-- vim.opt.cmdheight = 1
vim.opt.wildmenu = true --print candidates of :command line
vim.opt.infercase = true --補完時に大文字小文字を区別しない

-- clipboards
vim.opt.clipboard = "unnamedplus"
-- Suppress appending <PasteStart> and <PasteEnd> when pasting
-- TODO: set t_BE=

-- TODO: set nosc noru nosm

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste",
})

-- https://github.com/neovim/neovim/wiki/FAQ#how-to-use-the-windows-clipboard-from-wsl
if vim.fn.has [[wsl]] == 1 then
  vim.g.netrw_browsex_viewer = "cmd.exe /C start"
  vim.g.clipboard = {
    name = "win32yank",
    copy = {
      ["+"] = "win32yank.exe -i --crlf",
      ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
      ["+"] = "win32yank.exe -o --lf",
      ["*"] = "win32yank.exe -o --lf",
    },
    cache_enabled = 1,
  }
end

vim.cmd [[au BufNewFile,BufRead *.pyflyby setl filetype=python]]

-- vim.opt.spell = true
-- vim.opt.spelllang = { "en", "cjk" }

-- filetypes
-- TODO: au BufNewFile,BufRead *.fish setl filetype=fish
-- TODO: au BufNewFile,BufRead *.tsx setl filetype=typescriptreact
-- TODO: au BufNewFile,BufRead *.md setl filetype=markdown
-- TODO: au BufNewFile,BufRead *.mdx setl filetype=markdown

-- TODO: runtime ./maps.vim
-- TODO: runtime ./plug.vim
