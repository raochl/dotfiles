return {
  'navarasu/onedark.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    local onedark = require 'onedark'
    local config = {
      style = 'dark',
      transparent = true,
      term_colors = true,
      ending_tildes = false,
      cmp_itemkind_reverse = false,
      code_style = {
        comments = 'italic',
        keywords = 'none',
        functions = 'none',
        strings = 'none',
        variables = 'none',
      },
      lualine = {
        transparent = false,
      },
      diagnostics = {
        darker = true,
        undercurl = true,
        background = false,
      },
    }

    onedark.setup(config)
    onedark.load()

    vim.keymap.set('n', '<leader>bg', function()
      config.transparent = not config.transparent
      onedark.setup(config)
      onedark.load()
    end, { noremap = true, silent = true, desc = 'Toggle background' })
  end,
}
