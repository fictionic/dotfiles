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

" enable escape keys, because why not
" (no more delay with <A-S-O> cuz ttimeoutlen=0)
set esckeys

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
" use hard tabs by default
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

" tab brings up suggestions menu in command mode
set wildmenu
" first tab press expands command to longest possible name,
" remaining tab presses cycle through completions in the wildmenu
set wildmode=longest,full
" ignore non-text files in filename completion
set wildignore+=*.a,*.o
set wildignore+=*.class,*.jar,*.pyc
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

" don't spellcheck by default
set nospell
" wrap text
set wrap

" smart case-sensitivity in regex searches
set ignorecase
set smartcase
" but not when doing completion
au InsertEnter * set noignorecase
au InsertLeave * set ignorecase
" and not for * or # commands
nnoremap <silent>  * :let @/='\C\<' . expand('<cword>') . '\>'<CR>:let v:searchforward=1<CR>n
nnoremap <silent>  # :let @/='\C\<' . expand('<cword>') . '\>'<CR>:let v:searchforward=0<CR>n
nnoremap <silent> g* :let @/='\C'   . expand('<cword>')       <CR>:let v:searchforward=1<CR>n
nnoremap <silent> g# :let @/='\C'   . expand('<cword>')       <CR>:let v:searchforward=0<CR>n

" timeout for mappings
set timeoutlen=500
" timeout for keycodes
set ttimeoutlen=0

" use omnicomplete
set omnifunc=syntaxcomplete#Complete

" don't go to first column with gg or G (good for visual-block)
set nostartofline

" use ripgrep instead of grep/ack/ag
if executable('rg')
  set grepprg=rg\ --vimgrep
endif

"-------------"
"   AUTOCMDS  "
"-------------"

" settings for markdown
autocmd FileType markdown setlocal spell nowrap
autocmd BufRead,BufNewFile *.md setlocal spell nowrap

" use spaces in python, and keep indentation level
autocmd FileType python set expandtab autoindent
" use autopep8 as equalprg for python
if executable('autopep8')
  fun! SetEqualPrg()
      if &ft =~ 'python'
        set equalprg=autopep8\ -
      else
        set equalprg=
      endif
  endfun
  autocmd FileType * call SetEqualPrg()
endif

"-------------------------------"
"   MAPPINGS/ALIASES/COMMANDS   "
"-------------------------------"

let mapleader=" "
let maplocalleader="<Enter>"

" easier access to command mode
map <Space> :

" easier reading/writing/quitting
map <leader>e :e 
map <leader>E :e!<CR>
map <leader>w :w<CR>
map <leader>W :w!
"map <leader>q :q<CR>
map <leader>bd :bd<CR>
map <leader>Q :q!<CR>
map <Space><Space> :w<CR>
noremap <Space><Space> <Esc><Space><Space>
map! <Space><Space> <Esc><Space><Space>
imap <Space><Space> <Esc><Space><Space>

" reload vimrc inside vim
nnoremap <leader>r :so $MYVIMRC<CR>

" switch between buffers
nnoremap <BS> <C-^>

" >> LEADER KEY MAPPINGS << "
" ----
" remove search highlighting and remove any cmdline messages
map <silent> <leader>l :nohl<CR>
" create new line above/below without entering insert mode
"nnoremap <leader>o o<Esc>
"nnoremap <leader>O O<Esc>
" generate tags file
map <leader>c :!ctags -R<CR>
" easier access to tilde operator
nnoremap <leader>~ g~
" update diff
if &diff
  nmap <leader>u :diffupdate<CR>
endif


" >> MOTIONS << "
" ----
" remap _ to ^, since ^ is hard to reach and the default action of _ is dumb
noremap _ ^
" make end-of-paragraph motion line-wise in operator-pending mode and visual mode
onoremap } V}
vnoremap } V}
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
map <Enter> <Nop>

" PLUGINS
source ~/.vimplugins
