vim.cmd('filetype plugin indent on')
vim.cmd('syntax on')
vim.cmd('filetype plugin on')
vim.cmd('set background=dark')

-- vim.cmd('autocmd BufWritePost * FormatWrite')
vim.g.doom_one_terminal_colors = true

vim.g.completopt    		= "menu, menuone, noselect, noinsert"
vim.o.shortmess    			= vim.o.shortmess .. 'c'
vim.o.hidden    			  = true
vim.o.whichwrap    			= 'b,s,<,>,[,],h,l'
vim.o.pumheight    			= 10
vim.o.fileencoding  		= 'utf-8'
vim.o.cmdheight    			= 1
vim.o.splitbelow			  = true
vim.o.splitright    		= true
vim.opt.termguicolors		= true
vim.o.conceallevel 			= 0
vim.o.showtabline   		= 2
vim.o.showmode    			= false
vim.o.backup    			  = false
vim.o.writebackup    		= false
vim.o.updatetime    		= 300
vim.o.timeoutlen			  = 500
vim.o.clipboard    			= "unnamedplus"
vim.o.hlsearch    			= true
vim.o.ignorecase    		= true
vim.o.scrolloff    			= 1
vim.o.sidescrolloff    	= 1
vim.o.mouse    	    		= "a"
vim.wo.wrap    		    	= false
vim.wo.number    			  = true
vim.o.cursorline    		= true
vim.wo.signcolumn 			= "yes"
vim.o.tabstop    			  = 2
vim.bo.tabstop    			= 2
vim.o.softtabstop    		= 2
vim.o.shiftwidth    		= 2
vim.bo.shiftwidth   		= 2
vim.o.autoindent			  = true
vim.bo.autoindent    		= true
vim.o.expandtab    			= true
vim.bo.expandtab    		= true

