-- Autoinstall Packer if not installed
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local fn = vim.fn

local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP =
    fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

-- Auto compile when there are changes in plugins.lua
local packGrp = augroup('Source, PackerInstall, PackerCompile', { clear = true })

autocmd('BufWritePost', {
  pattern = 'plugins.lua',
  command = 'source <afile> | PackerInstall',
  group = packGrp,
})

autocmd('BufWritePost', {
  pattern = 'plugins.lua',
  command = 'PackerCompile',
  group = packGrp,
})

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end
-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' }
    end,
  },
}

return packer.startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/popup.nvim' -- An implementation of the Popup API from vim in Neovim

  local config = function(name)
    return string.format("require('plugins.%s')", name)
  end

  local use_with_config = function(path, name)
    use { path, config = config(name) }
  end

  -- use_with_config('github/copilot.vim', 'copilot')

  -- Colorschemes
  use { 'catppuccin/nvim', as = 'catppuccin' }
  use 'folke/tokyonight.nvim'

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = config 'treesitter',
  }

  -- Fuzzy Finder
  use_with_config('nvim-telescope/telescope.nvim', 'telescope')

  -- LSP
  use {
    'williamboman/mason.nvim', -- Install language servers / linters / formatters / etc.
    'williamboman/mason-lspconfig.nvim', -- Autoinstall above ^^
    'neovim/nvim-lspconfig', -- makes lsp configuration easier
  }

  use 'simrat39/rust-tools.nvim' -- Enables more tools of rust-analyzer, like inlay hints
  use 'folke/lua-dev.nvim' -- better sumneko_lua settings

  -- use { 'mfussenegger/nvim-jdtls' } -- Java LSP
  --
  use 'b0o/schemastore.nvim' -- simple access to json-language-server schemae
  use_with_config('RRethy/vim-illuminate', 'illuminate') -- highlights and allows moving between variable references

  -- Diagnostics
  use_with_config('glepnir/lspsaga.nvim', 'lspsaga') -- LSP hover docs
  use { -- Better LSP diagnostic lines
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    config = function()
      -- require('lsp_lines').setup()
    end,
  }

  -- Formatting and Linters
  use 'jose-elias-alvarez/null-ls.nvim'

  -- Snippet engine and snippets
  use {
    'L3MON4D3/LuaSnip',
    'rafamadriz/friendly-snippets',
  }

  -- Completion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lua',
      'onsails/lspkind-nvim', -- icons in completion menu
    },
    config = config 'cmp',
  }

  -- Status bar
  use_with_config('nvim-lualine/lualine.nvim', 'lualine')
  use 'kyazdani42/nvim-web-devicons' -- icons

  -- File explorer
  use_with_config('kyazdani42/nvim-tree.lua', 'nvim-tree')

  -- Basic editor functionality
  use 'tpope/vim-fugitive' -- Fugitive for Git
  use_with_config('numToStr/Comment.nvim', 'comment') -- Toggle comments
  use_with_config('windwp/nvim-autopairs', 'autopairs')
  use {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup {}
    end,
  }

  -- Helm charts
  use 'towolf/vim-helm'

  -- Misc
  use 'nvim-lua/plenary.nvim'

  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
