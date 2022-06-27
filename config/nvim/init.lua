-- Map leader to space
vim.g.mapleader = ' '

local fn = vim.fn
local execute = vim.api.nvim_command
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Sensible defaults
require('settings')

-- Auto install VimPlug if not exists
local install_path = fn.stdpath('data') .. '/site/autoload/plug.vim'
local install_cmd = '!curl -fLo ' .. install_path .. ' --create-dirs ' ..
    'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
if fn.empty(fn.glob(install_path)) > 0 then
  execute(install_cmd)
  execute(':PlugInstall')
end

-- Auto compile when there are changes in plugins.lua
local plugGrp = augroup("Source and PlugInstall", { clear = true })
autocmd("BufWritePost", {
  pattern = 'plugins.lua',
  command = 'luafile ~/.config/nvim/lua/plugins.lua',
  group = plugGrp,
})

autocmd("BufWritePost", {
  pattern = 'plugins.lua',
  command = 'PlugInstall',
  group = plugGrp,
})

-- Install plugins
require('plugins')

-- Key mappings
require('keymappings')

-- Setup Lua language server using submodule
require('lsp_lua')

-- Config
require('config')
