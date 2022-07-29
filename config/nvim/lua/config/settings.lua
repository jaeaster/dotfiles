local autocmd = vim.api.nvim_create_autocmd
local cmd = vim.cmd
local indent = 4

cmd 'syntax enable'
cmd 'filetype plugin indent on'

vim.opt.expandtab = true
vim.opt.shiftwidth = indent
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = indent
vim.opt.softtabstop = indent
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.scrolloff = 8
vim.opt.shiftround = true
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.wildmode = { list = 'longest' }
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = { 'unnamed', 'unnamedplus' }
vim.opt.backspace = { 'indent', 'eol', 'start' }
vim.opt.showmatch = true
vim.opt.incsearch = true
vim.opt.showcmd = true
vim.opt.title = true
vim.opt.formatoptions:remove('tc')
vim.opt.wrap = false

-- Language specific tab settings
autocmd('Filetype', {
  pattern = {
    'lua',
    'ruby',
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact'
  },
  command = 'setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2'
})

-- Highlight on yank
local yankGrp = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  command = "silent! lua vim.highlight.on_yank()",
  group = yankGrp,
})

-- Highlight Git Merge Conflicts
cmd [[match ErrorMsg "^\(<\|=\|>\)\{7\}\([^=].\+\)\?$"]]
