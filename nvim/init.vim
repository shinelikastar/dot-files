syntax on				"syntax highlighting
syntax enable			"use system color scheme

set mouse=a
set nowrap
set linebreak
set number				"show line number
set showmode			"show current mode down the bottom
set undolevels=1000		"undo levels

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

" set mapleader
let mapleader=","
let g:mapleader=","

" enable pretty highlighting on yank
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup END

" To install new plugins, run :PlugInstall
call plug#begin('~/.local/nvim/plugins')

" Editing
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 
Plug 'ggandor/lightspeed.nvim'        " successor to vim-sneak
Plug 'tpope/vim-surround'             " cs`' to change `` to '', etc
Plug 'tpope/vim-repeat'               " better . for plugins
Plug 'liuchengxu/vim-which-key'		  " display leader keys

" Colors
Plug 'bluz71/vim-nightfly-guicolors'

" Git
Plug 'airblade/vim-gitgutter'   " show changed line marks in gutter
Plug 'tpope/vim-fugitive'       " the git plugin
Plug 'tpope/vim-rhubarb'        " enable GHE/Github links with :Gbrowse

" Fuzzy finder
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Tmux
Plug 'christoomey/vim-tmux-navigator'  " makes ctrl+hjkl jump to Tmux panes and back
Plug 'melonmanchan/vim-tmux-resizer'   " lets you resize Vim windows with alt+hjkl

call plug#end()

" =============== Color scheme ==============

set termguicolors
colorscheme nightfly

" =============== FZF =======================

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_sink = 'e'

" floating window
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.5, 'highlight': 'Comment' } }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

function! g:FzfFilesSource()
  let l:source_command = "rg --files --hidden --glob '!{node_modules/*,.git/*}'"

  return l:source_command
endfunction

let g:fzf_preview_cmd = g:plug_home . "/fzf.vim/bin/preview.sh {}"

noremap <C-b> :Buffers<CR>
nnoremap <silent> <Leader>f :Rg<CR>

noremap <C-p> :call fzf#vim#files('', { 'source': g:FzfFilesSource(),
      \ 'options': [
      \   '--tiebreak=index', '--preview', g:fzf_preview_cmd
      \  ]})<CR><CR>

" =============== Tmux =========================

" set our shell to be bash for fast tmux switching times
" see: https://github.com/christoomey/vim-tmux-navigator/issues/72
set shell=/bin/bash\ --norc\ -i

let g:tmux_resizer_no_mappings = 0

" Fix :Gbrowse, etc in fugitive
let g:github_enterprise_urls = ['https://git.corp.stripe.com']

" =============== version control ================

vnoremap <leader>g :GBrowse!<CR>

" ================== treesitter =================

lua <<LUA
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'bash',
    'css',
    'go',
    'graphql',
    'javascript',
    'json',
    'lua',
    'nix',
    'php',
    'python',
    'ruby',
    'tsx',
    'typescript',
    'yaml',
  },
  highlight = { enable = true },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
}
LUA

" ================ lightspeed =================
lua <<LUA
require('lightspeed').setup({
  jump_on_partial_input_safety_timeout = 400,
  highlight_unique_chars = false,
  grey_out_search_area = true,
  match_only_the_start_of_same_char_seqs = true,
  limit_ft_matches = 5,
})
LUA

nmap s <Plug>Lightspeed_s
