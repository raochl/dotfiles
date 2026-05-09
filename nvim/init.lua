require 'core.options'
require 'core.keymaps'
require 'core.autocmds'

vim.g.have_nerd_font = vim.g.have_nerd_font or false

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
local uv = vim.uv or vim.loop

if not uv.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

local default_theme = 'nord'
local selected_theme = os.getenv 'NVIM_THEME' or default_theme
local themes = {
  nord = 'plugins.themes.nord',
  onedark = 'plugins.themes.onedark',
}

if not themes[selected_theme] then
  selected_theme = default_theme
end

require('lazy').setup({
  require(themes[selected_theme]),
  require 'plugins.telescope',
  require 'plugins.treesitter',
  require 'plugins.lsp',
  require 'plugins.autocompletion',
  require 'plugins.lualine',
  require 'plugins.neo-tree',
  require 'plugins.oil',
  require 'plugins.indent-blankline',
  require 'plugins.gitsigns',
  require 'plugins.comment',
  require 'plugins.render-markdown',
  require 'plugins.vim-tmux-navigator',
  require 'plugins.misc',
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = ':',
      config = '*',
      event = '@',
      ft = 'F',
      init = 'I',
      keys = 'K',
      plugin = '+',
      runtime = 'R',
      require = '?',
      source = 'S',
      start = '>',
      task = 'T',
      lazy = 'z',
    },
  },
})

local local_config = vim.fn.expand '~/.config/nvim-local.lua'
if vim.fn.filereadable(local_config) == 1 then
  dofile(local_config)
end

-- vim: ts=2 sts=2 sw=2 et
