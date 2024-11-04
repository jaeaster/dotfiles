local M = {}

M.setup = function(on_attach, capabilities)
  require('lspconfig')['terraformls'].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      filetypes = { 'terraform', 'terraform-vars', 'tf' },
      -- root_dir = function(dirpath)
      --   return util.root_pattern('.terraform', '.git')(dirpath) or util.path.dirname(dirpath)
      -- end,
    },
  }
end

return M
