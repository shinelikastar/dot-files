-- Adds two menubar items to show the 2fa and pay up status
-- Also shows cibot PRs that need reviewing

menuRefreshRate = 10 -- how often to refresh the menubar (in seconds)

local function rgba(r, g, b, a)
  a = a or 1.0

  return {
    red = r / 255,
    green = g / 255,
    blue = b / 255,
    alpha = a
  }
end

local function hex(value, a)
  return rgba(
    tonumber("0x" .. string.sub(value, 1, 2)),
    tonumber("0x" .. string.sub(value, 3, 4)),
    tonumber("0x" .. string.sub(value, 5, 6)),
    a or 1.0
  )
end

local function createCircle(color)
  local canvas = hs.canvas.new{h = 16, w = 16}

  canvas:insertElement({
    type = "circle",
    id = "indicator",
    radius = "33%",
    fillColor = color,
  })

  return canvas:imageFromCanvas()
end

local function createCircleIcon(up)
  if up then
    return createCircle(hex("3ecf8e")) -- green
  else
    return createCircle(hex("e25950")) -- red
  end
end

local function createStatusMenu(opts)
  local refreshRate = opts.refreshRate or menuRefreshRate
  local title = opts.title or "title"
  local refreshIcon = opts.refreshIcon

  local menubar = hs.menubar.new()

  local setIcon = function(icon)
    menubar:setIcon(icon, false)
  end

  if opts.onClick then
    menubar:setClickCallback(opts.onClick)
  end

  menubar:setTitle(title)
  menubar:setIcon(createCircle(hex("cfd7df")), false)

  local timer = hs.timer.doEvery(refreshRate, function()
    refreshIcon(setIcon)
  end)

  -- run it once
  refreshIcon(setIcon)

  return {
    menubar = menubar,
    timer = timer
  }
end

-- Show a pay up status menu
payUpMenu = createStatusMenu({
  title = "pay up",
  refreshIcon = function(setIcon)
    local task = hs.task.new(
      "/usr/local/bin/pay",
      function(_, stdout)
        local connected = not not string.match(stdout, '"connected":true')
        setIcon(createCircleIcon(connected))
      end,
      {
        "up:status",
      }
    )

    task:start()
  end
})

-- Show a cibot unreviewed PRs count
local function createBadge(number)
  local iconSize = 16
  local canvas = hs.canvas.new{h = iconSize, w = iconSize}

  local zeroItems = number == "0"
  local strokeColor = zeroItems and hex("aab7c4") or hex("424770")
  local textColor = zeroItems and hex("6b7c93") or hex("f6f9fc")

  local circle = {
    type = "circle",
    radius = "46%",
    strokeColor = strokeColor,
  }

  if zeroItems then
    circle["fillColor"] = hex("cfd7df")
  else
    -- Fill a Stripe-y gradient
    -- https://design.corp.stripe.com/web-style/#colors
    circle["fillGradientAngle"] = 45
    circle["fillGradientCenter"] = { x = -0.5, y = -0.5 }
    circle["fillGradient"] = "linear"
    circle["fillGradientColors"] = {
      hex("555abf"),
      hex("6772e5"),
      hex("7795f8"),
    }
  end

  canvas:insertElement(circle, 1)

  canvas:insertElement(
    {
      type = 'text',
      text = number,
      action = 'fill',
      frame = {
        x = 0,
        y = 1,
        h = iconSize,
        w = iconSize,
      },
      textAlignment = "center",
      textColor = textColor,
      textFont = "Helvetica Bold",
      textSize = 10,
    },
    2
  )

  return canvas:imageFromCanvas()
end

cibotMenu = createStatusMenu({
  title = " cibot",
  onClick = function()
    -- Open the cibot page when you click the menubar item.
    hs.urlevent.openURL("https://cibot.corp.stripe.com/pulls")
  end,
  refreshRate = 60, -- update every minute
  refreshIcon = function(setIcon)
    local task = hs.task.new(
      "/bin/bash",
      function(_, stdout)
        -- p("exit: " .. exitCode)
        -- p("stdout: " .. stdout)
        -- p("err: " .. stderr)

        local reviewCount = string.gsub(stdout, "%s$", "") -- strip off the \n from shell output
        setIcon(createBadge(reviewCount))
      end,
      {
        "--login",
        "-c",
        -- Pull a JSON blob of your pull requests, and count the `pulls.reviews`
        os.getenv("HOME") .. "/stripe/space-commander/bin/sc-curl -s https://cibot.corp.stripe.com/user/pulls | jq -r '.pulls.reviews | length'",
      }
    )

    task:start()
  end
})




-- DISABLED FOR NOW
-- this is causing me ssh-agent problems I think
--
-- Show a 2fa status menu
-- sc2faMenu = createStatusMenu({
--   title = "2fa",
--   refreshIcon = function(setIcon)
--     local homeDir = os.getenv("HOME")

--     local task = hs.task.new(
--       "/usr/local/bin/zsh",
--       function(exitCode, stdout, stderr)
--         p("exitCode: " .. exitCode)
--         p("out: " .. stdout)
--         p("err: " .. stderr)

--         setIcon(createCircleIcon(exitCode == 0))
--       end,
--       {
--         "--login",
--         "-c",
--         "source " .. homeDir .. "/.bashrc && source " .. homeDir .. "/.bash_profile && /usr/local/bin/go-sc 2fa info",
--       }
--     )

--     task:start()
--   end
-- })


