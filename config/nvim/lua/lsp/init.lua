-- Diagnostic signs
local signs = {
  { name = 'DiagnosticSignError', text = '' },
  { name = 'DiagnosticSignWarn',  text = '' },
  { name = 'DiagnosticSignHint',  text = '' },
  { name = 'DiagnosticSignInfo',  text = '' },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
end

vim.diagnostic.config {
  virtual_text = false,
  signs = { active = signs },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = true,
    style = 'minimal',
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
}

-- Show diagnostics on hover
vim.o.updatetime = 250
vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false })
  end,
})

-- LspAttach autocmd (replaces on_attach)
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf

    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Document highlight
    if client and client.server_capabilities.documentHighlightProvider then
      local group = vim.api.nvim_create_augroup('lsp_document_highlight_' .. bufnr, { clear = true })
      vim.api.nvim_create_autocmd('CursorHold', {
        group = group, buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd('CursorMoved', {
        group = group, buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
      })
    end

    -- Format on save
    if client and client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('LspFormat.' .. bufnr, {}),
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format {
            filter = function(c)
              local filetype = vim.bo.filetype
              if filetype == 'javascript' or filetype == 'typescript'
                  or filetype == 'typescriptreact' or filetype == 'javascriptreact' then
                return c.name == 'null-ls'
              end
              return c.name ~= 'ts_ls' and c.name ~= 'solidity_ls_nomicfoundation'
            end,
            bufnr = bufnr,
          }
        end,
      })
    end

    -- Illuminate
    require('illuminate').on_attach(client)
  end,
})

-- Capabilities (shared across all servers)
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.config('*', {
  capabilities = capabilities,
})

-- Servers to install and enable
local servers = {
  'pyright',
  'lua_ls',
  'ts_ls',
  'tailwindcss',
  'biome',
  'ruff',
  'jsonls',
  'yamlls',
  'terraformls',
  'solidity_ls_nomicfoundation',
}

-- Ensure servers are installed
require('mason-lspconfig').setup {
  ensure_installed = servers,
  automatic_enable = false,
}

-- Load per-server configs
for _, server in ipairs(servers) do
  local ok, server_config = pcall(require, 'lsp.' .. server)
  if ok then
    vim.lsp.config(server, server_config)
  end
end

-- Enable all servers
vim.lsp.enable(servers)

-- Rustaceanvim (manages rust-analyzer itself)
vim.g.rustaceanvim = {
  server = {
    default_settings = {
      ['rust-analyzer'] = {
        check = { command = 'clippy' },
      },
    },
  },
}

-- Suppress irrelevant messages
local notify = vim.notify
vim.notify = function(msg, ...)
  if msg:match '^warning: multiple different client offset_encodings detected' then
    return
  end
  if msg:match 'received `end` message with no corresponding `begin`' then
    return
  end
  notify(msg, ...)
end
