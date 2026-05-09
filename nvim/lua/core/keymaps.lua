vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local opts = { noremap = true, silent = true }

local function desc_opts(desc, extra)
  return vim.tbl_extend('force', opts, extra or {}, { desc = desc })
end

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', opts)
vim.keymap.set('n', '<C-s>', '<cmd>write<CR>', opts)
vim.keymap.set('n', 'S', '<cmd>write<CR>', opts)
vim.keymap.set('n', 'Q', '<cmd>wq<CR>', opts)
vim.keymap.set('n', '<leader>Q', '<cmd>qa<CR>', desc_opts 'Quit nvim')
vim.keymap.set('n', 'R', '<cmd>source $MYVIMRC<CR>', opts)
vim.keymap.set('n', '<Space><Space>', ':', { noremap = true, silent = false })
vim.keymap.set('n', '<Space>v', '<C-v>', desc_opts 'Visual block')

vim.keymap.set('i', 'jk', '<Esc>', opts)
vim.keymap.set('i', 'kj', '<Esc>', opts)
vim.keymap.set('i', '<C-BS>', '<C-W>', opts)
vim.keymap.set('i', '<C-_>', '<C-W>', opts)

vim.keymap.set('n', 'x', '"_x', opts)
vim.keymap.set('n', 'Y', 'y$', opts)
vim.keymap.set('v', 'p', '"_dP', opts)
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Yank to clipboard' })
vim.keymap.set('n', '<leader>Y', [["+Y]], { desc = 'Yank line to clipboard' })

vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)
vim.keymap.set('v', '<A-j>', ':m .+1<CR>==', opts)
vim.keymap.set('v', '<A-k>', ':m .-2<CR>==', opts)

vim.keymap.set('n', '<leader>.', '>>', desc_opts 'Indent line')
vim.keymap.set('n', '<leader>,', '<<', desc_opts 'Unindent line')
vim.keymap.set('n', '<leader>+', '<C-a>', desc_opts 'Increment number')
vim.keymap.set('n', '<leader>-', '<C-x>', desc_opts 'Decrement number')
vim.keymap.set('n', '<leader>rw', '*``cgn', desc_opts 'Replace word')

vim.keymap.set('n', '<leader>h', '<C-w>h', desc_opts 'Window left')
vim.keymap.set('n', '<leader>j', '<C-w>j', desc_opts 'Window down')
vim.keymap.set('n', '<leader>k', '<C-w>k', desc_opts 'Window up')
vim.keymap.set('n', '<leader>l', '<C-w>l', desc_opts 'Window right')
vim.keymap.set('n', 'sr', '<cmd>set splitright<CR><cmd>vsplit<CR>', opts)
vim.keymap.set('n', 'sl', '<cmd>set nosplitright<CR><cmd>vsplit<CR>', opts)
vim.keymap.set('n', 'su', '<cmd>set nosplitbelow<CR><cmd>split<CR>', opts)
vim.keymap.set('n', 'sb', '<cmd>set splitbelow<CR><cmd>split<CR>', opts)
vim.keymap.set('n', '<leader><Up>', '<cmd>resize +5<CR>', desc_opts 'Increase window height')
vim.keymap.set('n', '<leader><Down>', '<cmd>resize -5<CR>', desc_opts 'Decrease window height')
vim.keymap.set('n', '<leader><Left>', '<cmd>vertical resize -5<CR>', desc_opts 'Decrease window width')
vim.keymap.set('n', '<leader><Right>', '<cmd>vertical resize +5<CR>', desc_opts 'Increase window width')
vim.keymap.set('n', '<leader>se', '<C-w>=', desc_opts 'Equalize splits')
vim.keymap.set('n', '<leader>xs', '<cmd>close<CR>', desc_opts 'Close split')

vim.keymap.set('n', '<Tab>', '<cmd>bnext<CR>', opts)
vim.keymap.set('n', '<S-Tab>', '<cmd>bprevious<CR>', opts)
vim.keymap.set('n', '<C-i>', '<C-i>', opts)
vim.keymap.set('n', '<leader>x', '<cmd>bdelete<CR>', desc_opts 'Close buffer')
vim.keymap.set('n', '<leader>b', '<cmd>enew<CR>', desc_opts 'New buffer')

vim.keymap.set('n', 'tbu', '<cmd>tabnew<CR>', opts)
vim.keymap.set('n', 'tbc', '<cmd>tabclose<CR>', opts)
vim.keymap.set('n', 'tbf', '<cmd>tabprevious<CR>', opts)
vim.keymap.set('n', 'tbn', '<cmd>tabnext<CR>', opts)

vim.keymap.set('n', '<leader>lw', '<cmd>set wrap!<CR>', desc_opts 'Toggle wrap')
vim.keymap.set('n', '<leader>c', '<cmd>set cursorline! cursorcolumn!<CR>', desc_opts 'Toggle cursor line')
vim.keymap.set('n', '<leader>oj', '<cmd>set paste<CR>m`o<Esc>``<cmd>set nopaste<CR>', desc_opts 'Insert line below')
vim.keymap.set('n', '<leader>ok', '<cmd>set paste<CR>m`O<Esc>``<cmd>set nopaste<CR>', desc_opts 'Insert line above')

local diagnostics_active = true
vim.keymap.set('n', '<leader>do', function()
  diagnostics_active = not diagnostics_active
  vim.diagnostic.enable(diagnostics_active)
end, { desc = 'Toggle diagnostics' })

vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump { count = -1, float = true }
end, { desc = 'Previous diagnostic' })

vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump { count = 1, float = true }
end, { desc = 'Next diagnostic' })

vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Line diagnostic' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostics list' })
vim.keymap.set('n', '<leader>ss', '<cmd>mksession! .session.vim<CR>', desc_opts('Save session', { silent = false }))
vim.keymap.set('n', '<leader>sl', '<cmd>source .session.vim<CR>', desc_opts('Load session', { silent = false }))
