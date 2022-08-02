-- Create Splits
vim.keymap.set('n', '<leader>v', ':vsp<CR>', { noremap = false })
vim.keymap.set('n', '<leader>s', ':sp<CR>', { noremap = false })

-- Move between splits
vim.keymap.set('n', '<C-J>', '<C-W><C-J>')
vim.keymap.set('n', '<C-K>', '<C-W><C-K>')
vim.keymap.set('n', '<C-L>', '<C-W><C-L>')
vim.keymap.set('n', '<C-H>', '<C-W><C-H>')
