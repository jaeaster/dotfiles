require('lspsaga').init_lsp_saga {}
vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', { silent = true })

local action = require 'lspsaga.action'

vim.keymap.set('n', '<C-f>', function()
  action.smart_scroll_with_saga(1)
end, { silent = true })

vim.keymap.set('n', '<C-b>', function()
  action.smart_scroll_with_saga(-1)
end, { silent = true })
