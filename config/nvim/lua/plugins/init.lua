-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
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
    {
      'williamboman/mason-lspconfig.nvim',
      config = function()
        require('mason-lspconfig').setup {
          automatic_installation = true,
        }
      end,
      dependencies = { 'williamboman/mason.nvim' },
    },
    {
      'neovim/nvim-lspconfig',
      dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'folke/neodev.nvim', -- Replaces lua-dev.nvim
      },
    },
    {
      'nvimtools/none-ls.nvim',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
        require 'lsp.null-ls'
      end,
    },
    { 'simrat39/rust-tools.nvim' },
    { 'b0o/schemastore.nvim' },
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

    -- Additional functionality
    { 'towolf/vim-helm' },

    -- AI
    {
      'zbirenbaum/copilot.lua',
      cmd = 'Copilot',
      event = 'InsertEnter',
      config = function()
        require('copilot').setup {}
      end,
    },

    {
      'CopilotC-Nvim/CopilotChat.nvim',
      branch = 'canary',
      dependencies = {
        { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
        { 'nvim-lua/plenary.nvim' },  -- for curl, log wrapper
      },
      build = 'make tiktoken',        -- Only on MacOS or Linux
      opts = {
        debug = true,                 -- Enable debugging
        -- See Configuration section for rest
      },
      -- See Commands section for default commands if you want to lazy load on them
    },

    {
      'yetone/avante.nvim',
      event = 'VeryLazy',
      lazy = false,
      version = false, -- set this if you want to always pull the latest change
      opts = {
        provider = 'copilot',
        -- auto_suggestions_provider = 'copilot',
        copilot = {
          model = 'claude-3.5-sonnet',
          -- model = 'o1-preview',
          max_tokens = 4096,
        },
      },
      -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
      build = 'make BUILD_FROM_SOURCE=true',
      -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
      dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'stevearc/dressing.nvim',
        'nvim-lua/plenary.nvim',
        'MunifTanjim/nui.nvim',
        --- The below dependencies are optional,
        'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
        'zbirenbaum/copilot.lua',      -- for providers='copilot'
        {
          -- support for image pasting
          'HakonHarnes/img-clip.nvim',
          event = 'VeryLazy',
          opts = {
            -- recommended settings
            default = {
              embed_image_as_base64 = false,
              prompt_for_file_name = false,
              drag_and_drop = {
                insert_mode = true,
              },
              -- required for Windows users
              use_absolute_path = true,
            },
          },
        },
        {
          -- Make sure to set this up properly if you have lazy=true
          'MeanderingProgrammer/render-markdown.nvim',
          opts = {
            file_types = { 'markdown', 'Avante' },
          },
          ft = { 'markdown', 'Avante' },
        },
      },
    },
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
