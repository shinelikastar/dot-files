require "status-menubar"
require "slack"

local hyper = {'cmd', 'alt', 'ctrl', 'shift'}

-- Load and create a new switcher
local HyperKey = hs.loadSpoon("HyperKey")
hyperKey = HyperKey:new(hyper)

-- Bind some applications to keys
hyperKey
  :bind('c'):toApplication('/Applications/Google Chrome.app')
  :bind('s'):toApplication('/Applications/Slack.app')
  :bind('t'):toApplication('/Applications/iTerm.app')

-- Bind some functions to keys
local reloadHammerspoon = function()
  hs.application.launchOrFocus("Hammerspoon")
  hs.reload()
end

hyperKey
  :bind('h'):toFunction("Reload Hammerspoon", reloadHammerspoon)
  :bind('l'):toFunction("Lock screen", hs.caffeinate.startScreensaver)

require "rich-link-copy"
require "pairing-mode"
