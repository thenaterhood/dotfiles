"" Nate Levesque
""
set laststatus=1
colorscheme desert

"" Wrap the cursor at the end of lines
set whichwrap+=<,>,h,l,[,]

"Remember cursor location in files
if has("autocmd")
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
	\| exe "normal! g'\"" | endif
endif

"" Enable code completion
filetype plugin on
set omnifunc=syntaxcomplete#Complete

"" Highlight search results
set hlsearch

"" Start searching right when you start typing, no
"" need to hit enter
set incsearch

"" Keep some space between the cursor
"" and the top/bottom of the screen
set scrolloff=5

"" Enable syntax highlighting
syntax on

"" Put a warning line at 80 chars
set colorcolumn=80
highlight ColorColumn ctermbg=6

"" Enable relative line numbers
""set relativenumber

"" Enable absolute line numbers 
"" (with the option above, this shows
"" the 'real' line number on the line 
"" the cursor is on rather than 0.
set number

"" Enable mouse support
set mouse=a

"" Enable autoindenting
set autoindent
set smartindent
set expandtab
filetype indent plugin on

""" Backspace works intelligently
set backspace=indent,eol,start

"" Use the system clipboard
set clipboard=unnamedplus

"" Show a line across the row the cursor is on
set cursorline

"" Set backup, swap files
set backup
set swapfile
set writebackup

"" Set undofiles if vim has
"" support for it.
if exists('+undofile')
	set undofile
endif

"" Create the directory tree used by vim
"" if it doesn't already exist.
if !isdirectory(expand('$HOME/.cache'))
	call mkdir(expand('$HOME/.cache'), "p")
endif

if !isdirectory(expand('$HOME/.cache/vim'))
	call mkdir(expand('$HOME/.cache/vim'), "p")
endif

if !isdirectory(expand('$HOME/.cache/vim/undo', "p"))
	call mkdir(expand('$HOME/.cache/vim/undo'), "p")
endif

if !isdirectory(expand('$HOME/.cache/vim/backup', "p"))
	call mkdir(expand('$HOME/.cache/vim/backup'), "p")
endif

if !isdirectory(expand('$HOME/.cache/vim/swap', "p"))
	call mkdir(expand('$HOME/.cache/vim/swap'), "p")
endif

"" Nice whitespace characters in :set list
set listchars=eol:¬,tab:\|\ ,trail:~,extends:>,precedes:<,space:·
set list

"" Configure the vim file locations for the above files
if isdirectory(expand('$HOME/.cache/vim'))
	if &backupdir =~# '^\.,'
		set backupdir^=$HOME/.cache/vim/backup//
	endif

	if &directory =~# '^\.,'
		set directory^=$HOME/.cache/vim/swap//
	endif

	if exists('+undodir') && &undodir =~# '^\.\%(,\|$\)'
		set undodir^=$HOME/.cache/vim/undo//
	endif
endif

"" Highlight extra whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
