" best if this is the first line
set nocp

"------------------"
"   VUNDLE STUFF   "
"------------------"
filetype off
filetype plugin indent on

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"accepted formats:
"Plugin 'git-user/repo-name'
"Plugin 'file:///path/to/git/repo'
"Plugin 'git://url.to/git-repo.git

Plugin 'VundleVim/Vundle.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'lervag/vimtex'
Plugin 'google/vim-searchindex' " display index of search result using / or ?
Plugin 'vim-airline/vim-airline'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'scrooloose/syntastic'

call vundle#end()

"-------------"
"   GENERAL   "
"-------------"
syntax on
colorscheme SlateDarkBlue " my own custom modification of SlateDark

"-------------"
"   OPTIONS   "
"-------------"
set noswapfile
set noesckeys
set showcmd

set backspace=indent,eol,start

set tabstop=4
set noexpandtab
set shiftwidth=0

set autoindent
set cindent
set smartindent

set ruler
set number
set relativenumber

set incsearch "moves cursor to first instance of matched pattern while typing pattern

set timeoutlen=200

"-------------------------------"
"   MAPPINGS/ALIASES/COMMANDS   "
"-------------------------------"

let mapleader=" "
let localmapleader="\\"

" easier saving/quitting
" ----
command! W w
command! Q q
command WQ wq
command Wq wq
map <leader>w :w<CR>
map <leader>wq :wq<CR>
map <Space><Space> :w<CR>
map! <Space><Space> <Esc><Space><Space>
map <Space><Space> <Esc><Space><Space>

" open multiple files in tabs, horizontal windows, or vertical windows
" ----
command! -complete=file -nargs=+ Etabs call s:ETW('tabnew', <f-args>)
command! -complete=file -nargs=+ Ewindows call s:ETW('new', <f-args>)
command! -complete=file -nargs=+ Evwindows call s:ETW('vnew', <f-args>)
function! s:ETW(what, ...)
  for f1 in a:000
    let files = glob(f1)
    if files == ''
      execute a:what . ' ' . escape(f1, '\ "')
    else
      for f2 in split(files, "\n")
        execute a:what . ' ' . escape(f2, '\ "')
      endfor
    endif
  endfor
endfunction

" >> SWITCH BETWEEN TABS << "
map <Tab> :tabnext<CR>:
map <S-Tab> :tabprevious<CR>:
" >> MOVE TABS AROUND << "
map <C-l> :tabm +1<CR>:
map <C-h> :tabm -1<CR>:

" >> MOVEMENT << "
" make h,l move between lines when at the end/beginning
noremap h <BS>
nnoremap l <Space>
" except for l when insert mode!
inoremap l <Esc>
" and prevent space from moving to next line when at end!
nnoremap <Space> l
" arrow keys in insert mode
imap <C-k> <C-c>ka
imap <C-j> <C-c>ja
imap <C-l> <C-c>la
imap <C-h> <C-c>ha
" remap _ to ^, since ^ is hard to reach and _ is dumb
noremap _ ^
" enable mouse, but only for scrolling
set mouse=n
noremap <LeftMouse> <Nop>
noremap! <LeftMouse> <Nop>
noremap <RightMouse> <Nop>
noremap! <RightMouse> <Nop>
" shift+click+drag for selecting manually

" >> GENERAL EDITING << "
" ----
" make Y work like it should
noremap Y y$
" use U instead of Ctrl+R for redo
nnoremap U <C-R>
" use Ctrl+u for undo-line
nnoremap <C-u> U
" make cb and db work like they ought to (i.e. make them delete the character under the cursor)
noremap cb vbc
noremap db vbd
" make <Enter><Enter> split a line at the cursor
nnoremap <CR><CR> i<CR><ESC>
" create new line above/below without entering insert mode
nnoremap <leader>o o<Esc>
nnoremap <leader>O O<Esc>
" indent current line multiple times
noremap << @='<<'<CR>
noremap >> @='>>'<CR>

" BACKSPACE/DELETE STUFF "
" ----
" map to backspace, like it is in the terminal
noremap  
noremap!  
" make Ctrl+Backspace delete a word backwards
noremap!  <C-w>
" make Ctrl+Delete delete a word forwards in all modes
map! [3;5~ <Esc>cw

" >> UNMAPPINGS << "
nmap K <Nop>
map Q <Nop>
