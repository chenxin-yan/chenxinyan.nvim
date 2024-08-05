return {
  'wintermute-cell/gitignore.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  keys = {
    { '<leader>gi', '<cmd>Gitignore<cr>', desc = 'generate gitignore file' },
  },
}
