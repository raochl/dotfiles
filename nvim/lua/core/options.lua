vim.o.hlsearch = true
vim.o.incsearch = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.mouse = 'a'
vim.o.clipboard = 'unnamedplus'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.wo.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.completeopt = 'menuone,noselect'
vim.opt.termguicolors = true
vim.o.whichwrap = 'bs<>[]hl'
vim.o.wrap = false
vim.o.linebreak = true
vim.o.scrolloff = 5
vim.o.sidescrolloff = 8
vim.o.numberwidth = 4
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.expandtab = false
vim.o.smarttab = true
vim.o.cursorline = false
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.smartindent = true
vim.o.showmode = false
vim.o.showtabline = 1
vim.o.backspace = 'indent,eol,start'
vim.o.pumheight = 10
vim.o.conceallevel = 0
vim.o.fileencoding = 'utf-8'
vim.o.cmdheight = 1
vim.o.autoindent = true
vim.o.laststatus = 3
vim.o.wildmode = 'longest,list'
vim.o.wildmenu = true

vim.opt.shortmess:append 'c'
vim.opt.iskeyword:append '-'
vim.opt.formatoptions:remove { 'c', 'r', 'o' }
vim.opt.runtimepath:remove '/usr/share/vim/vimfiles'

if vim.fn.has 'nvim-0.11' == 1 then
  vim.o.winborder = 'rounded'
end
