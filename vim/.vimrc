"-------------"
"   OPTIONS   "
"-------------"

" turn on filetype recognition in general, and for plugins, and for indent style
filetype plugin indent on
" don't use any other indentation utilities by default
set nocindent nosmartindent
" except autoindent...?
set autoindent 

" enable syntax highlighting
syntax on

" color scheme: my own custom modification of SlateDark
colorscheme SlateDarkBlue

" disable swap files
set noswapfile

" This allows buffers to be hidden if you've modified a buffer.
" This is almost a must if you wish to use buffers in this way.
set hidden

" automatically re-read modified buffers if no changes have been made inside of vim
set autoread

" disable escape keys, so there's no delay when using Alt+<key> in insert mode
set noesckeys

" show currently pending operators
set showcmd

" enable mouse, but only for normal mode
set mouse=n

" allow backspace to travel back lines
set backspace=indent,eol,start

" no limit for line length
set textwidth=0
" TODO: prevent /usr/share/vim/vim80/ftplugin/vim.vim from setting this to 78

" tabs are four spaces wide
set tabstop=4 softtabstop=4
" use tab character, not spaces
set noexpandtab
" prevent extra tabs from being introduced on >> and cindent
set shiftwidth=0
" wrapped lines stay indented
set breakindent

" show line, column number
set ruler
" relative line numbers
set relativenumber
" show current line number
set number

" moves cursor to first instance of matched pattern while typing pattern
set incsearch
" don't highlight search matches
set nohlsearch

" tab brings up suggestions menu in command mode
set wildmenu
" first tab press expands command to longest possible name,
" remaining tab presses cycle through completions in the wildmenu
set wildmode=longest,full
" ignore non-text files in filename completion
set wildignore+=*.a,*.o
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
set wildignore+=.DS_Store,.git,.hg,.svn
set wildignore+=*~,*.swp,*.tmp

" split in logical directions
set splitbelow
set splitright

" unnamed register is X clipboard
set clipboard=unnamedplus

" remember undo tree after closing file
if has("persistent_undo")
	set undodir=~/.vim/undo
	set undofile
endif

" smart case-sensitivity in regex searches
set smartcase

" timeout for mappings
set timeoutlen=500

" use omnicomplete
set omnifunc=syntaxcomplete#Complete

" don't go to first column with gg or G (good for visual-block)
set nostartofline

"-------------"
"   AUTOCMDS  "
"-------------"

" set spell on iff we're editing text
set nospell
autocmd FileType markdown setlocal spell
autocmd BufRead,BufNewFile *.md setlocal spell

" use spaces in python, and keep indentation level
autocmd FileType python set expandtab autoindent

"-------------------------------"
"   MAPPINGS/ALIASES/COMMANDS   "
"-------------------------------"

let mapleader=" "
let localmapleader="\\"

" easier access to command mode
map <Space> :

" easier reading/writing/quitting
map <leader>e :e 
map <leader>E :e!<CR>
map <leader>w :w<CR>
map <leader>W :w!
map <leader>q :bd<CR>
map <leader>bd :bd<CR>
map <leader>Q :q!<CR>
map <Space><Space> :w<CR>
noremap <Space><Space> <Esc><Space><Space>
map! <Space><Space> <Esc><Space><Space>
imap <Space><Space> <Esc><Space><Space>

" reload vimrc inside vim
nnoremap <leader>r :so $MYVIMRC<CR>

" remove search highlighting when exiting command mode
" cnoremap <silent> <CR> <CR>:nohlsearch<CR>

" switch between buffers
noremap <leader><Tab> :bnext<CR>
noremap <leader><S-Tab> :bprevious<CR>
" move tabs around
map <silent><C-l> :tabm +1<CR>
map <silent><C-h> :tabm -1<CR>

" >> LEADER KEY MAPPINGS << "
" ----
" remove search highlighting and remove any cmdline messages
map <leader>l :nohl<CR>:<BS>
" create new line above/below without entering insert mode
nnoremap <leader>o o<Esc>
nnoremap <leader>O O<Esc>
" generate tags file
map <leader>c :!ctags -R<CR>
" easier access to tilde operator
nnoremap <leader>~ g~

" >> MOTIONS << "
" ----
" make h,l move between lines when at the end/beginning
noremap h <BS>
nnoremap l <Space>
" except Alt-l
inoremap l l
" remap _ to ^, since ^ is hard to reach and the default action of _ is dumb
noremap _ ^
" make end-of-paragraph motion line-wise in operator-pending mode
onoremap } V}
" make jump-to-beginning-of-displayed-line work properly
nnoremap g_ g^
" use exact mark jumps
nnoremap ' `

" >> NORMAL MODE COMMANDS << "
" ----
" make Y work like it should
noremap Y y$
" use U instead of Ctrl+R for redo
nnoremap U <C-R>
" " make cb and db work like they ought to (i.e. make them delete the character under the cursor)
" noremap cb vbc
" noremap db vbd
" clear a single line remaining in normal mode
nnoremap dD 0D
" make <Enter><Enter> split a line at the cursor
nnoremap <CR><CR> i<CR><ESC>
" indent current line multiple times, rather then <C-Del>
noremap <silent><< @='<<'<CR>
noremap <silent>>> @='>>'<CR>
" easy access to "0 register when pasting
nnoremap <leader>p "0p
nnoremap <leader>P "0P
" easy access to "_ register when deleting/cutting
map <leader>d "_d
nnoremap <leader>D "_D
map <leader>c "_c
nnoremap <leader>C "_C
nnoremap <leader>x "_x
nnoremap <leader>X "_X
" don't save deleted text when using s or S
nnoremap s "_s
nnoremap S "_S

" >> BACKSPACE/DELETE STUFF << "
" ----
" map  to backspace, like it is in the terminal
noremap!  
" make Ctrl+Backspace delete a word backwards
noremap!  <C-w>

" >> UNMAPPINGS << "
map K <Nop>
map Q <Nop>

if &diff
	nmap <leader>u :diffupdate<CR>
endif

" PLUGINS
source ~/.vimplugins
