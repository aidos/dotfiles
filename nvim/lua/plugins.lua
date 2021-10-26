-------------------- PLUGINS -------------------------------

local fn = vim.fn
local packer_install_dir = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.glob(packer_install_dir) == "" then
  vim.api.nvim_echo({ { "Installing packer.nvim", "Type" } }, true, {})
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', packer_install_dir})
  --vim.api.nvim_command 'packadd packer.nvim'
end

vim.cmd("packadd packer.nvim")

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use { 'dracula/vim' }
  use { 'kyazdani42/nvim-web-devicons' }
  use { 'norcalli/nvim-colorizer.lua' }
  use { 'nvim-lua/popup.nvim' }
  use { 'ntpeters/vim-better-whitespace' }
  use { 'p00f/nvim-ts-rainbow' }
  use { 'luukvbaal/stabilize.nvim' }
  use { 'onsails/lspkind-nvim' }

  use { 'neovim/nvim-lspconfig' }
  use { 'williamboman/nvim-lsp-installer' }
  use { 'nvim-treesitter/nvim-treesitter' }
  use { 'nvim-treesitter/playground' }
  use { 'nvim-treesitter/nvim-treesitter-textobjects' }
  use { 'RRethy/nvim-treesitter-textsubjects' }

  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/nvim-cmp' }
  use { 'windwp/nvim-autopairs' }
  use { 'windwp/nvim-ts-autotag' }
  use { 'tpope/vim-commentary' }
  use { 'JoosepAlviste/nvim-ts-context-commentstring' }
  use { 'mg979/vim-visual-multi' }

  use { 'nvim-lua/plenary.nvim' }
  use { 'nvim-telescope/telescope.nvim', run='git submodule update --init --recursive' }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run='make' }
  use { 'folke/trouble.nvim' }
  --use { 'onsails/diaglist.nvim' }

  use { 'tpope/vim-fugitive' }
  use { 'pwntester/octo.nvim' }

  use { 'kyazdani42/nvim-tree.lua' }

  use { 'aidos/vim-simpledb' }

  if packer_bootstrap then
    require('packer').sync()
  end
end)

