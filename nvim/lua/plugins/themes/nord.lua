return {
  'shaunsingh/nord.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.nord_contrast = true
    vim.g.nord_borders = false
    vim.g.nord_disable_background = true
    vim.g.set_cursorline_transparent = false
    vim.g.nord_italic = false
    vim.g.nord_enable_sidebar_background = false
    vim.g.nord_uniform_diff_background = true
    vim.g.nord_bold = false

    require('nord').set()

    local transparent = true
    vim.keymap.set('n', '<leader>bg', function()
      transparent = not transparent
      vim.g.nord_disable_background = transparent
      vim.cmd.colorscheme 'nord'
    end, { noremap = true, silent = true, desc = 'Toggle background' })
  end,
}
