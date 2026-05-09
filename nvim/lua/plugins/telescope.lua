return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    'nvim-telescope/telescope-ui-select.nvim',
  },
  config = function()
    local actions = require 'telescope.actions'
    local builtin = require 'telescope.builtin'

    require('telescope').setup {
      defaults = {
        layout_strategy = 'horizontal',
        layout_config = {
          horizontal = {
            prompt_position = 'bottom',
            preview_width = 0.6,
            width = { padding = 0 },
            height = { padding = 0 },
          },
        },
        file_ignore_patterns = { 'node_modules', '%.git', '%.venv' },
        mappings = {
          i = {
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-j>'] = actions.move_selection_next,
            ['<C-l>'] = actions.select_default,
          },
          n = {
            ['q'] = actions.close,
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
        buffers = {
          initial_mode = 'normal',
          sort_lastused = true,
          mappings = {
            n = {
              ['d'] = actions.delete_buffer,
              ['l'] = actions.select_default,
            },
          },
        },
        marks = {
          initial_mode = 'normal',
        },
        oldfiles = {
          initial_mode = 'normal',
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = 'Search buffers' })
    vim.keymap.set('n', '<leader><tab>', builtin.buffers, { desc = 'Search buffers' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Search buffers' })
    vim.keymap.set('n', '<leader>sm', builtin.marks, { desc = 'Search marks' })
    vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Search git files' })
    vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = 'Search git commits' })
    vim.keymap.set('n', '<leader>gcf', builtin.git_bcommits, { desc = 'Search current file commits' })
    vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'Search git branches' })
    vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = 'Search git status' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Search files' })
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Search help' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = 'Search current word' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Search grep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Search diagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = 'Search resume' })
    vim.keymap.set('n', '<leader>so', builtin.oldfiles, { desc = 'Search recent files' })
    vim.keymap.set('n', '<leader>/', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { previewer = false })
    end, { desc = 'Search current buffer' })
  end,
}
