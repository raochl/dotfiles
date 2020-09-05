" Include default global config 
if filereadable("/etc/vimrc")
    source /etc/vimrc 
endif

" Vimscript file settings -----------------------{{{
augroup filetype_vim 
    autocmd ! 
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" Pathogen -------------------------------- {{{
" "https://github.com/tpope/vim-pathogen"
execute pathogen#infect()
" }}}


syntax on
filetype plugin indent on

" Space leader 
nnoremap <space> <nop>
let mapleader=" "

set autoindent 
set background=dark
set t_Co=256
set backspace=2
set colorcolumn=+1	" highlight column after 'textwidth' "
set expandtab
set hlsearch
set ignorecase
set incsearch	" incremental search"
set list 
set listchars=eol:¬,tab:>-,trail:•,extends:>,precedes:<
set mouse=a
set number
set relativenumber
set nocompatible
set ruler
set shiftwidth=4
set showcmd
set showmatch			" highlight the match bracket"
set smartcase
set smarttab
set tabstop=4
set noexpandtab
set scrolloff=5
"set cindent
set clipboard=unnamedplus	" make yank reg to os regfile"
set wildmode=longest,list	" tab completion for files/buffers"
set wildmenu 
"set cursorline


" Trailing whitespace highlighting -------------- {{{
" "http://vim.wikia.com/wiki/Highlight_unwanted_spaces"
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
" }}}
" }}}

" Global Mappings -------------------------------------- {{{
" So much thanks to Steve Losh's "Learn Vimscript the Hard Way"
" "http://learnvimscriptthehardway.stevelosh.com/chapters/06.html"
" "http://learnvimscriptthehardway.stevelosh.com/chapters/07.html"

" Insert Mode ----------------------------------- {{{
" jk/kj as Escape ------------------------------- {{{
inoremap jk <esc>
inoremap kj <esc>
" }}}
" }}}


