-- General settings
hs.window.animationDuration = 0.1 -- Animation speed for moving windows

-- Split the screen in left/right halves
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", function()
      local win = hs.window.focusedWindow()
      local f = win:frame()

      local screen = win:screen()
      local max = screen:frame()

      f.x = max.x
      f.y = max.y
      f.w = max.w / 2
      f.h = max.h
      win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", function()
      local win = hs.window.focusedWindow()
      local f = win:frame()

      local screen = win:screen()
      local max = screen:frame()

      f.x = max.x + (max.w / 2)
      f.y = max.y
      f.w = max.w / 2
      f.h = max.h
      win:setFrame(f)
end)

-- new browser window
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "b", function()
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

-- new iterm2 window
hs.hotkey.bind({"cmd"}, "return", function()
      if hs.application.find("iTerm") then
	 hs.applescript.applescript([[
	    tell application "iTerm"
	    create window with default profile
	    end tell
	 ]])
      else
	 hs.application.open("iTerm")
      end
end)

-- Setup automatic installation of spoons
-- Technically, this should be the only one that requires manual installation
hs.loadSpoon("SpoonInstall")

spoon.SpoonInstall:andUse("ReloadConfiguration")
spoon.ReloadConfiguration:start()

hs.alert.show("Config loaded")
