local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- Color scheme
Plug 'joshdick/onedark.vim'

-- Fuzzy finder
Plug 'nvim-lua/plenary.nvim'
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
Plug 'nvim-telescope/telescope.nvim'

-- LSP and completion
Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

-- LSP hover docs
Plug 'glepnir/lspsaga.nvim'

-- Snippet engine
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

-- neovim lua highlighting?
Plug 'euclidianAce/BetterLua.vim'

-- Fugitive for Git
Plug 'tpope/vim-fugitive'
-- Toggle comments
Plug 'tpope/vim-commentary'

-- Status bar
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

-- Plug 'kristijanhusak/defx-git'
-- Plug 'kristijanhusak/defx-icons'
-- Plug('Shougo/defx.nvim', { ['do'] = ':UpdateRemotePlugins' })

vim.call('plug#end')
