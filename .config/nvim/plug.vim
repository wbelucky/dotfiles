
call plug#begin(stdpath('data') . '/plugged')

if has('nvim')
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
endif

call plug#end()
