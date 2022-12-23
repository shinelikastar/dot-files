""""""""""""""""""""""""""""""""""""""""
" Settings
""""""""""""""""""""""""""""""""""""""""
syntax on					"syntax highlighting
syntax enable					"use system color scheme
set mouse=a
set nowrap					"don't wrap lines
set linebreak
set number					"show line number
set showmode					"show current mode down the bottom
set undolevels=1000				"undo levels
set scrolloff=8					"Start scrolling when we're 8 lines away from margins
set sidescrolloff=15				"min number of columns to keep to right of cursor
set sidescroll=1				"min number of columns to scroll horizontally:w
set timeoutlen=2000				"set leader timeout to be longer (default is 1000)
set colorcolumn=81				"mark the 81st character with a column
set textwidth=80				"set wrap to 80 characters

" Indentation
set autoindent					"copy indent from current line when starting a new line
set smartindent
set smarttab
set tabstop=2					"number of space on a <Tab> character
set shiftwidth=2				"let indent correspond to a single Tab
set softtabstop=2				"inserts combo of space and tab to simulate tabstop
set expandtab
set list listchars=tab:\ \ ,trail:·				"display trailing tabs and spaces

filetype plugin on
filetype indent on

"stash yanked area into OSX clipboard
set clipboard=unnamed

""""""""""""""""""""""""""""""""""""""""
" Custom mappings
""""""""""""""""""""""""""""""""""""""""
"enable Y yank to end of line
nnoremap Y y$

"allow ctrl+z backgrounding in of insert mode
inoremap <C-Z> <Esc><C-Z>

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

"reload file if it changes on disk
set autoread

" set mapleader
let mapleader=";"
let g:mapleader=";"

" enable pretty highlighting on yank
augroup highlight_yank
	autocmd!
	au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup END

"turn off swap files
set noswapfile
set nobackup
set nowb

" Keep undo history across sessions, by storing in file.
if has('persistent_undo')
  set undodir=~/.vim/backups
  set undofile
endif

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
Plug 'ggandor/lightspeed.nvim'		" successor to vim-sneak
Plug 'tpope/vim-surround'		" cs`' to change `` to '', etc
Plug 'tpope/vim-repeat'			" better . for plugins
Plug 'liuchengxu/vim-which-key'		" display leader keys
Plug 'tpope/vim-commentary'		" comment with `gcc`, uncomment with `gcgc`
Plug 'kshenoy/vim-signature'		" show marks in the gutter
Plug 'p00f/nvim-ts-rainbow'		" show parentheses pairs with different colors
Plug 'windwp/nvim-ts-autotag'		" autoclose HTML tags
Plug 'andymass/vim-matchup'		" extended matchers for %
Plug 'nvim-lua/plenary.nvim'		" async support

" Fuzzy finder + grep
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'			" grepping through files
Plug 'ibhagwan/fzf-lua', {'branch': 'main'}

" File finder
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim'

" Git
Plug 'airblade/vim-gitgutter'		" show changed line marks in gutter
Plug 'tpope/vim-fugitive'		" the git plugin
Plug 'tpope/vim-rhubarb'		" enable GHE/Github links with :Gbrowse
Plug 'rhysd/git-messenger.vim'	"look at git commits inline

" Javascript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

" Markdown
Plug 'npxbr/glow.nvim', {'do': ':GlowInstall'}	" markdown preview with :Glow

" Status bar
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'	" display icons

" Syntax checking
Plug 'lukas-reineke/lsp-format.nvim'	" LSP format on save, with multiple sequential LSPs + async
Plug 'jose-elias-alvarez/null-ls.nvim'	" LSP for formatting/diagnostics
Plug 'hrsh7th/cmp-nvim-lsp'		" hot autocomplete plugin
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'onsails/lspkind-nvim'		" add vscode-style icons to completion menu

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp-status.nvim'		" provides statusline information for LSP
Plug 'ray-x/lsp_signature.nvim'		" floating signature 'as you type'
Plug 'folke/trouble.nvim'
Plug 'j-hui/fidget.nvim'		" stand-alone status for nvim-lsp progress

