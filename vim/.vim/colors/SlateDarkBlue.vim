"%% SiSU Vim color file
" MODIFIED BY DYLAN FORBES
" SlateDark Maintainer: Rudra Banerjee <bnrj.rudra@yahoo.com>
" Originally inspired from Slate by Ralph Amissah
set background=dark
highlight clear
if version > 580
	hi clear
	if exists("syntax_on")
		syntax reset
	endif
endif

let colors_name = "SlateDarkBlue"

" ----------------------- "
" LANGUAGE-SPECIFIC FORMS "
" ----------------------- "

hi Comment ctermfg=11

hi Constant ctermfg=4
hi String ctermfg=darkcyan
" Character
" Number
" Boolean
" Float

" Identifier - any variable name
hi Identifier ctermfg=5
hi Function ctermfg=4

" Statement - any statement
hi Statement ctermfg=lightblue
" Conditional - if, then, else, endif, switch, etc.
" Repeat - for, do, while, etc
" Label - case, default, etc.
" Operator - sizeof, +, *, etc. (Python: in, is)
" Exception - try, catch, throw, raise
" Keyword  - any other keyword

" PreProc - generic Preprocessor
hi PreProc ctermfg=green
" Include - preprocessor #include
hi Include ctermfg=red
" Define - preprocessor #define
hi Define ctermfg=yellow
" Macro - (same as Define)
" PreCondit - preprocessor #if, #else, #endif, etc.

" Type - int, long, char, etc.
hi Type ctermfg=2 
" StorageClass - static, register, volatile, etc.
" Structure - struct, union, enum, etc.
hi Structure ctermfg=green
" Typedef - A typedef

" Special - any special symbol
hi Special ctermfg=4
" SpecialChar - special character in a constant
" Tag -	you can use CTRL-] on this
" Delimiter - character that needs attention
" SpecialComment - special things inside a comment
" Debug - debugging statements

" Error	- any erroneous construct
hi Error cterm=bold ctermfg=7 ctermbg=1
" Ignore - left blank, hidden  |hl-Ignore|
hi Ignore cterm=bold ctermfg=7
" Todo - anything that needs extra attention; mostly the keywords TODO FIXME XXX
hi Todo term=standout ctermfg=0 ctermbg=11
" Underlined - text that stands out, HTML links
hi Underlined cterm=underline ctermfg=5

"-----------------"
" VIM UI ELEMENTS "
"-----------------"

" ColorColumn - used for the columns set with 'colorcolumn'
" Conceal - placeholder characters substituted for concealed text (see 'conceallevel')
" Cursor - the character under the cursor
" CursorIM - like Cursor, but used when in IME mode |CursorIM|
" CursorColumn - the screen column that the cursor is in when 'cursorcolumn' is set
" CursorLine - the screen line that the cursor is in when 'cursorline' is set
" Directory - directory names (and other special names in listings)
hi Directory ctermfg=darkcyan

" DIFF STUFF "

" DiffAdd - diff mode: Added line |diff.txt|
hi DiffAdd ctermbg=0 cterm=none
" DiffAdded - (seems to be actually used)
hi DiffAdded ctermbg=0 ctermfg=2 cterm=none
" DiffChange - diff mode: Changed line |diff.txt|
hi DiffChange ctermfg=none ctermbg=none
" DiffText - diff mode: Changed text within a changed line |diff.txt|
hi DiffText ctermfg=darkblue ctermbg=0
" DiffDelete - diff mode: Deleted line |diff.txt|
hi DiffDelete ctermfg=1 ctermbg=0
" DiffRemoved - (seems to be actually used)
hi DiffRemoved ctermfg=1 ctermbg=0

" OTHER "

