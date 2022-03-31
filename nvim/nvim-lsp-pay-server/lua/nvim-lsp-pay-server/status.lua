local core = require('nvim-lsp-pay-server.core')
local M = {}

local defaultGlyphs = {
  ok = "pay up",
  spinnerFrames = { '-', '\\', '|', '/' },
}

local nerdFontGlyphs = {
  spinnerFrames = { '⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷' },
  ok = "✔️",
}

M.statusLine = function(options)
  options = options or {}
  local glyphs = defaultGlyphs

  if options.nerdFonts then
    glyphs = nerdFontGlyphs
  end

  return function()
    if core.isRecovering() then
      local status = core.getStatus()
      local contents = ""
      local spinnerFrames = glyphs.spinnerFrames

      if status.spinner then
        contents = contents .. spinnerFrames[(status.spinnerCount % #spinnerFrames) + 1] .. ' '
      end

      return contents .. status.message
    else
      return glyphs.ok
    end
  end
end

return M
