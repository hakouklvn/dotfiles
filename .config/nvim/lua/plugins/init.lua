return require('packer').startup(function()
  use {'wbthomason/packer.nvim'}
  use {'joshdick/onedark.vim', config="vim.cmd('colorscheme onedark')"}
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    event = "BufWinEnter",
    config = "require('treesitter-config')"
  }
  use {'kyazdani42/nvim-web-devicons'}
  use {
    'tamton-aquib/staline.nvim',
    event = "BufRead",
    config = "require('staline-config')"
  }
  use {'glepnir/dashboard-nvim', event = "BufRead"}
  use {
    'akinsho/bufferline.nvim',
    event = "BufWinEnter",
    config = "require('bufferline-config')"
  }
  use {
    'kyazdani42/nvim-tree.lua',
    cmd = "NvimTreeToggle",
    config = "require('tree-config')"
  }
  use {
    'windwp/nvim-ts-autotag',
    event = "InsertEnter",
    after = "nvim-treesitter"
  }
  use {'p00f/nvim-ts-rainbow', after = "nvim-treesitter"}
  use {
    'windwp/nvim-autopairs',
    config = "require('autopairs-config')",
    after = "nvim-cmp"
  }
  use {
    "folke/which-key.nvim",
    event = "BufWinEnter",
    config = "require('whichkey-config')"
  }
  use {'norcalli/nvim-colorizer.lua', event = "BufRead", config = "require('colorizer-config')"}
  
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} },
    cmd = "Telescope",
    config = "require('telescope-config')"
  }
  
  use {
    'lewis6991/gitsigns.nvim',
    requires = {'nvim-lua/plenary.nvim'},
    config = function()
      require('gitsigns').setup()
    end
  }
  use {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    config = "require('indent-config')"
  }

  use {'neovim/nvim-lspconfig', config = "require('lsp')"}
  use {'hrsh7th/cmp-nvim-lsp'}
  use {'hrsh7th/cmp-buffer'}
  use {'hrsh7th/cmp-path'}
  use {'hrsh7th/cmp-cmdline'}
  use {'hrsh7th/nvim-cmp'}
  use {'mattn/emmet-vim'}
  use {'hrsh7th/cmp-vsnip'}
  use {'hrsh7th/vim-vsnip'}
  use {'onsails/lspkind-nvim'}
  use {"jose-elias-alvarez/null-ls.nvim", config = "require('null-ls-config')"}
  use {'williamboman/nvim-lsp-installer'}
  use {"terrortylor/nvim-comment", config = "require('comment-config')"}
  use {"akinsho/toggleterm.nvim", config = "require('toggle-term-config')"}

end)
