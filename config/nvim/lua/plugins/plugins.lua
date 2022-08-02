-- Autoinstall Packer if not installed
local fn = vim.fn
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap =
    fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  local config = function(name)
    return string.format("require('plugins.%s')", name)
  end

  local use_with_config = function(path, name)
    use { path, config = config(name) }
  end

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

  -- Completion
  use {
    'hrsh7th/nvim-cmp', -- completion
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
    },
    config = config 'cmp',
  }

  -- Status bar
  use_with_config('nvim-lualine/lualine.nvim', 'lualine')
  use 'kyazdani42/nvim-web-devicons' -- icons

  -- Basic editor functionality
  use 'tpope/vim-fugitive' -- Fugitive for Git
  use 'tpope/vim-commentary' -- Toggle comments
  use 'Raimondi/delimitMate' -- automatic closing of quotes, parenthesis, brackets, etc.

  -- Misc
  use 'nvim-lua/plenary.nvim'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
