-- Notes:
-- When using the keybind in combination with programmer-dvorak and a via keyboard to configuration,
-- you should use the actual keypress location on the keyboard.
-- For example, when pressing the "S" physical key on the keyboard, programmer-dvorak will output "O"
-- When setting the hotkey, the hotkey should be "O", while in VIA, the key should be "S".

-- General settings
hs.window.animationDuration = 0.1 -- Animation speed for moving windows

local logger = hs.logger.new("CZ Scripts", "debug")

local ghostty_width = 1024
local ghostty_height = 768

local function centerOnScreen(win, screen, w, h)
  local sf = screen:frame()
  w = math.min(w, sf.w)
  h = math.min(h, sf.h)

  local f = {
    x = sf.x + (sf.w - w) / 2,
    y = sf.y + (sf.h - h) / 2,
    w = w,
    h = h,
  }
  win:setFrame(f, 0)
end

local function alertLog(msg)
  logger.i(msg)
  hs.alert.show(msg)
end

local prefix = {"cmd", "alt", "ctrl"}
local s_prefix = {"cmd", "alt", "ctrl", "shift"}

-- sleep

hs.hotkey.bind(prefix, ";", function ()
  alertLog("Locking Screen @ " .. os.date("!%Y-%m-%dT%TZ"))
  hs.caffeinate.lockScreen()
end)

-- Split the screen in different directions

local function splitLeft()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end

local function splitRight()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end

local function splitUp()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f)
end


local function splitDown()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y + (max.h / 2)
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f)
end

hs.hotkey.bind(prefix, "Left", splitLeft)
hs.hotkey.bind(prefix, "Down", splitDown)
hs.hotkey.bind(prefix, "Up", splitUp)
hs.hotkey.bind(prefix, "Right", splitRight)

hs.hotkey.bind(prefix, "Space", function ()
  local window = hs.window.focusedWindow()
  hs.grid.maximizeWindow(window)
end)

-- move window across spaces

local hotkey = require "hs.hotkey"
local window = require "hs.window"
local hse, hsee, hst = hs.eventtap,hs.eventtap.event,hs.timer
local spaces = require "hs.spaces"

function flashScreen(screen)
   local flash=hs.canvas.new(screen:fullFrame()):appendElements({
	 action = "fill",
	 fillColor = { alpha = 0.35, red=1},
	 type = "rectangle"})
   flash:show()
   hs.timer.doAfter(.25, function () flash:delete() end)
end

function switchSpace(skip,dir)
   for i=1,skip do
      hs.eventtap.keyStroke({"ctrl","fn"},dir,0) -- "fn" is a bugfix!
   end
end

function getGoodFocusedWindow(nofull)
   local win = window.focusedWindow()
   if not win or not win:isStandard() then return end
   if nofull and win:isFullScreen() then return end
   return win
end

