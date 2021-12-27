syntax on			"syntax highlighting
syntax enable			"use system color scheme

set mouse=a
set nowrap
set linebreak
set number			"show line number
set showmode                    "show current mode down the bottom
set undolevels=1000             "undo levels

" Indentation
set autoindent 			"copy indent from current line when starting a new line
set tabstop=4 			"number of space on a <Tab> character
set shiftwidth=4		"let indent correspond to a single Tab
set softtabstop=4		"inserts combo of space and tab to simulate tabstop
set smarttab

"stash yanked area into OSX clipboard
set clipboard=unnamed

"enable Y yank to end of line
nnoremap Y y$

"remap ESC to jk
inoremap jk <Esc>

"reload file if it changes on disk
set autoread

"enable pretty highlighting on yank
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup END


