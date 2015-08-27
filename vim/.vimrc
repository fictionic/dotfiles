set nocp "has to be first line
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'flazz/vim-colorschemes'
" add more plugins here!!!

call vundle#end()
filetype plugin indent on
" (to ignore plugin indent changes, use
"filetype plugin on
" instead.)

"--->>> non-plugin settings <<<---"
syntax on
colorscheme SlateDarkBlue
set noswapfile
set backspace=2
set mouse=a
set tabstop=4
set noexpandtab
set shiftwidth=0
set autoindent
set cindent
set smartindent
set number
set ruler
"set hlsearch
"^actually I don't like this
set incsearch "moves cursor to first instance of matched pattern while typing pattern
command! W w
command! Q q
command TEx Tex


"---MAPPINGS---"
let mapleader = ","
nmap <leader>xp x"xp
nnoremap <leader>m M
nnoremap <leader>o o<C-C>
nnoremap <leader>O O<C-C>
set timeoutlen=200

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
" give x and X its own buffer
nnoremap x "xx
nnoremap X "xd<BS>
" make <Enter><Enter> split a line at the cursor
nnoremap <CR><CR> i<CR><ESC>

" map Shift+Tab to be used as hotkey for Esc
" except instead of Esc we'll use Control+C
map <S-Tab> <C-C>
map! <S-Tab> <C-C>

" make Control+C also get rid of any search highlighting that has taken place
nnoremap <C-C> <C-C>:noh<CR>:<BS>

" map  to backspace, like it is in the terminal
noremap  
noremap!  
" make Ctrl+Backspace delete a word backwards in all modes
map  db
map!  <C-C>dba
" make Ctrl+Delete delete a word forwards in all modes
map [3;5~ dw
map! [3;5~ <C-C>dwi
" make Ctrl+Left move one word backwards in all modes
map Od b
map! Od <C-C>bi
" make Ctrl+Right move one word forwards in all modes
map Oc w
map! Oc <C-C>lwi

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
