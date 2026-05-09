return {
  'nvim-lualine/lualine.nvim',
  config = function()
    local selected_theme = os.getenv 'NVIM_THEME'
    local theme = selected_theme == 'onedark' and 'onedark' or 'nord'

    local hide_in_width = function()
      return vim.fn.winwidth(0) > 100
    end

    require('lualine').setup {
      options = {
        icons_enabled = false,
        theme = theme,
        section_separators = '',
        component_separators = '|',
        disabled_filetypes = { statusline = { 'neo-tree', 'oil' } },
        always_divide_middle = true,
        globalstatus = true,
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { { 'filename', path = 0 } },
        lualine_x = {
          { 'diagnostics', symbols = { error = 'E:', warn = 'W:', info = 'I:', hint = 'H:' }, cond = hide_in_width },
          { 'diff', symbols = { added = '+', modified = '~', removed = '-' }, cond = hide_in_width },
          { 'encoding', cond = hide_in_width },
          { 'filetype', cond = hide_in_width },
        },
        lualine_y = { 'location' },
        lualine_z = { 'progress' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { 'fugitive' },
    }
  end,
}
