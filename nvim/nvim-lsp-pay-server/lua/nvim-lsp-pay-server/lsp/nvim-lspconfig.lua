local payServer = require('nvim-lsp-pay-server')
local utils = require('nvim-lsp-pay-server/utils')

local M = {}

-- `on_exit` handler for a LSP definition in nvim-lspconfig
M.handleExit = function(code)
  if code > 0 then
    payServer.recoverFromExit(function()
      -- :w + :e will reload the LSP server.
      vim.api.nvim_command('silent write')
      vim.api.nvim_command('e')

      -- Clear out the "Wrote [file]" message
      vim.api.nvim_command('echo')
    end)
  end
end

M.shouldShowStatus = utils.shouldShowStatus

return M
