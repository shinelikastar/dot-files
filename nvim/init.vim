""""""""""""""""""""""""""""""""""""""""
" General Settings
""""""""""""""""""""""""""""""""""""""""
syntax on								"syntax highlighting
syntax enable						"use system color scheme
set mouse=a
set nowrap
set linebreak
set number							"show line number
set showmode						"show current mode down the bottom
set undolevels=1000			"undo levels
set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15		"min number of columns to keep to right of cursor 
set sidescroll=1				"min number of columns to scroll horizontally:w
set timeoutlen=2000			"set leader timeout to be longer (default is 1000)

" Indentation
set autoindent					"copy indent from current line when starting a new line
set tabstop=2						"number of space on a <Tab> character
set shiftwidth=2				"let indent correspond to a single Tab
set softtabstop=2				"inserts combo of space and tab to simulate tabstop
set smarttab

"stash yanked area into OSX clipboard
set clipboard=unnamed

""""""""""""""""""""""""""""""""""""""""
" Custom mappings
""""""""""""""""""""""""""""""""""""""""

"enable Y yank to end of line
nnoremap Y y$

"create window splits with vv and ss
nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s

"toggle highlight of searched terms with ctrl-C
nnoremap <nowait><silent> <C-c> :set hlsearch!<CR>

"remap ESC to jk
inoremap jk <Esc>

