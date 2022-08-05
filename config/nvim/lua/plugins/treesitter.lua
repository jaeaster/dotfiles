require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'bash',
    'c',
    'cpp',
    'rust',
    'go',
    'python',
    'solidity',
    'css',
    'javascript',
    'json',
    'jsonc',
    'lua',
    'make',
    'markdown',
    'scss',
    'toml',
    'tsx',
    'typescript',
    'yaml',
  },
  auto_install = true,
  highlight = {
    enable = true,
    disable = function(_, bufnr)
      return vim.api.nvim_buf_line_count(bufnr) > 5000
    end,
  },
  autopairs = {
    enable = true,
  },
  indent = {
    enable = true,
  },
}
