"" Nate Levesque
""

"" Enable syntax highlighting
syntax on

"" Enable relative line numbers
set relativenumber

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
