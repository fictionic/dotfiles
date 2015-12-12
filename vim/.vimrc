set nocp "has to be first line

"---VUNDLE STUFF---"
filetype off "required by vundle

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"accepted formats:
"Plugin 'git-user/repo-name'
"Plugin 'file:///path/to/git/repo'
"Plugin 'git://url.to/git-repo.git

Plugin 'VundleVim/Vundle.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'lervag/vimtex'

call vundle#end()
filetype plugin indent on "required by vundle

"---NON-VUNDLE STUFF---"
"----------------------"
syntax on
colorscheme SlateDarkBlue
set noswapfile
set backspace=indent,eol,start
set mouse=a
set tabstop=4
set noexpandtab
set shiftwidth=0
set autoindent
set cindent
set smartindent
set number
set ruler
set incsearch "moves cursor to first instance of matched pattern while typing pattern

set timeoutlen=200

"---MAPPINGS/ALIASES---"

let localmapleader="\\"

command! W w
command! Q q
command! WQ wq
command! Wq wq

nnoremap ,o o<Esc>
nnoremap ,O O<Esc>

" make Y work like it should
noremap Y y$
" use U instead of Ctrl+R for redo
nnoremap U <C-R>
" don't use M
nnoremap M <Nop>
" don't use K
nmap K <Nop>
" don't use Q!!!
map Q <Nop>
" unmap Ctrl+U, cuz xterm is dumb
map  <Nop>
map!  <Nop>
" make cb and db work like they ought to (i.e. make them delete the character
" under the cursor)
noremap cb vbc
noremap db vbd
" make <Enter><Enter> split a line at the cursor
nnoremap <CR><CR> i<CR><ESC>

" map  to backspace, like it is in the terminal
noremap  
noremap!  
" make Ctrl+Backspace delete a word backwards in all modes
noremap  vbd
noremap!  <Esc>vbc
" make Ctrl+Delete delete a word forwards in all modes
map [3;5~ dw
map! [3;5~ <Esc>cw
" make Ctrl+Left move one word backwards in all modes
" map Od b
" map! Od <Esc>bi
" make Ctrl+Right move one word forwards in all modes
" map Oc w
" map! Oc <Esc>lwi
" ^^^ these make Alt+O have a pause when using in insert mode

" tab stuff
map <Tab> :tabnext<CR>
map <S-Tab> :tabprevious<CR>

" make HOME work as it should
"map [H ^
"map! [H blah
" make END work as it should
"map [H $
"map! [H <C-C>$a

" old stuff... in case I want/need to use noesckeys for some reason
"set noesckeys
"inoremap <C-[>OA <Up>
"inoremap <C-[>OC <Right>
"inoremap <C-[>OB <Down>
"inoremap <C-[>OD <Left>
"imap <C-[>OH <S-Tab>^i
"nmap <C-[>OH ^
"imap <C-[>OF <S-Tab>$a
"nmap <C-[>OF $
"maping the delete key
"imap <C-[>[3~ <S-Tab>lxi
"nmap <C-[>[3~ x