" Selectors ------------------------------------- {{{
" More thanks to Steve Losh's "Learn Vimscript the Hard Way"
" "http://learnvimscriptthehardway.stevelosh.com/chapters/15.html"
" a fast way to select all the character inside () and {}
" use dp to delete the sentences inside the ()
" use cp to modify the sentences inside the () 
" Inside _P_arentheses
onoremap p i(
" Inside curly breaces
onoremap o i{
" }}}

" Crosshair ------------------------------------- {{{
" Set up crosshair, toggle with <leader>c in normal mode
:hi CursorLine cterm=NONE ctermbg=darkgrey ctermfg=white guibg=darkgrey guifg=white
:hi CursorColumn cterm=NONE ctermbg=darkgrey ctermfg=white guibg=darkgrey guifg=white
:nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>
" }}}

" Better typing ------------------------------ {{{
" left and right shift with better typing 
nnoremap <leader>. >>
nnoremap <leader>, <<
" Y yank from current cursor to end of the line 
noremap Y y$
" Force quit with qq 
cnoreabbrev qq q!
cnoreabbrev qqq qall!
" Delete previous word in insert mode 
imap <C-BS> <C-W>
imap <C-_> <C-W>
" Hitting Space is much easier than hitting shift-; 
nnoremap <Space><Space> :
" Block select with space+v 
nnoremap <Space>v <C-v>

" }}}

" blank lines insert ---------------------------- {{{
" COPY FROM thirtythreeforty
" Ctrl-j and Ctrl-k insert blank lines, remaining in command mode 
nnoremap <silent><C-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><C-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>
" }}}

" Windows switch -------------------------------- {{{
map <leader>l	<C-w>l	" switch to right window "
map <leader>h	<C-w>h	" switch to left  window "
map <leader>k   <C-w>k  " switch to upper window "
map <leader>j	<C-w>j  " switch to buttom window "

map sr :set splitright<CR>:vsplit<CR>	" 分割窗口，光标在右边
map sl :set nosplitright<CR>:vsplit<CR>	" 分割窗口，光标在左边
map su :set nosplitbelow<CR>:split<CR>	" 分割窗口，光标在上边
map sb :set splitbelow<CR>:split<CR>	" 分割窗口，光标在下边

map <LEADER><up>	:res +5<CR>		" 分屏往上边移动
map <LEADER><down>	:res -5<CR>		" 分屏往下边移动
map <LEADER><left>	:vertical res -5<CR>	" 分屏往左边移动
map <LEADER><right>	:vertical res +5<CR>	" 分屏往右边移动
" }}}

" tab ------------------------------------------ {{{
map tbu :tabe<cr>	" create a new tab file"
map tbc :tabclose<cr>	" close current tab "
map tbf :-tabnext<cr>	" move to former tab "
map tbn :+tabnext<cr>   " move to next tab"
" }}}

" file  control -------------------------------- {{{
map R :source $MYVIMRC<cr>	" update vimrc env"
map S :w<cr>			" save file with shift+S"
map Q :wq<cr>			" save and quit "
" }}}

" Plugins ======================================= {{{

" ===================================================
"
"		    Airline 
"  "https://github.com/bling/vim-airline"
"
" ===================================================
let g:airline_powerline_fonts = 1
let g:airline_left_sep='>'
let g:airlint_right_sep='<'
set encoding=utf-8
set laststatus=2
" DONT KNOW WHAT IT IS
" JUST COPY FROM thirtythreeforty
" But the bufferline integration is annoying
let g:airline#extensions#bufferline#enabled = 0
" And so is whitespace detection
let g:airline#extensions#whitespace#enabled = 0
" Enable paste detection
let g:airline_detect_paste=1
" Enable syntastic integration
let g:airline#extensions#syntastic#enabled = 1
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
" Allow jumping to a buffer with <leader><number>
let g:airline#extensions#tabline#buffer_idx_mode = 1

" =====================================================
"
"		NerdTree 
"   "https://github.com/preservim/nerdtree"
"
" =====================================================
map <leader>t :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.swp', '__pycache__']
let NERDTreeShowHidden=1
let NERDTreeShowBookmarks=0

" ====================================================
"
"		NerdTree-tabs 
"   "https://github.com/jistr/vim-nerdtree-tabs"
"
" ====================================================
" focus/unfocus on the NERDTree 
map <C-n> :NERDTreeFocusToggle<CR>
let g:nerdtree_tabs_open_on_gui_startup=0

" ====================================================
"
"	verilog-systemverilog
"   "https://github.com/vhda/verilog_systemverilog.vim"
"
" ====================================================
let g:verilog_disable_indent_lst="module, eos"
nnoremap <LEADER>e :VerilogErrorFormat iverilog 1
" if the cursor is places over a port of the instrance, 
" or instance, the command VerilogFollow can navigate 
" to the module declaration and immediately search the 
" port or the instance.
nnoremap <leader>i :VerilogFollowInstance<CR>
nnoremap <leader>I :VerilogFollowPort<CR>
" jump to start of current instance 
nnoremap <leader>u :VerilogGotoInstanceStart<CR>

" ===================================================
"
"	delimitMate 
"   "https://github.com/Raimondi/delimitMate"
"
" ===================================================
let delimitMate_quotes = "\" "
let delimitMate_matchpairs = "(:), [:], {:}"
let delimitMate_expand_space = 1

" ==================================================
"
"	Indentline
"   "https://github.com/Yggdroot/indentLine"
"
" ==================================================
" customize conceal color 
" Vim
let g:indentLine_color_term = 239
" GVim
let g:indentLine_color_gui = '#A4E57E'
" Background (Vim, GVim)
let g:indentLine_bgcolor_term = 202
let g:indentLine_bgcolor_gui = '#FF5F00'
" use distinct character for indentline
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" =================================================
"
"	Supertab 
"   "https://github.com/ervandew/supertab"
"
" =================================================
let g:SuperTabDefaultCompletionType="<c-n>"

" =================================================
"
"	completor 
"   "https://github.com/maralla/completor.vim"
"
"   Completor is an asynchronous code completion framework.
"   Dont know how to use it, let it installed.
"
" =================================================

" =================================================
"
"	vim-auto-save
"   "https://github.com/vim-scripts/vim-auto-save"
"
" =================================================
let g:auto_save=1
" Don't save while in insert mode
let g:auto_save_in_insert_mode = 0
" do not display the auto-save notification
let g:auto_save_silent = 1  

" }}} ============================END OF PLUGINS 


" Auto add file head ----------------------------- {{{
autocmd BufNewFile *.v,*.sv exec ":call Setfilehead()"

func Setfilehead()
    call append(0, '/*************************************************************')
    call append(1, '*	Copyright(C) '.strftime("%Y").' SHTU_VSP')
    call append(2, '*	    All right reserved')
    call append(3, '*')
    call append(4, '*	FILE NAME:  '.expand('%'))
    call append(5, '*	   AUTHOR:  Chaolin')
    call append(6, '*	     DATE:  '.strftime('%Y-%m-%d %H:%M:%S'))
    call append(7, '*	  Version:  ')
    call append(8, '*')
    call append(9, '* ************************************************************')
    call append(10, '* DESCRIPTION:')
    call append(11, '* ')
    call append(12, '* ')
    call append(13, '* ')
    call append(14, '* ***********************************************************/')
    call append(15, '')
endfunc
