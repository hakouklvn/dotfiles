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
end)
