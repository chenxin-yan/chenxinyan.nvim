return {
  'folke/todo-comments.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {},
  config = function()
    require('todo-comments').setup()
    -- jump between todo comments
    vim.keymap.set('n', ']t', function()
      require('todo-comments').jump_next()
    end, { desc = 'Next todo comment' })
    vim.keymap.set('n', '[t', function()
      require('todo-comments').jump_prev()
    end, { desc = 'Previous todo comment' })

    -- Open todo comment tree in builtin quckfix window
    vim.keymap.set('n', '<leader>xt', '<cmd>exe ":TodoQuickFix keywords=TODO,FIXME,FIX cwd=" .. fnameescape(expand("%:p"))<CR>', { desc = 'Open [T]odo tree' })

    -- search todo comments via telescope
    vim.keymap.set('n', '<leader>st', '<cmd>TodoTelescope keywords=TODO,FIXME,FIX<CR>', { desc = '[S]earch [T]odos' })
    vim.keymap.set('n', '<leader>sT', '<cmd>TodoTelescope<CR>', { desc = '[S]earch all highlighted [C]omments' })
  end,
}
