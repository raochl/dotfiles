local yank_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  group = yank_group,
  pattern = '*',
  callback = function()
    local highlighter = vim.hl or vim.highlight
    highlighter.on_yank()
  end,
})

vim.api.nvim_set_hl(0, 'ExtraWhitespace', { bg = '#BF616A' })

local whitespace_group = vim.api.nvim_create_augroup('TrailingWhitespace', { clear = true })

local function set_trailing_match(pattern)
  local ok, match_id = pcall(vim.api.nvim_win_get_var, 0, 'extra_whitespace_match')
  if ok then
    pcall(vim.fn.matchdelete, match_id)
  end

  local new_match_id = vim.fn.matchadd('ExtraWhitespace', pattern)
  vim.api.nvim_win_set_var(0, 'extra_whitespace_match', new_match_id)
end

vim.api.nvim_create_autocmd({ 'BufWinEnter', 'InsertLeave' }, {
  group = whitespace_group,
  pattern = '*',
  callback = function()
    set_trailing_match [[\s\+$]]
  end,
})

vim.api.nvim_create_autocmd('InsertEnter', {
  group = whitespace_group,
  pattern = '*',
  callback = function()
    set_trailing_match [[\s\+\%#\@<!$]]
  end,
})

vim.api.nvim_create_autocmd('BufWinLeave', {
  group = whitespace_group,
  pattern = '*',
  callback = function()
    local ok, match_id = pcall(vim.api.nvim_win_get_var, 0, 'extra_whitespace_match')
    if ok then
      pcall(vim.fn.matchdelete, match_id)
    end
  end,
})

vim.diagnostic.config {
  virtual_text = {
    prefix = '*',
    format = function(diagnostic)
      local code = diagnostic.code and string.format('[%s]', diagnostic.code) or ''
      return string.format('%s %s', code, diagnostic.message)
    end,
  },
  underline = false,
  update_in_insert = true,
  float = {
    source = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = 'E',
      [vim.diagnostic.severity.WARN] = 'W',
      [vim.diagnostic.severity.INFO] = 'I',
      [vim.diagnostic.severity.HINT] = 'H',
    },
  },
}
