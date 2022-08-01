local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- Color scheme
Plug('catppuccin/nvim', { as = 'catppuccin' })

-- Fuzzy finder
Plug 'nvim-lua/plenary.nvim'
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
Plug 'nvim-telescope/telescope.nvim'

-- LSP
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'

-- Completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

-- Formatting
Plug 'jose-elias-alvarez/null-ls.nvim'

-- Enables more tools of rust-analyzer, like inlay hints
Plug 'simrat39/rust-tools.nvim'

-- LSP hover docs
Plug 'glepnir/lspsaga.nvim'
-- Better LSP diagnostic lines
Plug 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'

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

-- automatic closing of quotes, parenthesis, brackets, etc.
Plug 'Raimondi/delimitMate'
vim.call('plug#end')

require('plugins.telescope')
require('plugins.cmp')
-- require('plugins.lsp_lines')
require('plugins.lspsaga')
require('plugins.mason')
require('plugins.lualine')
