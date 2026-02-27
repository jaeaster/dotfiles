-- lua/lsp/init.lua
local M = {}

-- LSP UI customization
local signs = {
  { name = 'DiagnosticSignError', text = '' },
  { name = 'DiagnosticSignWarn',  text = '' },
  { name = 'DiagnosticSignHint',  text = '' },
  { name = 'DiagnosticSignInfo',  text = '' },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
end

local config = {
  virtual_text = false, -- disable virtual text
  signs = {
    active = signs,     -- show signs
  },
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

vim.diagnostic.config(config)

-- Show line diagnostics automatically in hover window
vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, { focus = false })]]

-- Hover configuration
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded',
})

-- Signature help configuration
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = 'rounded',
})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
M.on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

  -- Highlighting references
  -- See `:help CursorHold` for information about when this is executed
  if client.server_capabilities.documentHighlightProvider then
    vim.cmd [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end

  -- Format on save
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = vim.api.nvim_create_augroup('LspFormat.' .. bufnr, {}),
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format {
          filter = function(client)
            -- Use none-ls for formatting in JavaScript/TypeScript
            local filetype = vim.bo.filetype
            if
                filetype == 'javascript'
                or filetype == 'typescript'
                or filetype == 'typescriptreact'
                or filetype == 'javascriptreact'
            then
              return client.name == 'null-ls'
            end
            -- Disable formatting for certain servers
            return client.name ~= 'ts_ls' and client.name ~= 'solidity_ls_nomicfoundation'
          end,
          bufnr = bufnr,
        }
      end,
    })
  end

  -- Illuminate setup
  require('illuminate').on_attach(client)
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

M.capabilities = capabilities

-- Enable the following language servers
local servers = {
  'pyright',
  'lua_ls',
  'ts_ls',
  'tailwindcss',
  'rust_analyzer',
  'biome',
  'ruff',
  'jsonls',
  'yamlls',
  'terraformls',
  'solidity_ls_nomicfoundation',
}

-- Setup mason-lspconfig
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = servers,
}

-- Settings that can be overridden by server-specific settings
local default_settings = {
  -- Add any default settings you want all LSPs to have
}

-- Setup each server
mason_lspconfig.setup_handlers {
  function(server_name)
    local opts = {
      on_attach = M.on_attach,
      capabilities = M.capabilities,
      flags = {
        debounce_text_changes = 150,
      },
    }

    -- Try to load server-specific configuration
    local has_server_config, server_config = pcall(require, 'lsp.' .. server_name)

    if has_server_config then
      -- If server has a custom setup function, use it
      server_config.setup(opts.on_attach, opts.capabilities)
    else
      -- Otherwise, use the default setup
      require('lspconfig')[server_name].setup(opts)
    end
  end,
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

return M
