vim.cmd([[
	let g:ackprg = 'rg --vimgrep --no-heading'

	cnoreabbrev Ack Ack!

	nnoremap <Leader>a :Ack!<Space>
	nnoremap <Leader>A :Ack!<CR>
]])
