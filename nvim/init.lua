
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
]])

