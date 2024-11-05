local null_ls = require 'null-ls'
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

-- Custom forgefmt source
local forgefmt = {
  name = 'forgefmt',
  method = null_ls.methods.FORMATTING,
  filetypes = { 'solidity' },
  generator = null_ls.formatter {
    command = 'forge',
    args = { 'fmt', '--raw', '-' },
    to_stdin = true,
    runtime_condition = function()
      -- Only run forge fmt if we're in a Foundry project
      return vim.fn.filereadable 'foundry.toml' == 1 or vim.fn.filereadable 'forge.toml' == 1
    end,
  },
}

null_ls.setup {
  debug = false,
  sources = {
    -- Formatting
    formatting.biome, -- Replaces rome
    formatting.rustywind.with {
      extra_args = { '--config-file', 'rustywind.json' },
    },
    formatting.stylua,
    formatting.google_java_format,
    forgefmt,

    -- Diagnostics
    diagnostics.solhint,

    -- Code Actions
    code_actions.gitsigns,
  },
}
