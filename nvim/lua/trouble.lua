vim.cmd([[
	nnoremap <leader>xx <cmd>TroubleToggle<cr>
	nnoremap <leader>xw <cmd>TroubleToggle workspace_diagnostics<cr>
	nnoremap <leader>xd <cmd>TroubleToggle document_diagnostics<cr>
	nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
	nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
	nnoremap <leader>xr <cmd>TroubleRefresh<cr>
	nnoremap gR <cmd>TroubleToggle lsp_references<cr>

	command! -nargs=1 -complete=dir FixTSExpectError :lua require('stripe.ts-lint-expect-error').findTsExpectErrors(<f-args>)<CR>
]])
