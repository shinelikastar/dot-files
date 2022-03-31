local core = require('nvim-lsp-pay-server.core')
local statusLine = require('nvim-lsp-pay-server.status').statusLine

local payServer = {
  getStatus = core.getStatus,
  isRecovering = core.isRecovering,
  recoverFromExit = core.recoverFromExit,
  statusLine = statusLine,
}

return payServer
