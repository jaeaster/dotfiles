-- Disable Arrow Keys
vim.keymap.set('n', '<Left>', ':echo "No Left for you!"<CR>')
vim.keymap.set('v', '<Left>', ':<C-u>echo "No Left for you!"<CR>')
vim.keymap.set('i', '<Left>', '<C-o>:echo "No Left for you!"<CR>')

vim.keymap.set('n', '<Right>', ':echo "No Right for you!"<CR>')
vim.keymap.set('v', '<Right>', ':<C-u>echo "No Right for you!"<CR>')
vim.keymap.set('i', '<Right>', '<C-o>:echo "No Right for you!"<CR>')

vim.keymap.set('n', '<Up>', ':echo "No Up for you!"<CR>')
vim.keymap.set('v', '<Up>', ':<C-u>echo "No Up for you!"<CR>')
vim.keymap.set('i', '<Up>', '<C-o>:echo "No Up for you!"<CR>')

vim.keymap.set('n', '<Down>', ':echo "No Down for you!"<CR>')
vim.keymap.set('v', '<Down>', ':<C-u>echo "No Down for you!"<CR>')
vim.keymap.set('i', '<Down>', '<C-o>:echo "No Down for you!"<CR>')

-- Create Splits
vim.keymap.set('n', '<leader>v', ':vsp<CR>', { noremap = false })
vim.keymap.set('n', '<leader>s', ':sp<CR>', { noremap = false })

-- Move between splits
vim.keymap.set('n', '<C-J>', '<C-W><C-J>')
vim.keymap.set('n', '<C-K>', '<C-W><C-K>')
vim.keymap.set('n', '<C-L>', '<C-W><C-L>')
vim.keymap.set('n', '<C-H>', '<C-W><C-H>')
