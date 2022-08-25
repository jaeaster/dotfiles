local autocmd = vim.api.nvim_create_autocmd
local cmd = vim.cmd
local indent = 4

local options = {
  expandtab = true,
  shiftwidth = indent,
  autoindent = true,
  smartindent = true,
  tabstop = indent,
  softtabstop = indent,
  hidden = true,
  ignorecase = true,
  scrolloff = 8,
  shiftround = true,
  smartcase = true,
  splitbelow = true,
  splitright = true,
  wildmode = { list = 'longest' },
  number = true,
  relativenumber = true,
  clipboard = 'unnamedplus',
  backspace = { 'indent', 'eol', 'start' },
  showmatch = true,
  incsearch = true,
  showcmd = true,
  title = true,
  -- formatoptions:remove 'tc',
  wrap = false,
  cursorline = true,

  numberwidth = 4,
  undofile = true,
  showmode = false, -- we don't need to see things like -- INSERT -- anymore
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- Delay for illuminate plugin
vim.g.Illuminate_delay = 300

-- Language specific tab settings
autocmd('Filetype', {
  pattern = {
    'lua',
    'ruby',
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'json',
  },
  command = 'setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2',
})

-- Highlight on yank
local yankGrp = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  command = 'silent! lua vim.highlight.on_yank()',
  group = yankGrp,
})

-- Highlight Git Merge Conflicts
cmd [[match ErrorMsg "^\(<\|=\|>\)\{7\}\([^=].\+\)\?$"]]