function moveWindowOneSpace(dir,switch)
   local win = getGoodFocusedWindow(true)
   if not win then return end
   local screen=win:screen()
   local uuid=screen:getUUID()
   local userSpaces=nil
   for k,v in pairs(spaces.allSpaces()) do
      userSpaces=v
      if k==uuid then break end
   end
   if not userSpaces then return end

   for i, spc in ipairs(userSpaces) do
      if spaces.spaceType(spc)~="user" then -- skippable space
	 table.remove(userSpaces, i)
      end
   end
   if not userSpaces then return end

   local initialSpace = spaces.windowSpaces(win)
   if not initialSpace then return else initialSpace=initialSpace[1] end
   local currentCursor = hs.mouse.getRelativePosition()

   if (dir == "right" and initialSpace == userSpaces[#userSpaces]) or
      (dir == "left" and initialSpace == userSpaces[1]) then
      flashScreen(screen)   -- End of Valid Spaces
   else
      local zoomPoint = hs.geometry(win:zoomButtonRect())
      local safePoint = zoomPoint:move({-1,-1}).topleft
      hsee.newMouseEvent(hsee.types.leftMouseDown, safePoint):post()
      switchSpace(1, dir)
      hst.waitUntil(
	 function () return spaces.windowSpaces(win)[1]~=initialSpace end,
	 function ()
	    hsee.newMouseEvent(hsee.types.leftMouseUp, safePoint):post()
	    hs.mouse.setRelativePosition(currentCursor)
      end, 0.05)
   end
end

hs.hotkey.bind(s_prefix, "Q", function()
  moveWindowOneSpace("left", true)
end)

hs.hotkey.bind(s_prefix, "J", function()
  moveWindowOneSpace("right", true)
end)

hs.hotkey.bind(prefix, "q", nil, function()
  local direction = "left"
  local keyCode = direction == "left" and 123 or 124

  return hs.osascript.applescript([[
      tell application "System Events" 
          keystroke (key code ]] .. keyCode .. [[ using control down)
      end tell
  ]])
end)

hs.hotkey.bind(prefix, "j", nil, function()
  local direction = "right"
  local keyCode = direction == "left" and 123 or 124

  return hs.osascript.applescript([[
      tell application "System Events" 
          keystroke (key code ]] .. keyCode .. [[ using control down)
      end tell
  ]])
end)


-- moving between monitors
local function getSortedMonitors()
  local screens = hs.screen.allScreens()
  table.sort(screens, function(a, b)
    return a:frame().x < b:frame().x
  end)
  return screens
end

local function moveMonitor(direction)
  return function()
    local win = hs.window.focusedWindow()
    if not win or not win:isStandard() then
      hs.alert.show("No active window to move")
      return
    end

    local screens = getSortedMonitors()
    local screenCount = #screens

    if screenCount <= 1 then
      hs.alert.show("Only one monitor detected")
      return
    end

    local currentScreen = win:screen()
    local targetIndex = nil

    for i, screen in ipairs(screens) do
      if screen == currentScreen then
        -- hs.alert.show("Current screen " .. i .. " of " .. screenCount)
        targetIndex = i + direction
        if targetIndex > screenCount then
          flashScreen(currentScreen)   -- End of Valid Spaces
          return
        end
        if targetIndex < 1 then
          flashScreen(currentScreen)   -- End of Valid Spaces
          return
        end
        break
      end
    end

    if targetIndex then
      local targetScreen = screens[targetIndex]
      win:moveToScreen(targetScreen)

      local f = win:frame()

      local screen = win:screen()
      local max = screen:frame()

      f.x = max.x
      f.y = max.y
      f.w = max.w
      f.h = max.h
      win:setFrame(f)
    end
  end
end


hs.hotkey.bind(prefix, ',', moveMonitor(-1))
hs.hotkey.bind(prefix, ".", moveMonitor(1))

-- center on screen pre defined width height
hs.hotkey.bind(prefix, "k", function ()
  local win = hs.window.focusedWindow()
  local screen = hs.screen.mainScreen()

  centerOnScreen(win, screen, ghostty_width, ghostty_height)
end)

-- new browser window
hs.hotkey.bind(prefix, "b", function()
  if hs.application.find("Brave Browser") then
    hs.applescript.applescript([[
    tell application "Brave Browser"
    make new window
      activate
    end tell
  ]])
else
  hs.application.open("Brave Browser")
end
end)

-- new terminal window

local function createGhosttyWindow()
  -- this needs to be here since after the new ghostty window, focused screen will change
  local targetScreen = hs.screen.mainScreen()

  local ghosttyBundleID = "com.mitchellh.ghostty"

  -- 1) Make sure Ghostty is running (may briefly activate it; that's fine)
  hs.application.launchOrFocusByBundleID(ghosttyBundleID)

  -- Small delay so the app is ready to receive AppleScript when launching cold
  hs.timer.doAfter(0.3, function()
    local app = hs.application.get(ghosttyBundleID)
    if not app then
      hs.alert.show("Ghostty not running (yet)")
      return
    end

    -- Create a new window via menu
    local ok = app:selectMenuItem({"File", "New Window"})
    if not ok then
      -- Fallback: activate and send Cmd+N
      app:activate(true)
      hs.eventtap.keyStroke({"cmd"}, "n", 0, app)
    end

    -- move window to current screen
    local tries, maxTries = 0, 60
    local poll
    poll = hs.timer.doEvery(0.05, function()
      tries = tries + 1

      local w = app:focusedWindow()
      if w then
        w:moveToScreen(targetScreen, false, true)
        centerOnScreen(w, targetScreen, ghostty_width, ghostty_height)
        w:focus()
        poll:stop()
        return
      end

      if tries >= maxTries then poll:stop() end
    end)
  end)
end

hs.hotkey.bind({"cmd"}, "return", function()
  -- hs.application.open("Ghostty")
  createGhosttyWindow()
end)

-- Deterministic input method switcher

hs.hotkey.bind({"cmd", "shift"}, "t", function()
  hs.keycodes.setLayout('Programmer Dvorak')
  hs.alert.show(hs.keycodes.currentLayout())
end)

hs.hotkey.bind({"cmd", "shift"}, "c", function()
  hs.keycodes.currentSourceID("im.rime.inputmethod.Squirrel.Hans")
  hs.execute [["/Library/Input Methods/Squirrel.app/Contents/MacOS/Squirrel" "--reload"]]
  -- hs.alert.show(hs.keycodes.currentSourceID())
  hs.alert.show('Squirrel - Rime')
end)

hs.hotkey.bind({"cmd", "shift"}, "d", function()
  hs.keycodes.setLayout('ABC')
  hs.alert.show(hs.keycodes.currentLayout())
end)


-- Setup automatic installation of spoons
-- Technically, this should be the only one that requires manual installation
hs.loadSpoon("SpoonInstall")

spoon.SpoonInstall:andUse("ReloadConfiguration")
spoon.ReloadConfiguration:start()

hs.alert.show("Config loaded")
