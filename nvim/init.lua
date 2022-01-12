
local first_run = require('plugins')

if first_run then
  vim.cmd([[
    augroup packer_first_run
      autocmd!
      autocmd User PackerComplete quitall
    augroup end
  ]])

  return
end

require('options')
require('mappings')

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end

  " disable syntax highlighting in big files
  function DisableSyntaxTreesitter()
      echo("Big file, disabling syntax, treesitter and folding")
      if exists(':TSBufDisable')
          exec 'TSBufDisable autotag'
          exec 'TSBufDisable highlight'
          " etc...
      endif

      set foldmethod=manual
      syntax clear
      syntax off
      filetype off
      set noundofile
      set noswapfile
      set noloadplugins
  endfunction

  augroup BigFileDisable
      autocmd!
      autocmd BufReadPost * if getfsize(expand("%")) > 5 * 1024 * 1024 | exec DisableSyntaxTreesitter() | endif
  augroup END
]])

