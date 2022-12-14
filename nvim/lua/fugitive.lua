-- Every time you open a git object using fugitive it creates a new buffer.
-- This means that your buffer listing can quickly become swamped with
-- fugitive buffers. This prevents this from becomming an issue:
vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
  pattern = { 'fugitive://*' },
  callback = function()
    vim.cmd([[set bufhidden=delete]])
  end,
})

vim.cmd([[
	" Fix :Gbrowse, etc in fugitive
	let g:github_enterprise_urls = ['https://git.corp.stripe.com']

	" get GHE link of selected lines
	vnoremap <leader>g :GBrowse!<CR>
]])
