return {
  {
    'tpope/vim-sleuth',
  },
  {
    'tpope/vim-fugitive',
  },
  {
    'tpope/vim-rhubarb',
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      delay = 700,
      icons = {
        breadcrumb = '>',
        separator = '->',
        group = '+',
        ellipsis = '...',
        mappings = false,
        rules = false,
        colors = false,
        keys = {
          Up = 'Up',
          Down = 'Down',
          Left = 'Left',
          Right = 'Right',
          C = 'C-',
          M = 'M-',
          D = 'D-',
          S = 'S-',
          CR = 'CR',
          Esc = 'Esc',
          ScrollWheelDown = 'ScrollDown',
          ScrollWheelUp = 'ScrollUp',
          NL = 'NL',
          BS = 'BS',
          Space = 'Space',
          Tab = 'Tab',
        },
      },
      spec = {
        { '<leader>g', group = 'git' },
        { '<leader>n', group = 'neo-tree' },
        { '<leader>o', group = 'open line' },
        { '<leader>r', group = 'replace' },
        { '<leader>s', group = 'search/session' },
      },
    },
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    opts = {},
  },
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
}
