"-------------"
"   OPTIONS   "
"-------------"

" turn on filetype recognition in general, and for plugins, and for indent style
filetype plugin indent on
" don't use any other indentation utilities by default
set nocindent noautoindent nosmartindent

" enable syntax highlighting
syntax on

" color scheme: my own custom modification of SlateDark
colorscheme SlateDarkBlue

" disable swap files
set noswapfile

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

" unnamed register is X clipboard
set clipboard=unnamedplus

" remember undo tree after closing file
set undofile
set undodir=~/.vim/undo

" smart case-sensitivity in regex searches
set smartcase

" timeout for mappings
set timeoutlen=500

"-------------"
"   AUTOCMDS  "
"-------------"

" automatically reload vimrc whenever it's changed
au! BufWritePost .vimrc source %

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
map <leader>q :q<CR>
map <leader>Q :q!<CR>
map <Space><Space> :w<CR>
noremap <Space><Space> <Esc><Space><Space>
map! <Space><Space> <Esc><Space><Space>
imap <Space><Space> <Esc><Space><Space>

" reload vimrc inside vim
nnoremap <leader>r :so $MYVIMRC<CR>

" remove search highlighting when exiting command mode
" cnoremap <silent> <CR> <CR>:nohlsearch<CR>

" open multiple files in tabs, horizontal windows, or vertical windows
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

" switch between tabs
noremap <leader><Tab> gt
noremap <leader><S-Tab> gT
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
" make cb and db work like they ought to (i.e. make them delete the character under the cursor)
" noremap cb vbc
" noremap db vbd
" clear a single line remaining in normal mode
nnoremap dD 0D
" make <Enter><Enter> split a line at the cursor
nnoremap <CR><CR> i<CR><ESC>
" indent current line multiple times, rather then <C-Del>
noremap <silent><< @='<<'<CR>
noremap <silent>>> @='>>'<CR>
" use verymagic searching by default
nnoremap / /\v
vnoremap / /\v
nnoremap :g/ :g/\v
nnoremap :g// :g//
" easy access to "0 register when pasting
nnoremap <leader>p "0p
nnoremap <leader>P "0P
" easy access to "_ register when deleting/cutting
map <leader>d "_d
nnoremap <leader>D "_D
map <leader>c "_c
nnoremap <leader>C "_C
" don't save deleted text when using s or S
nnoremap s "_s
nnoremap S "_S

" >> BACKSPACE/DELETE STUFF << "
" ----
" map  to backspace, like it is in the terminal
noremap!  
" make Ctrl+Backspace delete a word backwards
noremap!  <C-w>
" make Ctrl+Delete delete a word forwards in all modes
map! [3;5~ <Esc>cw

" >> UNMAPPINGS << "
map K <Nop>
map Q <Nop>

"-------------"
"   PLUGINS   "
"-------------"

" add package 'matchit' -- enhanced % behavior
packadd! matchit

call plug#begin()

Plug 'junegunn/vim-plug'
" commands / operators
Plug 'godlygeek/tabular' " provides :Tabularize command
	" Plug 'tpope/vim-commentary' " adds comment/uncomment operator (gc)
Plug 'justinmk/vim-sneak' " adds 'sneak' motion: like f, but with two characters
Plug 'tomtom/tcomment_vim' " comment operators (more powerful than tpope/commentary, I think)
Plug 'tpope/vim-surround' " easily deal with delimiters 
"Plug 'tpope/vim-unimpaired' " many pairs of operators/commands (need to look this one up more first)
" motions
Plug 'justinmk/vim-ipmotion' " improves { and } motions
" text objects
Plug 'wellle/targets.vim' " adds tons of text objects
Plug 'kana/vim-textobj-user' " plugin to allow one to create custom text objects
Plug 'kana/vim-textobj-entire' " adds 'entire file' text objects (ae and ie)
Plug 'kana/vim-textobj-indent' " adds text object for lines with matching indent (ii and ai)
Plug 'glts/vim-textobj-comment' " adds comment text objects (ac and ic)
Plug 'reedes/vim-textobj-sentence' " improved sentence detection (also comes with motions)
Plug 'rbonvall/vim-textobj-latex' " text objects for latex
	" TODO: make it so these mappings aren't overwriten by targets/vimtex when latex is detected
" misc
"Plug 'tpope/vim-sensible' " sensible defaults
Plug 'tpope/vim-repeat' " let supported plugins use .
Plug 'flazz/vim-colorschemes'
Plug 'lervag/vimtex' " for latex
Plug 'editorconfig/editorconfig-vim' " editorconfig
"Plug 'hynek/vim-python-pep8-indent' " python indentation
Plug 'tpope/vim-fugitive' " TIM POPE'S GIT PLUGIN
Plug 'google/vim-searchindex' " display index of search result using / or ?
Plug 'ciaranm/detectindent' " intelligently detect indentation settings
Plug 'mileszs/ack.vim' " for ack/ag ... doesn't work??
Plug 'ervandew/supertab' " insert mode tab completion

call plug#end()

" >> PLUGIN-RELATED SETTINGS << "
" targets.vim
omap iq i"
omap aq a"
omap inq in"
omap anq an"
omap ilq il"
omap alq al"
" vimtex
" vim-sneak
nmap <leader>s <Plug>Sneak_s
xmap <leader>s <Plug>Sneak_s
omap <leader>s <Plug>Sneak_s
nmap <leader>S <Plug>Sneak_S
xmap <leader>S <Plug>Sneak_S
omap <leader>S <Plug>Sneak_S
" vim-textobj-indent
omap Ai aI
vmap Ai aI
omap Ii iI
vmap Ii iI
