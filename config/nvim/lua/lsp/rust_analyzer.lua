local M = {}

M.setup = function(on_attach, capabilities)
  require('rust-tools').setup {
    server = {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        ['rust-analyzer'] = {
          checkOnSave = {
            command = 'clippy',
          },
          server = {
            standalone = false,
          },
        },
      },
    },
  }
end

return M