" EndOfBuffer - filler lines (~) after the last line in the buffer.  By default, this is highlighted like |hl-NonText|.
" ErrorMsg - error messages on the command line
hi ErrorMsg cterm=bold cterm=bold ctermfg=7 ctermbg=1
" VertSplit - the column separating vertically split windows
hi VertSplit cterm=reverse
" Folded - line used for closed folds
hi Folded ctermfg=grey ctermbg=darkgrey
" FoldColumn - 'foldcolumn'
hi FoldColumn ctermfg=4 ctermbg=7
" SignColumn - column where |signs| are displayed
" IncSearch - 'incsearch' highlighting; also used for the text replaced with ;:s///c'
hi IncSearch cterm=none ctermfg=yellow ctermbg=green
" LineNr - Line number for ':number' and ':#' commands, and when 'number' or 'relativenumber' option is set.
hi LineNr ctermfg=3
" CursorLineNr - Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
" MatchParen - The character under the cursor or just before it, if it is a paired bracket, and its match.
hi MatchParen term=reverse ctermbg=0
" ModeMsg - 'showmode' message (e.g., '-- INSERT --')
hi ModeMsg cterm=none ctermfg=4
" MoreMsg - |more-prompt|
hi MoreMsg ctermfg=darkgreen
" NonText - '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., '>' displayed when a double-wide character doesn't fit at the end of the line).
hi NonText cterm=bold ctermfg=blue
" Normal - normal text
" Pmenu - Popup menu: normal item.
" PmenuSel - Popup menu: selected item.
" PmenuSbar - Popup menu: scrollbar.
" PmenuThumb - Popup menu: Thumb of the scrollbar.
" Question - |hit-enter| prompt and yes/no questions
hi Question ctermfg=green
" Search - Last search pattern highlighting (see 'hlsearch').  Also used for highlighting the current line in the quickfix window and similar items that need to stand out
hi Search cterm=none ctermfg=black ctermbg=blue
" SpecialKey - Meta and special keys listed with ':map', also for text used to show unprintable characters in the text, 'listchars'.  Generally: text that is displayed differently from what it really is.
hi SpecialKey ctermfg=darkgreen
" SpellBad - Word that is not recognized by the spellchecker. |spell| This will be combined with the highlighting used otherwise.
" SpellCap - Word that should start with a capital. |spell| This will be combined with the highlighting used otherwise.
" SpellLocal - Word that is recognized by the spellchecker as one that is used in another region. |spell| This will be combined with the highlighting used otherwise.
" SpellRare - Word that is recognized by the spellchecker as one that is hardly ever used. |spell| This will be combined with the highlighting used otherwise.
" SpellErrors - ??? (not in help)
hi SpellErrors cterm=bold ctermfg=7 ctermbg=1,bold
" StatusLine - status line of current window
hi StatusLine cterm=bold,reverse
" StatusLineNC - status lines of not-current windows Note: if this is equal to 'StatusLine' Vim will use '^^^' in the status line of the current window.
hi StatusLineNC cterm=reverse
" TabLine - tab pages line, not active tab page label
" TabLineFill - tab pages line, where there are no labels
" TabLineSel - tab pages line, active tab page label
" Title - titles for output from ':set all', ':autocmd' etc.
hi Title cterm=bold ctermfg=yellow
" Visual - Visual mode selection
hi Visual cterm=reverse
" VisualNOS - Visual mode selection when vim is 'Not Owning the Selection'.  Only X11 Gui's |gui-x11| and |xterm-clipboard| supports this.
hi VisualNOS cterm=bold,underline
" WarningMsg - warning messages
hi WarningMsg ctermfg=1
" WildMenu - current match in 'wildmenu' completion
hi WildMenu ctermfg=0 ctermbg=3
" Menu - Current font, background and foreground colors of the menus. Also used for the toolbar. Applicable highlight arguments: font, guibg, guifg.
" Scrollbar - Current background and foreground of the main window's scrollbars. Applicable highlight arguments: guibg, guifg.
" Tooltip - Current font, background and foreground of the tooltips.  Applicable highlight arguments: font, guibg, guifg.