"close parens and quotes for me
inoremap { {}<Esc>ha
inoremap ( ()<Esc>ha
inoremap [ []<Esc>ha
inoremap " ""<Esc>ha
inoremap ' ''<Esc>ha
inoremap ` ``<Esc>ha

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

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" function to source a file if it exists
function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction

""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""

" To install new plugins, run :PlugInstall
call plug#begin('~/.local/nvim/plugins')

" Colors
Plug 'bluz71/vim-nightfly-guicolors'

" Editing
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 
Plug 'ggandor/lightspeed.nvim'        " successor to vim-sneak
Plug 'tpope/vim-surround'             " cs`' to change `` to '', etc
Plug 'tpope/vim-repeat'               " better . for plugins
Plug 'liuchengxu/vim-which-key'				" display leader keys
Plug 'tpope/vim-commentary'           " comment with `gcc`, uncomment with `gcgc`

" Fuzzy finder + grep
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'		" grepping through files

" Git
Plug 'airblade/vim-gitgutter'   " show changed line marks in gutter
Plug 'tpope/vim-fugitive'       " the git plugin
Plug 'tpope/vim-rhubarb'        " enable GHE/Github links with :Gbrowse

" Javascript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

" Markdown
Plug 'npxbr/glow.nvim', {'do': ':GlowInstall'}  " markdown preview with :Glow

" Status bar
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'		" display icons

" Syntax checking
Plug 'dense-analysis/ale'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'						" hot autocomplete plugin
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" Snippets
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

" Tests
Plug 'preservim/vimux'
Plug 'janko-m/vim-test'

" Tmux
Plug 'christoomey/vim-tmux-navigator'  " makes ctrl+hjkl jump to Tmux panes and back
Plug 'melonmanchan/vim-tmux-resizer'   " lets you resize Vim windows with alt+hjkl

" Load Stripe-specific private plugins
call SourceIfExists('~/.dot-files-overlay/nvim/plugins.vim')

call plug#end()


""""""""""""""""""""""""""""""""""""""""
" Colors
""""""""""""""""""""""""""""""""""""""""
set termguicolors
colorscheme nightfly

" underline matching parens
let g:nightflyUnderlineMatchParen = 1

""""""""""""""""""""""""""""""""""""""""
" FZF
""""""""""""""""""""""""""""""""""""""""

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

""""""""""""""""""""""""""""""""""""""""
" vim-test
""""""""""""""""""""""""""""""""""""""""
nmap <silent> <leader>T :TestNearest<CR>
nmap <silent> <leader>t :TestFile<CR>

let g:test#preserve_screen = 1
let test#neovim#term_position = "vert"
let test#vim#term_position = "vert"

let g:test#javascript#mocha#file_pattern = '\v.*_test\.(js|jsx|ts|tsx)$'

if exists('$TMUX')
  " Use tmux to kick off tests if we are in tmux currently
  let test#strategy = 'vimux'
else
  " Fallback to using terminal split
  let test#strategy = "neovim"
endif

let test#enabled_runners = ["lua#busted", "ruby#rspec"]

let test#custom_runners = {}
let test#custom_runners['ruby'] = ['rspec']
let test#custom_runners['lua'] = ['busted']

""""""""""""""""""""""""""""""""""""""""
" Tmux
""""""""""""""""""""""""""""""""""""""""

" set our shell to be bash for fast tmux switching times
" see: https://github.com/christoomey/vim-tmux-navigator/issues/72
set shell=/bin/bash\ --norc\ -i

let g:tmux_resizer_no_mappings = 0

" Fix :Gbrowse, etc in fugitive
let g:github_enterprise_urls = ['https://git.corp.stripe.com']

""""""""""""""""""""""""""""""""""""""""
" Git
""""""""""""""""""""""""""""""""""""""""

" get GHE link of selected lines
vnoremap <leader>g :GBrowse!<CR>

""""""""""""""""""""""""""""""""""""""""
" Lualine
""""""""""""""""""""""""""""""""""""""""
lua << END
require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'material',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
		lualine_a = {'mode'},
		lualine_b = {
			{
				'tabs',
				max_length = vim.o.columns / 3, -- maximum width of tabs component
																				-- can also be a function that returns value of max_length dynamicaly
				mode = 2, -- 0  shows tab_nr
									-- 1  shows tab_name
									-- 2  shows tab_nr + tab_name
				tabs_color = {
					active = 'lualine_{section}_normal',   -- color for active tab
					inactive = 'lualine_{section}_inactive', -- color for inactive tab
				},
			}
		},
    lualine_c = {'branch', 'diff', 'diagnostics'},
    lualine_d = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
END

""""""""""""""""""""""""""""""""""""""""
" treesitter
""""""""""""""""""""""""""""""""""""""""
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

""""""""""""""""""""""""""""""""""""""""
" lightspeed
""""""""""""""""""""""""""""""""""""""""
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

""""""""""""""""""""""""""""""""""""""""
" ripgrep
""""""""""""""""""""""""""""""""""""""""
let g:ackprg = 'rg --vimgrep --no-heading'

cnoreabbrev Ack Ack!

nnoremap <Leader>a :Ack!<Space>
nnoremap <Leader>A :Ack!<CR>

""""""""""""""""""""""""""""""""""""""""
" ALE
""""""""""""""""""""""""""""""""""""""""

" ALE config
let g:ale_sign_error = '●'
let g:ale_sign_warning = '▲'

" automatically lint and fix on save
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1

" only run the linters we specify
let g:ale_linters_explicit = 1

let g:ale_linters = {
\ 'javascript': ['eslint'],
\ 'javascript.jsx': ['eslint'],
\ 'typescript': ['eslint'],
\ 'typescript.tsx': ['eslint'],
\ 'ruby': ['rubocop'],
\}

let g:ale_fixers = {
\ 'javascript': ['prettier', 'eslint'],
\ 'javascript.jsx': ['prettier', 'eslint'],
\ 'typescript': ['eslint'],
\ 'typescript.tsx': ['eslint'],
\ 'ruby': ['rubocop'],
\}

nnoremap <silent> gj :ALENext<cr>
nnoremap <silent> gk :ALEPrevious<cr>

""""""""""""""""""""""""""""""""""""""""
" nvim-cmp
""""""""""""""""""""""""""""""""""""""""
set completeopt=menu,menuone,noselect

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  -- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
    --capabilities = capabilities
  -- }
EOF

""""""""""""""""""""""""""""""""""""""""
" Private config
""""""""""""""""""""""""""""""""""""""""

" Load Stripe-specific private config
call SourceIfExists('~/.dot-files-overlay/nvim/config.vim')

