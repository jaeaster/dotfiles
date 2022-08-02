-- Map leader to space
vim.g.mapleader = ' '

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Auto compile when there are changes in plugins.lua
local packGrp = augroup('Source, PackerInstall, PackerCompile', { clear = true })
autocmd('BufWritePost', {
  pattern = 'plugins.lua',
  command = 'luafile ~/.config/nvim/lua/plugins/plugins.lua',
  group = packGrp,
})

autocmd('BufWritePost', {
  pattern = 'plugins.lua',
  command = 'PackerInstall',
  group = packGrp,
})

autocmd('BufWritePost', {
  pattern = 'plugins.lua',
  command = 'PackerCompile',
  group = packGrp,
})

-- Install plugins
require 'plugins.plugins'
require 'plugins.mason'

-- Setup Lua language server using submodule
require 'lsp'

-- Config
require 'config'
