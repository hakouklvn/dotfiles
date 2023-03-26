return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- A better status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons',
    },
    tag = 'nightly'
  }
  use 'nvim-tree/nvim-web-devicons'

  -- Colorschemes
  use 'RRethy/nvim-base16'
  use 'kyazdani42/nvim-palenight.lua'

  use {
   'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }

  use {
    "williamboman/nvim-lsp-installer",
    "neovim/nvim-lspconfig",
  } 

  use {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',
  }

  use 'windwp/nvim-autopairs'
end)
