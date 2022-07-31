return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- A better status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- File management --
  use 'vifm/vifm.vim'
  use 'scrooloose/nerdtree'
  use 'tiagofumo/vim-nerdtree-syntax-highlight'
  use 'ryanoasis/vim-devicons'

  -- Productivity --
  use 'vimwiki/vimwiki'
  use 'jreybert/vimagit'

  -- Tim Pope Plugins --
  use 'tpope/vim-surround'

  -- Syntax Highlighting and Colors --
  use 'PotatoesMaster/i3-vim-syntax'
  use 'kovetskiy/sxhkd-vim'
  use 'vim-python/python-syntax'
  use 'ap/vim-css-color'

  -- Junegunn Choi Plugins --
  use 'junegunn/goyo.vim'
  use 'junegunn/limelight.vim'
  use 'junegunn/vim-emoji'

  -- Colorschemes
  use 'RRethy/nvim-base16'
  use 'kyazdani42/nvim-palenight.lua'

  -- Other stuff
  use 'frazrepo/vim-rainbow'
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
  use({
      'NTBBloodbath/doom-one.nvim',
      config = function()
          require('doom-one').setup({
              cursor_coloring = false,
              terminal_colors = false,
              italic_comments = false,
              enable_treesitter = true,
              transparent_background = false,
              pumblend = {
                  enable = true,
                  transparency_amount = 20,
              },
              plugins_integrations = {
                  neorg = true,
                  barbar = true,
                  bufferline = false,
                  gitgutter = false,
                  gitsigns = true,
                  telescope = false,
                  neogit = true,
                  nvim_tree = true,
                  dashboard = true,
                  startify = true,
                  whichkey = true,
                  indent_blankline = true,
                  vim_illuminate = true,
                  lspsaga = false,
              },
          })
      end,
  })
end)
