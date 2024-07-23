return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [']quote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sdq   - [S]urround [D]elete [Q]quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()

    -- inline color highlight for color code
    -- #ffffff
    -- config copied from lazynvim
    local hipatterns = require 'mini.hipatterns'
    hipatterns.setup {
      highlighters = {
        hex_color = hipatterns.gen_highlighter.hex_color { priority = 2000 },
        shorthand = {
          pattern = '()#%x%x%x()%f[^%x%w]',
          group = function(_, _, data)
            ---@type string
            local match = data.full_match
            local r, g, b = match:sub(2, 2), match:sub(3, 3), match:sub(4, 4)
            local hex_color = '#' .. r .. r .. g .. g .. b .. b

            return MiniHipatterns.compute_hex_color_group(hex_color, 'bg')
          end,
          extmark_opts = { priority = 2000 },
        },
      },
    }

    -- split and joint parameters within brackets
    local sj = require 'mini.splitjoin'
    sj.setup()
    vim.keymap.set({ 'n', 'x' }, '<leader>cs', function()
      sj.toggle()
    end, { desc = 'Toggle [C]ode [S]plitjoin' })

    -- move code line/block horizontally or vertically
    require('mini.move').setup {
      mappings = {
        -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
        left = '<M-S-h>',
        right = '<M-S-l>',
        down = '<M-S-j>',
        up = '<M-S-k>',

        -- Move current line in Normal mode
        line_left = '<M-S-h>',
        line_right = '<M-S-l>',
        line_down = '<M-S-j>',
        line_up = '<M-S-k>',
      },
    }

    -- smart buffer deletion
    local bufr = require 'mini.bufremove'
    bufr.setup()
    vim.keymap.set('n', '<leader>bd', function()
      bufr.delete(0, false)
    end, { desc = '[B]uffer [D]elete current' })
  end,
}
