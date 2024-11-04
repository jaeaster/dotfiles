local telescope = require 'telescope'
local actions = require 'telescope.actions'

telescope.setup {
  defaults = {
    mappings = {
      i = {
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
        ['<esc>'] = actions.close,
      },
    },
    file_ignore_patterns = {
      'node_modules',
      '.git/',
      '.cache',
      '%.o',
      '%.a',
      '%.out',
      '%.class',
      '%.pdf',
      '%.mkv',
      '%.mp4',
      '%.zip',
    },
  },
  pickers = {
    find_files = {
      theme = 'dropdown',
      previewer = true,
      hidden = true,
    },
    live_grep = {
      theme = 'dropdown',
    },
    buffers = {
      theme = 'dropdown',
      previewer = false,
    },
  },
}