" Snippets
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'SirVer/UltiSnips'
Plug 'lukas-reineke/cmp-under-comparator'

" Tests
Plug 'preservim/vimux'
Plug 'janko-m/vim-test'

" Tmux
Plug 'christoomey/vim-tmux-navigator'	" makes ctrl+hjkl jump to Tmux panes and back
Plug 'melonmanchan/vim-tmux-resizer'	" lets you resize Vim windows with alt+hjkl

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
lua require("fzf")

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
" trouble.vim
""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
nnoremap <leader>xr <cmd>TroubleRefresh<cr>
nnoremap gR <cmd>TroubleToggle lsp_references<cr>

command! -nargs=1 -complete=dir FixTSExpectError :lua require('stripe.ts-lint-expect-error').findTsExpectErrors(<f-args>)<CR>

""""""""""""""""""""""""""""""""""""""""
" Quickfix
""""""""""""""""""""""""""""""""""""""""
nnoremap <silent><space>la :CodeActionMenu<CR>

""""""""""""""""""""""""""""""""""""""""
" Tmux
""""""""""""""""""""""""""""""""""""""""
" set our shell to be bash for fast tmux switching times
" see: https://github.com/christoomey/vim-tmux-navigator/issues/72
set shell=/bin/bash\ --norc\ -i

let g:tmux_resizer_no_mappings = 0

""""""""""""""""""""""""""""""""""""""""
" Git
""""""""""""""""""""""""""""""""""""""""
" Fix :Gbrowse, etc in fugitive
let g:github_enterprise_urls = ['https://git.corp.stripe.com']

lua << END
	-- Every time you open a git object using fugitive it creates a new buffer.
	-- This means that your buffer listing can quickly become swamped with
	-- fugitive buffers. This prevents this from becomming an issue:
	vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
		pattern = { 'fugitive://*' },
		callback = function()
			vim.cmd([[set bufhidden=delete]])
		end,
	})
END

" get GHE link of selected lines
vnoremap <leader>g :GBrowse!<CR>

" Handy git shortcuts
nnoremap <silent><space>gm :GitMessenger<CR>
nnoremap <silent><space>gb :Git blame<CR>
nnoremap <silent><space>gs :Git status<CR>

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
		lualine_b = {{
			'filename',
			path = 0,
		}},
		lualine_c = {},
    lualine_x = {'diff'},
    lualine_y = {},
    lualine_z = {}
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
	highlight = { 
		enable = true 
	},
	incremental_selection = { 
		enable = true 
	},
	textobjects = { 
		enable = true 
	},

	-- Plugins
	rainbow = {
    enable = true,
  },
	matchup = {
    enable = true,
  },
}
LUA

