-------------------- PLUGINS -------------------------------

local fn = vim.fn
local packer_install_dir = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

local first_run = false
if fn.glob(packer_install_dir) == "" then
  vim.api.nvim_echo({ { "Installing packer.nvim", "Type" } }, true, {})
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', packer_install_dir})
  first_run = true
end

vim.cmd("packadd packer.nvim")

function get_setup(name)
  return string.format('require("setup/%s")', name)
end


require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use { 'dracula/vim' }
  use { 'kyazdani42/nvim-web-devicons' }
  use { 'norcalli/nvim-colorizer.lua' }
  use { 'nvim-lua/popup.nvim' }
  use { 'ntpeters/vim-better-whitespace' }
  use { 'luukvbaal/stabilize.nvim' }
  use { 'onsails/lspkind-nvim' }
  use {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig'
  }
  use { 'nvim-treesitter/nvim-treesitter' }
  use { 'nvim-treesitter/playground' }
  use { 'nvim-treesitter/nvim-treesitter-textobjects' }
  use { 'RRethy/nvim-treesitter-textsubjects' }
  use { 'jose-elias-alvarez/null-ls.nvim' }
  use { 'hiphish/jinja.vim' }

  use { 'L3MON4D3/LuaSnip', config = get_setup("luasnip") }
  use { 'hrsh7th/nvim-cmp' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/cmp-cmdline' }
  use { 'hrsh7th/cmp-path' }
  use { 'saadparwaiz1/cmp_luasnip' }
  use { 'windwp/nvim-ts-autotag' }
  use { 'tpope/vim-commentary' }
  use { 'JoosepAlviste/nvim-ts-context-commentstring' }
  use { 'mg979/vim-visual-multi' }

  use { 'nvim-lua/plenary.nvim' }
  use { 'nvim-telescope/telescope.nvim',
    run='git submodule update --init --recursive',
    requires = {
      { 'nvim-telescope/telescope-live-grep-args.nvim' }
    }
  }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run='make' }
  use { 'folke/trouble.nvim' }

  use { 'tpope/vim-fugitive' }
  use { 'samoshkin/vim-mergetool' }
  use { 'lewis6991/gitsigns.nvim' }

  use { 'kyazdani42/nvim-tree.lua' }
  use {
    'folke/zen-mode.nvim',
    config = function()
      require("zen-mode").setup({
        window = {
          width = 200,
        },
      })
    end
  }

  use { 'aidos/vim-simpledb' }

  use({
    'github/copilot.vim',
  })

  if first_run then
    require('packer').sync()
  end
end)

return first_run
