local M = {}

M.shouldShowStatus = function()
  local currentDir = vim.fn.expand('%:p:h')
  local inPayServer = not not currentDir:match("/pay%-server/")

  return inPayServer
end

-- Adapted https://github.com/TravonteD/luajob/blob/master/lua/luajob.lua
M.execAsync = function(cmd, args, callbacks)
  callbacks = callbacks or {}
  local onStdout = callbacks.onStdout
  local onStderr = callbacks.onStderr
  local onExit = callbacks.onExit

  local closeHandle = function(handle)
    if not handle then return end

    if not handle:is_closing() then
      handle:close()
    end
  end

  local stdin = vim.loop.new_pipe(false)
  local stdout = vim.loop.new_pipe(false)
  local stderr = vim.loop.new_pipe(false)

  local options = {
    args = args,
    stdio = {
      stdin,
      stdout,
      stderr,
    },
  }

  local jobHandle = nil

  local onShutdown = function(code, signal)
    if onExit then onExit(code, signal) end
    if onStdout then stdout:read_stop() end
    if onStderr then stderr:read_stop() end

    closeHandle(stdin)
    closeHandle(stdout)
    closeHandle(stderr)
    closeHandle(jobHandle)
  end

  jobHandle = vim.loop.spawn(cmd, options, vim.schedule_wrap(onShutdown))

  if onStdout then stdout:read_start(vim.schedule_wrap(onStdout)) end
  if onStderr then stderr:read_start(vim.schedule_wrap(onStderr)) end
end

return M
