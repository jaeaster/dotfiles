-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Configure lazy.nvim
require('lazy').setup {
  spec = {
    -- Colorschemes
    { 'catppuccin/nvim',      name = 'catppuccin' },
    { 'folke/tokyonight.nvim' },

    -- Core plugins for IDE features
    {
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      config = function()
        require 'plugins.treesitter'
      end,
    },
    {
      'nvim-telescope/telescope.nvim',
      branch = '0.1.x',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      },
      config = function()
        require 'plugins.telescope'
      end,
    },

    -- LSP Support
    {
      'williamboman/mason.nvim',
      config = function()
        require('mason').setup {
          ui = {
            icons = {
              server_installed = '✓',
              server_pending = '➜',
              server_uninstalled = '✗',
            },
          },
        }
      end,
    },
    { 'williamboman/mason-lspconfig.nvim', dependencies = { 'williamboman/mason.nvim' } },
    {
      'nvimtools/none-ls.nvim',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
        require 'lsp.null-ls'
      end,
    },
    { 'b0o/schemastore.nvim' },
    { 'mrcjkb/rustaceanvim', version = '^8', lazy = false },
    {
      'nvimdev/lspsaga.nvim',
      config = function()
        require 'plugins.lspsaga'
      end,
      dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons',
      },
    },

    -- Completion
    {
      'hrsh7th/nvim-cmp',
      dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lua',
        'onsails/lspkind.nvim',
        -- Snippets
        {
          'L3MON4D3/LuaSnip',
          version = 'v2.*',
          build = 'make install_jsregexp',
          dependencies = {
            'rafamadriz/friendly-snippets',
          },
          config = function()
            require('luasnip').setup {
              history = true,
              delete_check_events = 'TextChanged',
            }
            require('luasnip.loaders.from_vscode').lazy_load()
          end,
        },
      },
      config = function()
        require 'plugins.cmp'
      end,
    },

    -- File explorer and UI
    {
      'nvim-tree/nvim-tree.lua',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = function()
        require 'plugins.nvim-tree'
      end,
    },
    {
      'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = function()
        require 'plugins.lualine'
      end,
    },

    -- Git
    { 'tpope/vim-fugitive' },
    {
      'lewis6991/gitsigns.nvim',
      config = true,
    },

    -- Editor enhancements
    {
      'numToStr/Comment.nvim',
      config = function()
        require 'plugins.comment'
      end,
    },
    {
      'windwp/nvim-autopairs',
      config = function()
        require 'plugins.autopairs'
      end,
    },
    {
      'windwp/nvim-ts-autotag',
      config = true,
    },
    {
      'RRethy/vim-illuminate',
      config = function()
        require 'plugins.illuminate'
      end,
    },

    -- Render Markdown (in-buffer, works over SSH)
    {
      'MeanderingProgrammer/render-markdown.nvim',
      dependencies = { 'nvim-treesitter/nvim-treesitter' },
      ft = { 'markdown' },
      opts = {},
    },

    -- Additional functionality
    { 'towolf/vim-helm' },
  },
  {
    checker = {
      enabled = true,
      notify = false,
    },
    change_detection = {
      notify = false,
    },
  },
}
