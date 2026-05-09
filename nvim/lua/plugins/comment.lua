return {
  'numToStr/Comment.nvim',
  opts = {},
  config = function(_, opts)
    require('Comment').setup(opts)
    local api = require 'Comment.api'
    local map_opts = { noremap = true, silent = true }
    vim.keymap.set('n', '<C-_>', api.toggle.linewise.current, map_opts)
    vim.keymap.set('n', '<C-/>', api.toggle.linewise.current, map_opts)
    vim.keymap.set('v', '<C-_>', "<Esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", map_opts)
    vim.keymap.set('v', '<C-/>', "<Esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", map_opts)
  end,
}
