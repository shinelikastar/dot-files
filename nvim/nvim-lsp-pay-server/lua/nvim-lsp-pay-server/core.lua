local M = {}
local execAsync = require('nvim-lsp-pay-server.utils').execAsync

local function buildStatus(message, spinner)
  spinner = not not spinner

  return {
    message = message,
    spinner = spinner,
    spinnerCount = 0,
  }
end

local defaultStatus = buildStatus('', false)

local state = {
  recovering = false,
  status = defaultStatus,
}

local triggerRender

triggerRender = function()
  if state.recovering then
    if state.status and state.status.spinner then
      state.status.spinnerCount = state.status.spinnerCount + 1
    end

    vim.api.nvim_command('doautocmd User PayStatusUpdated')
    vim.defer_fn(triggerRender, 100)
  end
end

local function setRecovering(recovering)
  state.recovering = recovering

  if recovering then
    vim.defer_fn(triggerRender, 100)
  else
    state.status = defaultStatus
  end
end

local function checkFor2fa(callbacks)
  execAsync("sc-2fa", {'info'}, {
    onStdout = function(_, data)
      if data then
        callbacks.onSuccess()
      end
    end,
    onStderr = function(_, data)
      if data then
        callbacks.onFailure()
      end
    end
  })
end

local function waitFor2fa(onSuccess)
  execAsync("sc-2fa", {}, {
    onStderr = function(_, data)
      if data then
        state.status = buildStatus("Tap security key", true)
      end
    end,
    onExit = function()
      onSuccess()
    end
  })
end

local function checkForPayUp(callbacks)
  execAsync("pay", {"up:status"}, {
    onStdout = function(_, data)
      if data then
        local json = vim.fn.call("json_decode", {data})
        local isConnected = json['status'] and json['status']['connected']

        if isConnected then
          callbacks.onSuccess()
        else
          callbacks.onFailure()
        end
      end
    end
  })
end

M.recoverFromExit = function(onRecovery)
  onRecovery = onRecovery or function() end
  setRecovering(true)

  local checkPayUp = function()
    state.status = buildStatus("Waiting for `pay up`", true)

    local timer

    timer = vim.fn.timer_start(
      100,
      function()
        vim.fn.timer_pause(timer, true) -- pause the timer

        checkForPayUp({
          onSuccess = function()
            vim.fn.timer_stop(timer)

            state.status = buildStatus("Restarting LSP", true)
            onRecovery()

            -- In 1.5 seconds, clear the "Restarting LSP" message
            vim.defer_fn(
              function() setRecovering(false) end,
              1500
            )
          end,
          onFailure = function()
            vim.fn.timer_pause(timer, false) -- unpause and take it around again
          end,
        })
      end,
      {
        ["repeat"] = -1,
      }
    )
  end

  state.status = buildStatus("Checking 2FA", false)

  checkFor2fa({
    onSuccess = checkPayUp,
    onFailure = function()
      waitFor2fa(checkPayUp)
    end
  })
end

M.isRecovering = function()
  return state.recovering
end

M.getStatus = function()
  return state.status
end

return M