""""""""""""""""""""""""""""""""""""""""
" lightspeed
""""""""""""""""""""""""""""""""""""""""
lua <<LUA
require('lightspeed').setup({
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
" LSP
""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <space>li  :LspInfo<CR>
nnoremap <silent> <space>ld  <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <space>lh  <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <space>lr  <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <space>ln  <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <space>lt  <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> <space>lw  <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> <space>lk  <cmd>lua vim.diagnostic.open_float({scope="line"})<CR>
nnoremap <silent> <space>lD  <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <space>l0  <cmd>lua vim.lsp.buf.document_symbol()<CR>

" 300ms before CursorHold events fire (like hover text on errors)
set updatetime=300

" gutter space for lsp info on left
set signcolumn=yes

""""""""""""""""""""""""""""""""""""""""
" diagnostics
""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> gj :lua vim.diagnostic.goto_next()<cr>
nnoremap <silent> gk :lua vim.diagnostic.goto_prev()<cr>

""""""""""""""""""""""""""""""""""""""""
" nvim-cmp
""""""""""""""""""""""""""""""""""""""""
set completeopt=menu,menuone,noselect

lua <<EOF
  local cmp = require'cmp'
	local lspkind = require('lspkind')
	local compare = require('cmp.config.compare')
	local cmp_buffer = require('cmp_buffer')

	local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	end

	local feedkey = function(key, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
	end

  cmp.setup({
		formatting = {
			format = lspkind.cmp_format({
				with_text = false, -- do not show text alongside icons
				maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

				-- The function below will be called before any actual modifications from lspkind
				-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
				before = function (entry, vim_item)
					return vim_item
				end
			})
		},
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
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
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif vim.fn["vsnip#available"](1) == 1 then
					feedkey("<Plug>(vsnip-expand-or-jump)", "")
				elseif has_words_before() then
					cmp.complete()
				else
					fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
				end
			end, { "i", "s" }),

			["<S-Tab>"] = cmp.mapping(function()
				if cmp.visible() then
					cmp.select_prev_item()
				elseif vim.fn["vsnip#jumpable"](-1) == 1 then
					feedkey("<Plug>(vsnip-jump-prev)", "")
				end
			end, { "i", "s" }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
    }, {
			{
				name = 'buffer',
				option = {
					-- Complete from all visible buffers.
					get_bufnrs = function()
						return vim.api.nvim_list_bufs()
					end
				},
			},
    }),
	  sorting = {
    comparators = {
      -- Sort by distance of the word from the cursor
      -- https://github.com/hrsh7th/cmp-buffer#locality-bonus-comparator-distance-based-sorting
      function(...)
        return cmp_buffer:compare_locality(...)
      end,
      compare.offset,
      compare.exact,
      compare.score,
      require("cmp-under-comparator").under,
      compare.recently_used,
      compare.locality,
      compare.kind,
      compare.sort_text,
      compare.length,
      compare.order,
    },
  },
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

	local lspconfig = require('lspconfig')
	local lsp_status = require('lsp-status')
	local null_ls = require("null-ls")
	local lsp_format = require("lsp-format")
	local trouble = require("trouble")
	local cmp_nvim_lsp = require('cmp_nvim_lsp')

  -- Setup lspconfig.
  local lspCapabilities = require('cmp_nvim_lsp').default_capabilities(
		vim.lsp.protocol.make_client_capabilities()
	)

	trouble.setup({
		use_diagnostic_signs = true,
	})

	lsp_format.setup()

	local on_attach = function(client, bufnr)
	  lsp_format.on_attach(client, bufnr)

		-- Floating window signature
		require('lsp_signature').on_attach({
			debug = false,
			handler_opts = {
				border = "single",
			},
		})
	end

	-- null ls
	local ignorePrettierRules = function(diagnostic)
		return diagnostic.code ~= "prettier/prettier"
	end

	local hasEslintConfig = function(utils)
		return utils.root_has_file({
			".eslintrc",
			".eslintrc.json",
			".eslintrc.js"
		})
	end

	local hasPrettierConfig = function(utils)
		return utils.root_has_file({
			".prettierrc",
			".prettierrc.json",
			".prettierrc.js",
			".prettierrc.toml",
			".prettierrc.yml",
			".prettierrc.yaml",
		})
	end

	local eslintConfig = {
		condition = hasEslintConfig,
		filter = ignorePrettierRules,
	}

	null_ls.setup({
		-- For :NullLsLog support
		debug = false,
		on_attach = on_attach,
		capabilities = lspCapabilities,
		root_dir = require("null-ls.utils").root_pattern(
			".git",
			"Gemfile.lock",
			"package.json"
		),
		sources = {
			-- lua
			null_ls.builtins.formatting.stylua,

			-- ruby
			null_ls.builtins.diagnostics.rubocop.with({
				command = "scripts/bin/rubocop-daemon/rubocop",
				timeout = 30000,
				ignore_stderr = true,
			}),

			-- typescript
			null_ls.builtins.formatting.prettier.with({
				condition = hasPrettierConfig,
				-- Always use the local prettier, especially when prettier is pointing
				-- at a feature branch or something weird.
				only_local = "node_modules/.bin",
			}),

			null_ls.builtins.code_actions.eslint.with(eslintConfig),
			null_ls.builtins.diagnostics.eslint.with(eslintConfig),
			null_ls.builtins.formatting.eslint.with(eslintConfig),
		}
	})

	lspconfig.util.default_config = vim.tbl_extend(
		"force",
		lspconfig.util.default_config,
		{
			capabilities = lsp_status.capabilities,
			on_attach = on_attach,
		}
	)

	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
		vim.lsp.diagnostic.on_publish_diagnostics, {
			underline = false,
			virtual_text = {
				spacing = 4,
				format = function(diagnostic)
					-- Only show the first line with virtualtext.
					return string.gsub(diagnostic.message, '\n.*', '')
				end,
			},
			signs = true,
			update_in_insert = false,
		}
	)

	vim.cmd([[
		highlight FidgetTitle ctermfg=110 guifg=#6cb6eb
	]])

	-- Standalone UI for nvim-lsp progress
	require('fidget').setup({
		sources = {
			["null-ls"] = {
				ignore = true,
			},
		},
		timer = {
			task_decay = 400,
			fidget_decay = 700,
		},
	})

	lspconfig.tsserver.setup({
		capabilities = lspCapabilities,
		cmd_env = { NODE_OPTIONS = "--max-old-space-size=8192" }, -- Give 8gb of RAM to node
		filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
		init_options = {
			maxTsServerMemory = "8192",
			preferences = {
				-- Ensure we always import from absolute paths
				importModuleSpecifierPreference = "non-relative",
			},
		},
		root_dir = lspconfig.util.root_pattern("tsconfig.json"),
		on_attach = function(client, bufnr)
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false

			if client.config.flags then
				client.config.flags.allow_incremental_sync = true
			end

			on_attach(client, bufnr)
		end
	})

	lspconfig.sorbet.setup({
		capabilities = lspCapabilities,
		init_options = {
      supportsOperationNotifications = true,
    },
		cmd = {
			"scripts/dev_productivity/while_pay_up_connected.sh",
			"pay",
			"exec",
			"scripts/bin/typecheck",
			"--lsp",
			"--enable-all-experimental-lsp-features",
			-- "--enable-experimental-lsp-document-formatting-rubyfmt",
		},
		root_dir = lspconfig.util.root_pattern("sorbet", ".git"),
		settings = {},
	})

  -- Templated off of https://github.com/sorbet/sorbet/blob/23836cbded86135219da1b204d79675a1615cc49/vscode_extension/src/SorbetStatusBarEntry.ts#L119
  vim.lsp.handlers["sorbet/showOperation"] = function(err, result, context, config)
    if err ~= nil then
      error(err)
      return
    end
    local message = {
      token = result.operationName,
      value = {
        kind = result.status == "end" and "end" or "begin",
        title = result.description,
      },
    }
    vim.lsp.handlers["$/progress"](err, message, context, config)
  end
EOF

" ============== File browser =================
"
let g:vimfiler_force_overwrite_statusline = 0
let g:vimfiler_as_default_explorer = 1
let g:vimshell_force_overwrite_statusline = 0

call vimfiler#custom#profile('default', 'context', {
			\ 'safe': 0
			\ })

" bind the minus key to show the file explorer in the dir of the current open
" buffer's file
nnoremap - :VimFilerBufferDir<CR>

""""""""""""""""""""""""""""""""""""""""
" which-key
""""""""""""""""""""""""""""""""""""""""
lua require("which-key")

""""""""""""""""""""""""""""""""""""""""
" Private config
""""""""""""""""""""""""""""""""""""""""

" Load Stripe-specific private config
call SourceIfExists('~/.dot-files-overlay/nvim/config.vim')
