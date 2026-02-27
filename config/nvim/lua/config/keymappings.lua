local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

-- Remap space as leader key
keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Better window navigation
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

-- Toggle File explorer
keymap('n', '<leader>e', ':lua require("nvim-tree.api").tree.toggle()<CR>', opts)

-- Create Splits
keymap('n', '<leader>v', ':vsp<CR>', opts)
keymap('n', '<leader>s', ':sp<CR>', opts)

-- Resize with arrows
keymap('n', '<C-Up>', ':resize -2<CR>', opts)
keymap('n', '<C-Down>', ':resize +2<CR>', opts)
keymap('n', '<C-Left>', ':vertical resize -2<CR>', opts)
keymap('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- Navigate buffers
keymap('n', '<S-l>', ':bnext<CR>', opts)
keymap('n', '<S-h>', ':bprevious<CR>', opts)

-- Telescope fuzzy finder
local builtin = require 'telescope.builtin'
keymap('n', '<leader>f', builtin.find_files, { desc = 'Telescope find files' })
keymap('n', '<leader>g', builtin.live_grep, { desc = 'Telescope live grep' })
keymap('n', '<leader>b', builtin.buffers, { desc = 'Telescope buffers' })
keymap('n', '<leader>h', builtin.help_tags, { desc = 'Telescope help tags' })

-- LSP
keymap('n', 'gD', vim.lsp.buf.declaration, opts)
keymap('n', 'gd', vim.lsp.buf.definition, opts)
keymap('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)
keymap('n', 'gi', vim.lsp.buf.implementation, opts)
keymap('n', '<C-k>', vim.lsp.buf.signature_help, opts)
keymap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
keymap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
keymap('n', '<leader>wl', function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, opts)
keymap('n', '<leader>D', vim.lsp.buf.type_definition, opts)
keymap('n', '<leader>rn', vim.lsp.buf.rename, opts)
keymap('n', '<leader>ca', vim.lsp.buf.code_action, opts)
keymap('n', 'gr', vim.lsp.buf.references, opts)
keymap('n', '<leader>d', vim.diagnostic.open_float, opts)
keymap('n', '[d', vim.diagnostic.goto_prev, opts)
keymap('n', ']d', vim.diagnostic.goto_next, opts)
keymap('n', '<leader>q', vim.diagnostic.setloclist, opts)
keymap('n', '<leader>lf', vim.lsp.buf.format, opts)
