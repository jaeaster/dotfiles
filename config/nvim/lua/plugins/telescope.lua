-- Telescope: Search files, search text, search buffers, help
vim.keymap.set('n', '<leader>f', ':lua require("telescope.builtin").find_files()<cr>')
vim.keymap.set('n', '<leader>g', ':lua require("telescope.builtin").live_grep()<cr>')
vim.keymap.set('n', '<leader>b', ':lua require("telescope.builtin").buffers()<cr>')
vim.keymap.set('n', '<leader>h', ':lua require("telescope.builtin").help_tags()<cr>')
