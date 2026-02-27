local null_ls = require 'null-ls'
local b = null_ls.builtins

local forgefmt = {
  name = 'forgefmt',
  meta = {
    url = 'https://github.com/foundry-rs/foundry/tree/master/fmt',
    description = 'A tool for formatting Solidity code according to style guidelines.',
  },
  method = null_ls.methods.FORMATTING,
  filetypes = { 'solidity' },
  generator = null_ls.formatter {
    command = 'forge',
    args = { 'fmt', '--raw', '-' },
    to_stdin = true,
  },
}

local sources = {
  -- b.code_actions.eslint_d,
  -- b.formatting.eslint_d,
  b.formatting.rome.with { command = 'biome' },
  b.formatting.rustywind.with { extra_args = { '--config-file', 'rustywind.json' } },
  b.formatting.stylua,
  -- b.formatting.prettier.with { extra_args = { '--single-quote' } },
  forgefmt,
  b.formatting.google_java_format,

  -- b.diagnostics.eslint_d,
  b.diagnostics.solhint,

  b.completion.spell,
}

local M = {}
M.setup = function(on_attach)
  null_ls.setup {
    sources = sources,
    on_attach = on_attach,
  }
end

return M
