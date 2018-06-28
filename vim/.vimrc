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

" don't recognize octal number formats for C-A/X (tracknumbers mess this up)
set nrformats-=octal

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

" move cursor to current match while searching
set incsearch nohlsearch
augroup vimrc-incsearch-highlight
  autocmd!
  autocmd CmdlineEnter /,\? :set hlsearch | :cmap <Tab> <C-g>| :cmap <S-Tab> <C-t>
  autocmd CmdlineLeave /,\? :set nohlsearch | :cunmap <Tab>| :cunmap <S-Tab>
augroup END

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

" use builtin syntax-based omnicomplete by default
set omnifunc=syntaxcomplete#Complete
" except for in java cuz it sucks hardcore
autocmd FileType java setlocal omnifunc=

" don't go to first column with gg or G (good for visual-block)
set nostartofline

" use ripgrep instead of grep/ack/ag
if executable('rg')
  set grepprg=rg\ --vimgrep\ --color=always
endif

" match parens inside double quotes
set cpoptions+=%

" smarter joining inside comments
if v:version > 703 || v:version == 703 && has('patch541')
  set formatoptions+=j
endif

" don't redraw the screen after each macro step
set lazyredraw

"-------------"
"   AUTOCMDS  "
"-------------"

" settings for markdown
autocmd FileType markdown setlocal spell

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

augroup filetype_help
    autocmd!
    autocmd BufWinEnter * if &l:buftype ==# 'help' | wincmd _ | nmap <buffer> q :q<CR> | endif
augroup END

"-------------------------------"
"   MAPPINGS/ALIASES/COMMANDS   "
"-------------------------------"

let mapleader=" "
let maplocalleader="<return>"

" easier access to command mode
nmap <return> :

" typos
command! Q q
command! W w
" easier reading/writing/quitting
nmap <leader>e :e 
nmap <leader>E :e!<CR>
nmap <leader>w :w<CR>
nmap <leader>W :w!
nmap <leader>Q :q!<CR>
nmap <Space><Space> :w<CR>
nnoremap <Space><Space> <Esc><Space><Space>
imap <Space><Space> <Esc><Space><Space>

" write as root
command! Wroot w !sudo tee > /dev/null %

" switch between buffers
nnoremap <BS> <C-^>

" >> MISC LEADER KEY MAPPINGS << "
" ----
" reload vimrc inside vim
nnoremap <leader>r :so $MYVIMRC<CR>
" redraw screen
nnoremap <leader>l :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>
" easier access to tilde operator
nnoremap <leader>~ g~

cabbr %% <C-R>=expand('%:p:h')<CR>

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
" make n and N always go the same direction
" also center matches vertically
nnoremap <expr> n  'Nn'[v:searchforward] . 'zz'
nnoremap <expr> N  'nN'[v:searchforward] . 'zz'

" >> NORMAL MODE COMMANDS << "
" ----
" make Y work like it should
nnoremap Y y$
" use U instead of Ctrl+R for redo
nnoremap U <C-R>
" " make cb and db work like they ought to (i.e. make them delete the character under the cursor)
" noremap cb vbc
" noremap db vbd
" copy whole line without newline
nnoremap yY my0y$`y
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
nmap <leader>d "_d
nmap <leader>D "_D
nmap <leader>c "_c
nmap <leader>C "_C
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
nnoremap Q <Nop>
nnoremap <return> <Nop>

" PLUGINS
source ~/.vimplugins
